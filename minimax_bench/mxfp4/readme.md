# MiniMax-M2.5 MXFP4 Benchmark & Profiling

## 环境

- **模型**: amd/MiniMax-M2.5-MXFP4 (Quark 量化, MXFP4 weights + dynamic FP4 input, e8m0 scale)
- **量化细节**: group_size=32, 前 62 层 attn + gate 保持原始精度 (exclude)
- **KV cache**: FP8
- **GPU**: 8× MI355X (gfx950, 288GB HBM each)
- **框架**: ATOM, aiter, CK, `--level 3` (piecewise CUDA graph)
- **ISL**: 8192, **OSL**: 512, `--random-range-ratio 0.8`

## 吞吐对比 (MXFP4 vs FP8, TP=4, conc=32)

| 指标 | FP8 tp4 | MXFP4 tp4 | 差异 |
|------|--------:|----------:|-----:|
| Output tok/s | 1189.0 | 1287.1 | **+8.2%** |
| Total tok/s | 20098.1 | 21755.5 | **+8.2%** |
| tok/s/GPU | 297.3 | 321.8 | **+8.2%** |
| TPOT p50 (ms) | 25.4 | 23.5 | **-7.5%** |
| TTFT p50 (ms) | 228.9 | 223.5 | -2.4% |
| E2EL p50 (ms) | 12073.2 | 11231.2 | -7.0% |
| Weights/GPU | ~108 GB | ~40 GB | **-63%** |

## Profiling (单请求, ISL ~7.3k)

| 指标 | FP8 tp4 | MXFP4 tp4 | 差异 |
|------|--------:|----------:|-----:|
| Prefill (ms) | ~60 | ~58 | -3% |
| Decode mean (us/step) | 790.9 | 599.5 | **-24%** |
| Decode min (us/step) | 615.5 | 509.1 | -17% |
| TPOT (ms, 单请求) | 14.3 | 12.8 | **-10.5%** |
| Kernels/layer | 25 | 23 | -2 |
| Per-layer (us, mean) | 228.9 | 203.6 | **-11.1%** |
| × 62 layers (ms) | 14.19 | 12.62 | **-11.1%** |

---

## 单 Decode Layer Kernel 序列 (TP=4, bs=1, PA-to-PA, 305 层统计)

### MXFP4 vs FP8 逐 kernel 对比

```
Pos  Kernel (简称)                  功能               MXFP4    FP8      差异
                                                      med(us)  med(us)
───  ─────────────────────────────  ──────────────── ─────── ─────── ──────────
 [0] pa_bf16_pertokenFp8_gqa8      Paged Attention    41.2    41.1   不变 (相同 KV cache)
 [1] bf16gemm_splitk / CK gemm     o_proj GEMM         9.2    ─┐
     dynamic_per_group_quant       FP8 quant           ──      │     MXFP4: 无 FP8 quant!
     gemm_blockscale_preshuffle    FP8 GEMM            ──     12.8    FP8 需要 quant+gemm 两步
                                                              ─┘     MXFP4 用 bf16 splitk gemm
 [2] reduce_scatter                attn allreduce     10.5     7.1   MXFP4 略慢 (+3.4us)
 [3] local_device_load_rmsnorm     fused load+norm     5.0     5.7   一样
 [4] triton_fused_copy             gate FP32 cast      4.9     5.6   一样
 [5] Cijk_Alik_Bljk (rocBLAS)     gate GEMM          12.0    12.7   一样 (FP32 保持)
 [6] grouped_topk_kernel           top-8 选择          7.0     7.1   一样
 [7] MoeSortingKernel              token→expert 排序   8.2     8.5   一样
 [8] FillFunctor (zero)            clear buffer        4.7     ──    MXFP4 多一个 zero-fill
 [9] MoeFlatmmKernel (stage1)      up+gate MXFP4       8.5    ─┐
     dynamic_per_group_quant       FP8 quant           ──      │     MXFP4: 用 MoeFlatmm
     kernel_moe_gemm (stage1)      FP8 MoE GEMM        ──    25.5    FP8: quant + CK MoE GEMM
                                                              ─┘     MXFP4 省掉 quant, GEMM 更快
[10] act_and_mul_kernel            SiLU activation      4.7     ──    MXFP4 显式 activation kernel
[11] MoeFlatmmKernel (stage2)      down_proj MXFP4      5.9    ─┐
     dynamic_per_group_quant       FP8 quant            ──     │     同上
     kernel_moe_gemm (stage2)      FP8 MoE GEMM         ──   12.7    MXFP4 更快
                                                              ─┘
[12] reduce_scatter                MoE allreduce      10.6     7.1   MXFP4 略慢
[13] local_device_load_rmsnorm     fused load+norm     5.0     5.7   一样
[14] Cijk_Alik_Bljk (rocBLAS)     qkv_proj GEMM      12.5    ─┐
     dynamic_per_group_quant       FP8 quant           ──      │     MXFP4: rocBLAS 直接 BF16/MXFP4
     gemm_blockscale_preshuffle    FP8 GEMM            ──    24.1    FP8: quant + CK gemm
                                                              ─┘     MXFP4 省掉 quant, 但 GEMM 用 rocBLAS
[15-20] QK-norm (6 Triton)        norm+RoPE 准备     ~32     ~34    基本相同
[21] kn_entry_2c_sbhd_cached      RoPE apply          5.0     5.7   一样
[22] reshape_and_cache_quant       KV cache FP8 写入   4.8     5.6   一样
```

### 按模块汇总

```
模块                        MXFP4 med(us)  FP8 med(us)   差异          原因
──────────────────────────  ────────────  ───────────  ──────────  ──────────────
Paged Attention [0]              41.2         41.1      不变        相同 FP8 KV cache
o_proj [1]                        9.2         12.8     -28%        无 FP8 quant, splitk gemm
MoE pipeline [4-11]              50.3         72.1     -30%        MoeFlatmm 省 quant, FP4 GEMM 更快
  ├─ gate GEMM [5]               12.0         12.7      不变       FP32 保持
  ├─ topk+sort [6-7]             15.2         15.6      不变
  ├─ stage1 [9]                   8.5         25.5     -67%        MoeFlatmm vs quant+CK_MoE
  ├─ stage2 [11]                  5.9         12.7     -54%        同上
  └─ activation [10]              4.7           ──     新增         显式 SiLU (FP8 fused 在 MoE 里)
qkv_proj [14]                    12.5         24.1     -48%        无 FP8 quant
QK-norm+RoPE [15-22]            ~42          ~46       -9%         基本相同
Communication [2,12,18]          36.2         28.2     +28%        MXFP4 通信略大
KV cache [22]                     4.8          5.6      不变
────────────────────────────────────────────────────
Total per layer                 203.6        228.9     -11.1%
× 62 layers                    12.62ms      14.19ms    -11.1%
```

### 关键差异分析

1. **MXFP4 省掉了所有 FP8 quant kernel** (FP8 有 4 次/layer × ~5us = 20us)
   - o_proj, MoE input, MoE intermediate, qkv input 都不需要动态量化
   - MXFP4 权重已预量化, activation 用硬件 MXFP4 指令

2. **MoE GEMM 用 MoeFlatmmKernel 替代 CK kernel_moe_gemm**
   - Stage1: 8.5 us vs 19.9+5.6 = 25.5 us (**-67%**)
   - Stage2: 5.9 us vs 7.1+5.6 = 12.7 us (**-54%**)
   - MoeFlatmm 可能利用了 CDNA4 的 MXFP4 原生 MFMA 指令

3. **Attention GEMM (o_proj, qkv) 用 rocBLAS BF16/splitk 替代 CK FP8 blockscale**
   - o_proj: 9.2 us vs 12.8 us (含 quant)
   - qkv: 12.5 us vs 24.1 us (含 quant) — **2× 加速!**
   - FP8 blockscale CK gemm 在小 shape 下效率低

4. **通信略慢** (+28%): MXFP4 output 可能 size 不同, 或 reduce_scatter 路径差异

5. **多出 2 个小 kernel**: FillFunctor (zero buffer) + act_and_mul (SiLU)
   - FP8 的 SiLU 被 fuse 在 MoE GEMM 内部
   - MXFP4 的 MoeFlatmm 不包含 activation, 需要单独做

---

## 文件列表

```
mxfp4/
├── readme.md                              # 本文档
└── results/
    ├── tp4_profile_server3.log            # server 启动日志
    └── trace_tp4/                         # torch profiler traces
```
