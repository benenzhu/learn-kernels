# All-Reduce Benchmark: MiniMax-M2.5 on MI355X TP8

## 硬件配置

| 项目 | 规格 |
|------|------|
| GPU | 8x AMD Instinct MI355X OAM (CDNA 4, gfx950, 256 CU, 288GB HBM3e) |
| 互联 | XGMI 全连接 (weight=15), 7x Infinity Fabric links |
| 每条 link | 153.6 GB/s 双向 (76.8 GB/s 单向) |
| 单 GPU 聚合 | 7 × 76.8 = 537.6 GB/s 单向 |
| CPU | AMD EPYC 9575F 64-Core |
| TP | 8 |

## 模型参数 (MiniMax-M2.5)

| 参数 | 值 |
|------|-----|
| hidden_size | 3072 |
| num_attention_heads | 48 |
| num_key_value_heads | 8 |
| head_dim | 128 |
| num_local_experts | 256 |
| num_experts_per_tok | 8 |
| intermediate_size | 1536 (per expert) |
| dtype | bfloat16 |

## 每层 All-Reduce 调用

每个 Decoder Layer 有 **3 次 all-reduce**:

| # | 位置 | 原因 | 数据形状 | dtype |
|---|------|------|---------|-------|
| AR#1 | `MiniMaxText01RMSNormTP.forward_qk()` | QK Norm 跨 TP 同步 variance | (tokens, 2) | float32 |
| AR#2 | `RowParallelLinear` (o_proj) | Attention 输出归约 | (tokens, 3072) | bfloat16 |
| AR#3 | `MiniMaxM2MoE.forward()` | MoE 专家输出归约 | (tokens, 3072) | bfloat16 |

## Benchmark 结果

测试三种 all-reduce 实现:
- **nccl**: `torch.distributed.all_reduce` (RCCL)
- **aiter**: AMD aiter 库 custom all-reduce (P2P, 2-stage)
- **vllm**: vLLM custom all-reduce (P2P, 1-stage/2-stage)

计时方式: CUDA Event (纯 GPU 耗时, 去除 CPU launch overhead)

Bus bandwidth 计算: `busbw = data_size × 2 × (N-1)/N / latency`, N=8, 系数=1.75

### conc4 (decode, 4 tokens)

| AR call | Shape | dtype | Size | nccl (us) | aiter (us) | vllm (us) | nccl BW | aiter BW | vllm BW |
|---------|-------|-------|------|-----------|------------|-----------|---------|----------|---------|
| AR#1 QK_var | (4, 2) | f32 | 32 B | 48.1 | 14.5 | 17.6 | 0.0 GB/s | 0.0 GB/s | 0.0 GB/s |
| AR#2 o_proj | (4, 3072) | bf16 | 24 KiB | 36.0 | 15.2 | 12.7 | 1.2 GB/s | 2.8 GB/s | 3.4 GB/s |
| AR#3 MoE | (4, 3072) | bf16 | 24 KiB | 36.1 | 15.2 | 12.8 | 1.2 GB/s | 2.8 GB/s | 3.4 GB/s |
| **LAYER TOTAL** | | | | **120.1** | **44.9** | **43.1** | | | |

### conc256 (decode, 256 tokens)

| AR call | Shape | dtype | Size | nccl (us) | aiter (us) | vllm (us) | nccl BW | aiter BW | vllm BW |
|---------|-------|-------|------|-----------|------------|-----------|---------|----------|---------|
| AR#1 QK_var | (256, 2) | f32 | 2 KiB | 30.9 | 25.2 | 24.5 | 0.1 GB/s | 0.1 GB/s | 0.1 GB/s |
| AR#2 o_proj | (256, 3072) | bf16 | 1.5 MiB | 44.8 | 20.3 | 30.4 | 61.4 GB/s | 135.6 GB/s | 90.5 GB/s |
| AR#3 MoE | (256, 3072) | bf16 | 1.5 MiB | 44.7 | 20.4 | 30.4 | 61.6 GB/s | 134.9 GB/s | 90.5 GB/s |
| **LAYER TOTAL** | | | | **120.4** | **65.9** | **85.4** | | | |

### conc16384 (decode, 16384 tokens)

| AR call | Shape | dtype | Size | nccl (us) | aiter (us) | vllm (us) | nccl BW | aiter BW | vllm BW |
|---------|-------|-------|------|-----------|------------|-----------|---------|----------|---------|
| AR#1 QK_var | (16384, 2) | f32 | 128 KiB | 31.5 | 15.1 | 14.6 | 7.3 GB/s | 15.2 GB/s | 15.7 GB/s |
| AR#2 o_proj | (16384, 3072) | bf16 | 96 MiB | 554.2 | 480.4 | 763.2 | 317.9 GB/s | 366.7 GB/s | 230.8 GB/s |
| AR#3 MoE | (16384, 3072) | bf16 | 96 MiB | 553.5 | 480.2 | 762.9 | 318.3 GB/s | 366.8 GB/s | 230.9 GB/s |
| **LAYER TOTAL** | | | | **1139.3** | **975.6** | **1540.7** | | | |

## 总结: 每层 All-Reduce 耗时

| 场景 | nccl | aiter | vllm | 最快 | vs nccl |
|------|------|-------|------|------|---------|
| conc4 (48 KiB/层) | 120.1 us | 44.9 us | **43.1 us** | vllm | 2.8x |
| conc256 (3 MiB/层) | 120.4 us | **65.9 us** | 85.4 us | aiter | 1.8x |
| conc16384 (192 MiB/层) | 1139.3 us | **975.6 us** | 1540.7 us | aiter | 1.17x |

## 分析

### 性能特征

1. **Latency-bound (conc4, <100KB)**
   - custom AR 比 NCCL 快 ~2.8x: P2P 直接读写避免了 RCCL 协议栈开销
   - vllm 和 aiter 几乎持平 (43 vs 45 us/层)
   - AR#1/AR#2/AR#3 在 custom AR 上耗时一致 (~15 us), 说明纯 latency 下限

2. **Transition zone (conc256, ~1.5MB)**
   - aiter 最快 (66 us/层), 比 NCCL 快 1.8x
   - 135 GB/s busbw, 已开始利用 Infinity Fabric 带宽但远未饱和 (25%)
   - vllm 此区间不如 aiter (85 us vs 66 us)

3. **Bandwidth-bound (conc16384, 96MB)**
   - aiter 最快 (976 us/层), 367 GB/s busbw, 68% Infinity Fabric 利用率 (峰值 537.6 GB/s)
   - NCCL 居中 (1139 us/层), 318 GB/s, 59% 利用率
   - vllm 最慢 (1541 us/层), 231 GB/s, 43% 利用率
   - 均有较大优化空间, MI355X 的 Infinity Fabric 带宽远未跑满

### 与 NVIDIA 平台对比

| | MI355X (实测) | H200 NVLink4 | B200 NVLink5 |
|---|---|---|---|
| 互联单向峰值 | 537.6 GB/s | 450 GB/s | 900 GB/s |
| 大 tensor busbw | 367 GB/s | ~475 GB/s | ~400 GB/s |
| 利用率 | 68% | ~105% (SHARP) | ~44% |

- H200 通过 NVLink SHARP (reduce offload 到 NVSwitch) 实测 busbw 超过理论峰值
- MI355X 和 B200 均有较大优化空间

### 瓶颈定位

- conc4 decode: 每层 all-reduce 仅 43-120 us, 不是推理瓶颈
- conc16384 decode: 每层 ~1 ms (aiter), 62 层模型总计 ~60 ms, 是显著开销
- AR#1 (QK variance) 数据量极小 (<128KB), 每次 15-31 us 纯 latency 开销, 三次 AR 中性价比最低
