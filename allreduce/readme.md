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

## vLLM 优化方向

### 1. AR#1 QK variance: float32 → bf16 或消除

当前 `MiniMaxText01RMSNormTP.forward_qk()` 用 float32 做 variance all-reduce:
```python
variance = x.pow(2).mean(dim=-1, keepdim=True, dtype=torch.float32)
variance = tensor_model_parallel_all_reduce(variance) / self.tp_world
```

问题:
- 32B (conc4) 的 float32 tensor 做 all-reduce, NCCL 耗时 48 us, 占每层总耗时的 40%
- vllm custom AR 的 `packed_t<float>` 路径 pack 为 `array_t<float, 4>` (16B), 相比 bf16 的 `array_t<bf16, 8>` 元素数减半

优化方案:
- **方案 A**: variance 用 bf16 计算+通信, 精度够用 (RMSNorm variance 不需要高精度)
- **方案 B**: 将 q_var/k_var 和 o_proj 的 all-reduce **合并为一次调用**, 把 variance 拼接到 attn output 后面一起 reduce, 省掉一次完整的 barrier + kernel launch
- **方案 C**: 参考 aiter 的 `fused_allreduce_rmsnorm` 把 QK norm 融合

### 2. 大 tensor 带宽差距: 向 aiter 借鉴 kernel

conc16384 (96 MiB) 场景 vllm 仅 231 GB/s vs aiter 367 GB/s, 差距 **1.59x**。

vllm 的 `custom_all_reduce.cuh` 问题:
- 2-stage 算法每个 GPU 需要读写 tmp_buf (Signal 结构后面的空间), 增加了一次额外的显存读写
- barrier 用 volatile load spin-wait, 没有利用 ROCm 的 `__scoped_atomic` 优化
- `defaultBlockLimit = 16` (ROCm), 而 aiter 可能用了更多 block 或不同的 grid 配置

aiter 可借鉴的实现:
- **`all_reduce_asm_`**: aiter 有手写 ASM kernel 版本, 可能是大 tensor 性能领先的关键
- **`use_new=True`**: aiter 的 `all_reduce` 接口有 `use_new` 参数, 切换到优化后的新算法
- **`open_fp8_quant=True`**: 通信前量化到 FP8, 传输量减半, 适合 bandwidth-bound 场景

具体行动:
- 对比 vllm 和 aiter 的 C++ kernel 源码 (`custom_all_reduce.cuh`), 重点看 2-stage 的数据搬运模式差异
- 考虑引入 aiter 的 ASM kernel 路径 (`all_reduce_asm_`)

### 3. Fused AR+RMSNorm: aiter 已实现, vllm 未用

aiter 提供了多个融合 kernel:

| aiter API | 功能 | vllm 对应 |
|-----------|------|----------|
| `fused_allreduce_rmsnorm` | AR + residual + RMSNorm | 无 (分开调用) |
| `all_reduce_rmsnorm_` | AR + RMSNorm (ASM) | 无 |
| `all_reduce_rmsnorm_quant_` | AR + RMSNorm + FP8 quant | 无 |

MiniMax-M2.5 每层结构: `AR → residual add → RMSNorm → MLP/MoE`

如果 AR#2 (o_proj) 与后续的 `post_attention_layernorm` 融合:
- 省掉一次 global memory 读写 (3072 × tokens × 2B)
- 省掉一次 kernel launch (~5 us)
- conc256 场景预计从 30 us 降到 ~20 us (接近 aiter)

### 4. conc256 中间区间: 1-stage vs 2-stage 阈值调优

vllm 在 conc256 (1.5 MiB) 比 aiter 慢 1.5x (30 us vs 20 us):
- vllm 的切换阈值: `world_size <= 8 && bytes < 256 KiB` 用 1-stage, 否则 2-stage
- 1.5 MiB 走的是 2-stage, 但这个 size 的 2-stage 可能不如 1-stage
- 需要在 MI355X 上重新 sweep 阈值, 找到最优切换点

### 5. 优先级排序

| 优先级 | 优化项 | 预期收益 | 难度 |
|--------|--------|---------|------|
| P0 | 借鉴 aiter kernel 优化大 tensor AR | conc16384 从 763→480 us (**37%↓**) | 中 |
| P1 | Fused AR+RMSNorm | 每层省 1 次 kernel launch + 1 次 memory round-trip | 中 |
| P1 | AR#1 合并到 AR#2 | 每层省 1 次 AR 调用 (~15 us) | 低 |
| P2 | 1-stage/2-stage 阈值调优 | conc256 从 30→20 us | 低 |
| P2 | FP8 量化通信 | 大 tensor 传输量减半 | 中 |
