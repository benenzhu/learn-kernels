# MiniMax-M2.5 单 Decode Layer Kernel 序列

TP=2, bs=1 decode, eager mode (level=0), 120 层平均

## 总览

- **38 个 GPU kernel / layer**
- **336.3 us / layer** (eager, 含 CPU launch overhead)
- **× 62 layers = 20.9 ms / step** (eager)
- **对比 level=3 CUDA graph: ~700 us / step = 11.3 us / layer**（graph 消除了 kernel launch gap）

## Kernel 序列 (从前到后)

### Attention Block

```
Step  Kernel                                     耗时(us)   占比    功能
────  ─────────────────────────────────────────  ────────  ──────  ────────────────────────────
 [0]  pa_bf16_pertokenFp8_gqa8_2tg_4w             42.5    12.6%   Paged Attention (GQA, FP8 KV)
 [1]  dynamic_per_group_scaled_quant (FP8)          4.8     1.4%   attn output → FP8 量化
 [2]  gemm_blockscale_b_preshuffle (CK)            12.4     3.7%   o_proj GEMM [M,3072]×[3072,1536]
 [3]  reduce_scatter_cross_device_store             16.4     4.9%   TP allreduce (attention output)
 [4]  local_device_load_rmsnorm                     4.8     1.4%   fused: load remote + RMSNorm (post-attn)
                                                  ──────
                                       Subtotal:  80.9    24.1%
```

### MoE Block

```
Step  Kernel                                     耗时(us)   占比    功能
────  ─────────────────────────────────────────  ────────  ──────  ────────────────────────────
 [5]  bfloat16tofloat32_copy                        5.4     1.6%   gate input BF16→FP32 cast
 [6]  Cijk_Alik_Bljk (rocBLAS)                     12.7     3.8%   gate GEMM [M,3072]×[3072,256] → router logits
 [7]  grouped_topk_kernel                           7.0     2.1%   top-8 expert 选择 + softmax weight
 [8]  MoeSortingKernel (CK tile)                    8.1     2.4%   token→expert 排序 (生成 sorted indices)
 [9]  dynamic_per_group_scaled_quant (FP8)          4.7     1.4%   MoE input → FP8 量化
[10]  kernel_moe_gemm (CK, stage1)                 21.1     6.3%   up_proj + gate_proj GEMM (fused, 所有 active experts)
[11]  dynamic_per_group_scaled_quant (FP8)          4.8     1.4%   intermediate → FP8 量化 (for down_proj)
[12]  kernel_moe_gemm (CK, stage2)                  7.8     2.3%   down_proj GEMM (所有 active experts)
[13]  reduce_scatter_cross_device_store              9.2     2.7%   TP allreduce (MoE output)
[14]  local_device_load_rmsnorm                      5.0     1.5%   fused: load remote + RMSNorm (post-MoE)
                                                  ──────
                                       Subtotal:  85.8    25.5%
```

### QKV Projection (下一层准备)

```
Step  Kernel                                     耗时(us)   占比    功能
────  ─────────────────────────────────────────  ────────  ──────  ────────────────────────────
[15]  dynamic_per_group_scaled_quant (FP8)          4.7     1.4%   hidden → FP8 量化 (for qkv proj)
[16]  gemm_blockscale_b_preshuffle (CK)            12.0     3.6%   qkv_proj GEMM [M,3072]×[3072,2048]
                                                  ──────
                                       Subtotal:  16.7     5.0%
```

### QK-Norm (RoPE 准备)

```
Step  Kernel                                     耗时(us)   占比    功能
────  ─────────────────────────────────────────  ────────  ──────  ────────────────────────────
[17]  bfloat16tofloat32_copy                        4.8     1.4%   Q BF16→FP32
[18]  bfloat16tofloat32_copy                        5.7     1.7%   K BF16→FP32
[19]  pow_tensor_cuda                               5.5     1.6%   Q² (for QK-norm)
[20]  reduce_kernel (mean)                          5.9     1.8%   mean(Q²) = variance
[21]  pow_tensor_cuda                               5.3     1.6%   K²
[22]  reduce_kernel (mean)                          4.9     1.5%   mean(K²) = variance
[23]  CatArrayBatchedCopy                           5.7     1.7%   concat Q_norm, K_norm
[24]  ncclDevKernel_Generic (NCCL)                 16.1     4.8%   allreduce (QK-norm sync)
                                                  ──────
                                       Subtotal:  53.9    16.0%
```

### RoPE + KV Cache

```
Step  Kernel                                     耗时(us)   占比    功能
────  ─────────────────────────────────────────  ────────  ──────  ────────────────────────────
[25]  BUnaryFunctor (div)                           4.8     1.4%   normalize (÷ variance)
[26]  CUDAFunctorOnSelf_add                         4.7     1.4%   residual add
[27]  rsqrt_kernel                                  4.8     1.4%   1/√variance
[28]  elementwise_kernel (mul+cast)                 5.7     1.7%   apply norm weight + cast
[29]  BinaryFunctor (RoPE cos/sin mul)             29.8     8.9%   RoPE 旋转位置编码 (Q)
[30]  bfloat16_copy                                 4.8     1.4%   FP32→BF16 cast
[31]  CUDAFunctorOnSelf_add                         4.7     1.4%   residual add
[32]  rsqrt_kernel                                  4.7     1.4%   1/√variance
[33]  elementwise_kernel (mul+cast)                 5.6     1.7%   apply norm weight + cast
[34]  BinaryFunctor (RoPE cos/sin mul)             13.8     4.1%   RoPE 旋转位置编码 (K)
[35]  bfloat16_copy                                 5.5     1.6%   FP32→BF16 cast
[36]  kn_entry_2c_sbhd_cached_indirect              5.2     1.5%   RoPE fused 应用 (final)
[37]  reshape_and_cache_with_per_token_quant         4.9     1.5%   KV cache 写入 (FP8 量化)
                                                  ──────
                                       Subtotal:  99.0    29.4%
```

## 按模块汇总

```
模块                            Kernels    耗时(us)    占比      备注
──────────────────────────────  ────────  ────────  ──────  ──────────────────
Attention (PA + o_proj)              3      59.7    17.8%   PA 是最大单 kernel (42.5us)
MoE (gate + sort + gemm×2)          6      61.5    18.3%   stage1(21us) >> stage2(7.8us)
Communication (RS + NCCL)           3      41.7    12.4%   attn RS(16.4) > MoE RS(9.2)
QK-Norm                             8      53.9    16.0%   eager 下 8 个小 kernel, level=3 会 fuse
RoPE + KV cache                    11      99.0    29.4%   RoPE 最重 (29.8+13.8=43.6us)
FP8 Quant                           4      19.0     5.7%   4 次, 每次 ~4.8us
Other (cast, copy)                   3      16.0     4.8%
                                  ────    ──────
Total                               38    336.3
```

## 优化建议 (按收益排序)

### 1. RoPE: 29.8 + 13.8 = 43.6 us (13%)  ← 最大优化空间

eager 模式下 RoPE 拆成了 QK-norm(8 个) + RoPE(Q/K 各一套) = ~15 个小 kernel。
level=3 (compiled) 会 fuse 成 Triton kernel, 但仍有优化空间:
- **当前**: Q 和 K 的 RoPE 分开做 (29.8 + 13.8 us)
- **优化**: fuse Q+K RoPE 成单个 kernel, 共享 cos/sin table 读取
- **预期收益**: ~20 us → 节省 ~23 us/layer

### 2. PA (Paged Attention): 42.5 us (12.6%)

decode bs=1 时 PA 是最大单 kernel。
- **当前**: `pa_bf16_pertokenFp8_gqa8_2tg_4w` (GQA 8 heads, FP8 KV)
- **优化方向**:
  - Speculative decode (MTP) 可以用更大 batch amortize PA cost
  - 如果 KV cache 很长 (ISL=8k), PA 会更慢; prefix caching 可减少重复计算

### 3. MoE stage1 GEMM: 21.1 us (6.3%)

stage1 (up+gate fused) 比 stage2 (down) 慢 2.7×:
- stage1: [M, K=1536] × [K, N=3072] (up) + [M, K=1536] × [K, N=3072] (gate)
- stage2: [M, K=3072] × [K, N=1536]
- **优化**: 检查 CK MoE kernel 的 tile config 是否为此 shape tuned

### 4. Communication: 41.7 us (12.4%)

- Attention allreduce (16.4 us) > MoE allreduce (9.2 us)
- NCCL QK-norm sync (16.1 us) — 这可能可以和 attention allreduce overlap
- **优化**: 检查是否可以合并 attention RS 和 QK-norm NCCL 为单次通信

### 5. FP8 Quant: 19.0 us (5.7%)

4 次独立的 FP8 量化 (attn_out, moe_in, moe_inter, qkv_in):
- **优化**: fuse quant 到前一个 kernel 的 epilogue (如 CK GEMM output 直接写 FP8)

### 6. Gate GEMM (rocBLAS): 12.7 us (3.8%)

`Cijk_Alik_Bljk` 是 rocBLAS 的 FP32 GEMM for router:
- **优化**: gate weight 是 FP32 (精度需要), 但可以考虑 FP16 gate 如果精度允许
- 或者 fuse gate + topk 成单个 kernel

## 附: Compiled (level=3) vs Eager (level=0) 对比

```
                        Eager (level=0)    Compiled (level=3)   差异
Decode step (62 layers)     20.9 ms            ~0.7 ms          30× faster
Per layer                   336 us             ~11.3 us         30× faster
TPOT (bs=1)                 21.0 ms            14.2 ms          1.5× faster

差距来源:
  - Kernel launch overhead: eager 下每个 kernel ~3-5 us CPU dispatch
    38 kernels × ~4 us = ~150 us/layer 纯 launch overhead
  - Kernel fusion: compiled 模式下 QK-norm/RoPE 的 ~15 个小 kernel fuse 成 2-3 个 Triton kernel
  - CUDA graph: 消除所有 CPU-GPU 同步点
```
