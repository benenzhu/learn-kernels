# All-Reduce Benchmark: MiniMax-M2.5 on MI325X TP8

## 硬件配置

| 项目 | 规格 |
|------|------|
| GPU | 8x AMD Instinct MI325X (gfx950, 295GB HBM3e) |
| 互联 | XGMI 全连接 (weight=15), 每条 link ~52 GB/s 单向 |
| 聚合带宽 | 7 links × ~52 GB/s ≈ 366 GB/s 单向 per GPU |
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

Bus bandwidth 计算公式: `busbw = data_size × 2 × (N-1)/N / latency`, N=8

### conc4 (decode, 4 tokens)

| AR call | Shape | dtype | Size | nccl (us) | aiter (us) | vllm (us) | nccl BW | aiter BW | vllm BW |
|---------|-------|-------|------|-----------|------------|-----------|---------|----------|---------|
| AR#1 QK_var | (4, 2) | f32 | 32 B | 51.4 | 27.4 | 21.8 | 0.0 GB/s | 0.0 GB/s | 0.0 GB/s |
| AR#2 o_proj | (4, 3072) | bf16 | 24 KiB | 36.1 | 19.3 | 12.5 | 1.2 GB/s | 2.2 GB/s | 3.4 GB/s |
| AR#3 MoE | (4, 3072) | bf16 | 24 KiB | 36.0 | 15.2 | 12.6 | 1.2 GB/s | 2.8 GB/s | 3.4 GB/s |
| **LAYER TOTAL** | | | | **123.4** | **61.9** | **46.9** | | | |

### conc256 (decode, 256 tokens)

| AR call | Shape | dtype | Size | nccl (us) | aiter (us) | vllm (us) | nccl BW | aiter BW | vllm BW |
|---------|-------|-------|------|-----------|------------|-----------|---------|----------|---------|
| AR#1 QK_var | (256, 2) | f32 | 2 KiB | 30.7 | 14.8 | 12.3 | 0.1 GB/s | 0.2 GB/s | 0.3 GB/s |
| AR#2 o_proj | (256, 3072) | bf16 | 1.5 MiB | 44.7 | 20.4 | 30.3 | 61.6 GB/s | 134.9 GB/s | 90.8 GB/s |
| AR#3 MoE | (256, 3072) | bf16 | 1.5 MiB | 44.5 | 20.4 | 30.2 | 61.9 GB/s | 134.9 GB/s | 91.1 GB/s |
| **LAYER TOTAL** | | | | **119.9** | **55.6** | **72.8** | | | |

### conc16384 (decode, 16384 tokens)

| AR call | Shape | dtype | Size | nccl (us) | aiter (us) | vllm (us) | nccl BW | aiter BW | vllm BW |
|---------|-------|-------|------|-----------|------------|-----------|---------|----------|---------|
| AR#1 QK_var | (16384, 2) | f32 | 128 KiB | 31.6 | 15.0 | 14.7 | 7.3 GB/s | 15.3 GB/s | 15.6 GB/s |
| AR#2 o_proj | (16384, 3072) | bf16 | 96 MiB | 555.2 | 480.9 | 761.6 | 317.3 GB/s | 366.3 GB/s | 231.3 GB/s |
| AR#3 MoE | (16384, 3072) | bf16 | 96 MiB | 554.8 | 480.8 | 761.3 | 317.5 GB/s | 366.4 GB/s | 231.4 GB/s |
| **LAYER TOTAL** | | | | **1141.6** | **976.8** | **1537.5** | | | |

## 总结: 每层 All-Reduce 耗时

| 场景 | nccl | aiter | vllm | 最快 | vs nccl |
|------|------|-------|------|------|---------|
| conc4 (48 KB/层) | 123.4 us | 61.9 us | **46.9 us** | vllm | 2.6x |
| conc256 (3 MB/层) | 119.9 us | **55.6 us** | 72.8 us | aiter | 2.2x |
| conc16384 (192 MB/层) | 1141.6 us | **976.8 us** | 1537.5 us | aiter | 1.17x |

## 分析

### 性能特征

1. **Latency-bound (conc4, <100KB)**
   - custom AR 比 NCCL 快 2-3 倍: P2P 直接读写避免了 RCCL 协议栈开销
   - vllm 在极小 tensor 上最快 (47 us/层), 1-stage 算法少一次 barrier
   - aiter 居中 (62 us/层)

2. **Transition zone (conc256, ~1.5MB)**
   - aiter 最快 (56 us/层), 比 NCCL 快 2.2x
   - 134.9 GB/s busbw, 已开始利用 XGMI 带宽但远未饱和
   - vllm 此区间不如 aiter (73 us vs 56 us)

3. **Bandwidth-bound (conc16384, 96MB)**
   - aiter 最快 (977 us/层), 366 GB/s busbw, 达到 XGMI 峰值 (**~100% 利用率**)
   - NCCL 居中 (1142 us/层), 317 GB/s, 87% 利用率
   - vllm 最慢 (1538 us/层), 231 GB/s, 仅 63% — 2-stage 同步开销或 kernel 效率问题

### 瓶颈定位

- conc4 decode: 每层 all-reduce 仅 47-123 us, 不是推理瓶颈
- conc16384 decode: 每层 ~1 ms (aiter), 62 层模型总计 ~60 ms, 是显著开销
- AR#1 (QK variance) 数据量极小 (<128KB), 每次 15-50 us 纯 latency 开销, 三次 AR 中性价比最低
