# FP8 Block-Scale GEMM Benchmark

## Background

MiniMax-M2.5 attention `o_proj` (RowParallelLinear) 在 TP=8 下的 GEMM shape:
- Weight: `[N=3072, K=768]` (FP8, per-128x128 block-scale)
- Input:  `[M, K=768]` (BF16, 动态 per-1x128 量化为 FP8)
- Output: `[M, N=3072]` (BF16)

### RowParallelLinear TP Shape (o_proj)

o_proj 原始 shape: `Linear(6144, 3072)`，沿 input 维度切分，output 不变。

| TP | Weight [N, K] | Input [M, K] |
|----|--------------|--------------|
| 1  | [3072, 6144] | [M, 6144]    |
| 2  | [3072, 3072] | [M, 3072]    |
| 4  | [3072, 1536] | [M, 1536]    |
| 8  | [3072, 768]  | [M, 768]     |

### 量化方案 (DeepSeek style)

| 对象 | 粒度 | Scale shape | 原因 |
|------|------|-------------|------|
| Activation | per-1x128 | [M, K/128] | token 间分布差异大，需逐 token scale |
| Weight | per-128x128 | [N/128, K/128] | 权重分布稳定，粗粒度省开销 |

128 对齐 GPU Tensor Core tile，dequant 可融合进 GEMM 累加，零额外开销。

## Files

| File | Description |
|------|-------------|
| `test_fp8_gemm.py` | Benchmark: CK quant+gemm / CK gemm-only / fused triton / BF16, CUDA graph replay |
| `profile_fp8_gemm.py` | Single-run profiling (PyTorch profiler / rocprof) |
| `fp8_gemm_source_trace.md` | 完整源码调用链 (quant + CK GEMM + fused triton) |

## Benchmark Results

CUDA graph replay x100, `triton.testing.do_bench` median, batch_size 4~256.

```
o_proj TP=8: weight [3072, 768], CUDA graph replay x100
 batch |  CK q+g(us) |  CK gemm(us) |  fused(us) |  BF16(us) | fused/CK
------------------------------------------------------------------------
     4 |         8.5 |          7.4 |       30.2 |       6.9 |    0.28x
     8 |         8.5 |          7.4 |       30.3 |       7.1 |    0.28x
    16 |         8.8 |          7.6 |       30.4 |       7.1 |    0.29x
    32 |         9.2 |          7.8 |       30.9 |       9.2 |    0.30x
    64 |         9.3 |          8.1 |       31.7 |       9.4 |    0.29x
   128 |         9.5 |          8.1 |       34.0 |      10.3 |    0.28x
   256 |        11.0 |          9.8 |       34.1 |       9.8 |    0.32x
```

- **CK q+g**: aiter HIP quant kernel + CK `gemm_a8w8_blockscale` (端到端)
- **CK gemm**: CK `gemm_a8w8_blockscale` only (activation 已预量化)
- **fused**: triton `gemm_a16w8_blockscale` with `PREQUANT=True` (BF16 输入，kernel 内 fused quant+gemm)
- **BF16**: `torch.mm` baseline

## Conclusions

1. **CK quant 开销很小**: graph 下 quant 只占 ~1.1 us (8.5 - 7.4)，之前 do_bench 看到的 ~4 us 大部分是 CPU kernel launch overhead
2. **CK gemm 对小 batch 没有明显加速**: 小 M (4~16) 时 CK FP8 gemm (~7.4 us) 反而比 BF16 mm (~7.0 us) 略慢，因为 FP8 dequant 逻辑有额外开销，且矩阵太小无法充分利用 FP8 的计算密度优势
3. **Fused triton kernel 目前很慢 (~30 us)**: 比 CK 端到端慢 ~3.5x，原因：
   - 没有 tuned config（shape 3072x768 未出现在 tuned CSV 中）
   - Triton 生成的 FP8 dot 指令效率低于 CK 手写 XDL kernel
   - 但 fused 路径省掉了 activation 的 global memory round-trip，tune 后有潜力
4. **这个 shape (3072x768) 偏小**: K=768 意味着只有 768/128=6 个 scale group，计算量不大，各 kernel 都处于 launch-bound 区域

## Usage

```bash
# Benchmark
python bench_kernels/fp8_gemm/test_fp8_gemm.py

# Profile
python bench_kernels/fp8_gemm/profile_fp8_gemm.py
```
