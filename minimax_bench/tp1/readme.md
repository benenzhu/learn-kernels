# MiniMax-M2.5 TP=1 FP8 Profiling Results

## Model Architecture

| Parameter | Value |
|-----------|-------|
| Model | MiniMaxAI/MiniMax-M2.5 |
| Type | MoE (256 experts, top-8) |
| Hidden size | 3072 |
| Layers | 62 |
| Expert intermediate | 1536 |
| Vocab | 200064 |
| Params (est.) | ~229B |
| Quantization | FP8 (kv_cache_dtype=fp8) |
| TP | 1 |
| Compilation | Level 3 (PIECEWISE, default) |

## Throughput Summary

| Concurrency | Req/s | Output tok/s | Total tok/s | Mean TTFT (ms) | Mean TPOT (ms) |
|-------------|-------|-------------|-------------|----------------|----------------|
| 4 | 4.73 | 215 | 4,714 | 188 | 13.7 |
| 8 | 7.68 | 348 | 7,502 | 269 | 16.4 |
| 16 | 11.17 | 501 | 10,764 | 431 | 20.9 |
| 32 | 15.39 | 683 | 14,887 | 639 | 30.3 |

ISL=1024, OSL=50, FP8, single MI355X (288GB)

## Kernel Inventory (conc=32 trace)

Total kernel time: 131 ms, 27 unique kernels

| Category | Kernel | Count | Avg (us) | Tot% | Provider |
|----------|--------|-------|----------|------|----------|
| **MoE Expert GEMM (FP8)** | `kernel_moe_gemm` (CK blockscale) | 868 | 80.6 | **53.3%** | CK |
| **Dense GEMM (FP8)** | `kernel_gemm_xdl_cshuffle_v3` blockscale | 868 | 18.1 | **12.0%** | CK |
| **FP8 Activation Quant** | `dynamic_per_group_scaled_quant_kernel` | 1736 | 5.6 | 7.3% | aiter |
| **Paged Attention** | `pa_bf16_pertokenFp8_gqa8_2tg_4w` | 434 | 11.2 | 3.7% | aiter (ASM) |
| **RMSNorm+Quant** | `add_rmsnorm_quant_kernel` | 868 | 5.6 | 3.7% | aiter |
| **Dense GEMM (BF16)** | `Cijk_Alik_Bljk` (rocBLAS) | 248 | 12.2 | 2.3% | rocBLAS |
| **MoE Gate** | `grouped_topk_kernel` | 434 | 6.7 | 2.2% | aiter |
| **RMSNorm (Triton)** | `triton_red_fused_*_rsqrt_split_*` | 868 | 5.6 | 3.6% | Triton |
| **RoPE** | `kn_entry_2c_sbhd_cached_indirect` | 434 | 5.6 | 1.8% | aiter |
| **Triton copy** | `triton_poi_fused__to_copy_0` | 434 | 5.5 | 1.8% | Triton |
| **KV Cache** | `reshape_and_cache_with_per_token_quant` | 434 | 5.5 | 1.8% | aiter |
| **MoE Sort (Phase 2+3)** | `MoeSortingKernel` | 186 | 10.3-12.0 | 2.7% | CK (ck_tile) |
| **MoE Sort (MultiPhase)** | `MoeSortingMultiPhaseKernel_P0/P23` | 124 | 5.6 | 0.5% | CK (ck_tile) |
| **Dense GEMM (BF16, prefill)** | `Cijk_*_BBS_BH` (rocBLAS batched) | 6 | 196.3 | 0.9% | rocBLAS |
| **Sampling** | `mix_sample_outer_exponential` | 8 | 49.7 | 0.3% | aiter |
| **Embedding** | `triton_poi_fused_embedding_0` | 7 | 5.5 | 0.0% | Triton |

## Key Observations

### 1. MoE Expert GEMM dominates (53%)
`kernel_moe_gemm` (CK blockscale FP8) is the single biggest cost at 80.6 us avg.
This is the **non-fused** CK path — separate quant + GEMM, not the fused `fmoe_bf16_blockscaleFp8` path seen in TP=2/4.

### 2. Dense GEMM uses FP8 CK (12%)
QKV/O projections use `kernel_gemm_xdl_cshuffle_v3` with blockscale FP8 at 18.1 us avg.

### 3. FP8 quant overhead is significant (7.3%)
`dynamic_per_group_scaled_quant` runs 1736x (2x per layer = before each GEMM pair),
5.6 us each — small individually but adds up.

### 4. TP=1 works on MI355X
229 GB FP8 weights fit in 288 GB VRAM with ~59 GB headroom for KV cache.
Throughput scales linearly with concurrency up to 32.

### 5. Decode batch sizes
conc=32 trace shows mostly `decode[bs=32]` (40 steps), with some ramp-up/ramp-down.
Prefill batches up to bs=18 (16368 tokens).

## Trace Files

| Concurrency | Trace file |
|-------------|-----------|
| 4 | `kernel_traces/tp1/rank_0/MiniMax-M2.5_ts_20260414_035937_391.pt.trace.json.gz` |
| 8 | `kernel_traces/tp1/rank_0/MiniMax-M2.5_ts_20260414_035942_824.pt.trace.json.gz` |
| 16 | `kernel_traces/tp1/rank_0/MiniMax-M2.5_ts_20260414_035948_723.pt.trace.json.gz` |
| 32 | `kernel_traces/tp1/rank_0/MiniMax-M2.5_ts_20260414_035955_341.pt.trace.json.gz` |
