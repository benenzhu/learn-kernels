# MiniMax-M2.5 Kernel-Level Profiling Report

> Model: MiniMaxAI/MiniMax-M2.5 | TP=1 | GPU: MI355X | Level 3 (torch.compile + CUDA graph)
> ISL: 1024 / 8192 | OSL: 50 | Concurrency: 4, 8, 16, 32

## Top Kernels by Time %

### ISL=1024 (short prefill, decode-dominant)

| Kernel | Conc=8 avg(us) | Conc=16 avg(us) | Conc=32 avg(us) | Category |
|--------|---------------|----------------|----------------|----------|
| `fmoe_bf16_blockscaleFp8_g1u1_vs_silu` | 678 | 724 | 968 | MoE Expert GEMM (fused) |
| `kernel_moe_gemm` (CK BlockScale) | 35 | 53 | 72 | MoE Expert GEMM (CK) |
| `kernel_gemm_xdl_cshuffle_v3` (CK) | 21 | 24 | 52 | Dense GEMM (QKV/O proj) |
| `dynamic_per_group_scaled_quant` | 5.6 | 5.6 | 24 | FP8 Activation Quant |
| `add_rmsnorm_quant_kernel` | 5.8 | - | - | RMSNorm + Residual Add |
| `mix_sample_outer_exponential` | - | 4830 | 4884 | Sampling (vocab=151936) |

### ISL=8192 (long prefill, attention grows)

| Kernel | Conc=4 avg(us) | Conc=8 avg(us) | Conc=16 avg(us) | Conc=32 avg(us) | Category |
|--------|---------------|---------------|----------------|----------------|----------|
| `fmoe_bf16_blockscaleFp8` | - | - | 2387 | 3149 | MoE Expert GEMM (fused) |
| `kernel_moe_gemm` (CK) | 73 | 35 | 54 | 71 | MoE Expert GEMM (CK) |
| `kernel_gemm_xdl_cshuffle_v3` | 18 | 19 | 31 | 43 | Dense GEMM |
| `pa_bf16_pertokenFp8_gqa8` | 12 | 41 | 43 | 47 | Paged Attention (decode) |
| `fmha_fwd_hd128_bf16_causal` | - | - | 652 | 898 | Flash Attention (prefill) |
| `dynamic_per_group_scaled_quant` | 5.6 | 5.5 | - | - | FP8 Quant |

## Key Observations

### 1. MoE Expert GEMM dominates (36-50% of GPU time)
- Two MoE GEMM implementations appear:
  - `fmoe_bf16_blockscaleFp8_g1u1_vs_silu`: **fused MoE** (gate+up+silu in one kernel), avg 680-3150 us
  - `kernel_moe_gemm` (CK): **2-stage CK MoE**, avg 35-73 us per launch but many launches
- The fused version is used for larger batch sizes (appears at conc>=16)
- CK version is used for smaller batches (more launches, lower per-launch time)

### 2. Attention scales with ISL and concurrency
- **Paged Attention** (decode): 12 us (conc=4) → 47 us (conc=32) — scales with batch size
- **Flash Attention** (prefill): 652 us (conc=16) → 898 us (conc=32) — scales with ISL²

### 3. Sampling is expensive at high concurrency
- `mix_sample_outer_exponential`: ~4850 us per call (vocab=151936, very large)
- At conc=16 ISL=1024: sampling is 19.4% of total GPU time!

### 4. FP8 Quantization (BlockScale)
- MiniMax uses FP8 **block-scale** quantization (not per-token like Qwen3)
- `dynamic_per_group_scaled_quant_kernel`: 5.6 us base, grows to 24 us at conc=32
- Quantizes activations before FP8 GEMM

### 5. Dense GEMM uses CK BlockScale
- `kernel_gemm_xdl_cshuffle_v3_multi_d_blockscale_b_preshuffle`: CK FP8 block-scale GEMM
- Replaces rocBLAS `Cijk_*` from Qwen3 — MiniMax uses FP8 weight quantization

## MiniMax vs Qwen3 Kernel Differences

| Component | Qwen3-30B-A3B | MiniMax-M2.5 |
|-----------|---------------|--------------|
| Dense GEMM | rocBLAS `Cijk_*` (BF16) | CK `kernel_gemm_xdl_cshuffle_v3` (FP8 BlockScale) |
| MoE GEMM | CK `kernel_moe_gemm` (BF16, 2-stage) | CK `kernel_moe_gemm` (FP8 BlockScale) + fused `fmoe_bf16_blockscaleFp8` |
| Activation Quant | None (BF16 throughout) | `dynamic_per_group_scaled_quant` (BF16→FP8) |
| Attention | Same (fmha_v3, PA) | Same (fmha_v3, PA) |
| RMSNorm | Same | Same |
| Sampling | Same | Same (but more expensive due to larger vocab) |

## CSV Files

Per-config kernel breakdowns in:
- `level3/level3_isl1024_conc{8,16,32}_kernels.csv`
- `level3/level3_isl8192_conc{4,8,16,32}_kernels.csv`
