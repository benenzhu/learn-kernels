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
| GPU | 1x MI355X (288GB) |
| Compilation | Level 3 (PIECEWISE, default) |

## Throughput Summary

ISL=1024, OSL=50, FP8, single MI355X

| Conc | Req/s | Output tok/s | Total tok/s | TTFT (ms) | TPOT (ms) |
|------|-------|-------------|-------------|-----------|-----------|
| 4 | 4.94 | 217 | 4,752 | 109 | 16.0 |
| 8 | 6.92 | 312 | 6,728 | 142 | 22.0 |
| 16 | 10.16 | 451 | 9,817 | 199 | 30.7 |
| 32 | 11.90 | 534 | 11,550 | 653 | 44.9 |
| 64 | 18.08 | 813 | 17,461 | 686 | 63.2 |

## Per-Layer Kernel Breakdown (Decode)

Extracted via `bench_serving/2_trace_layer.py` using PA-to-PA layer slicing.

### Per-Layer Time vs Concurrency

| Kernel | conc=4 | conc=8 | conc=16 | conc=32 | conc=64 | Trend |
|--------|-------:|-------:|--------:|--------:|--------:|-------|
| PA (paged_attn) | 10.2 | 10.6 | 11.3 | 14.6 | 28.6 | scales with KV length |
| FP8_quant (O-proj) | 5.6 | 5.4 | 5.4 | 5.5 | 17.6 | flat → jump at 64 |
| GEMM_FP8 (O-proj) | 17.9 | 17.9 | 16.6 | 16.1 | 17.7 | flat |
| RMSNorm+Quant | 5.6 | 5.6 | 5.6 | 5.6 | 5.6 | flat |
| Triton_copy | 5.6 | 5.5 | 5.7 | 5.6 | 17.7 | flat → jump at 64 |
| GEMM_BF16 (shared) | 12.2 | 12.1 | 12.1 | 12.0 | 11.9 | flat |
| MoE_gate (topk) | 6.7 | 6.8 | 6.7 | 6.7 | 6.8 | flat |
| MoE_sort | 8.1 | 8.3 | 10.3 | 11.0 | 5.4+17.9 | grows |
| FP8_quant (MoE) | 5.6 | 5.6 | 5.5 | 5.5 | 5.5 | flat |
| **MoE_GEMM (gate_up)** | **47.1** | **78.3** | **116.5** | **180.3** | **390.6*** | **linear** |
| FP8_quant (down) | 5.6 | 5.4 | 5.5 | 5.6 | — | flat |
| **MoE_GEMM (down)** | **22.5** | **38.0** | **57.5** | **88.5** | **—*** | **linear** |
| RMSNorm+Quant | 5.5 | 5.5 | 5.5 | 5.5 | 5.5 | flat |
| FP8_quant (QKV) | 5.6 | 5.4 | 5.4 | 5.5 | 5.6 | flat |
| GEMM_FP8 (QKV) | 19.2 | 19.2 | 19.4 | 19.5 | 29.7 | flat → grows at 64 |
| RMSNorm_triton x2 | 11.2 | 11.1 | 11.0 | 11.1 | 11.4 | flat |
| RoPE | 5.6 | 5.6 | 5.6 | 5.6 | 5.9 | flat |
| KV_cache_quant | 5.7 | 5.5 | 5.5 | 5.6 | 5.4 | flat |
| **TOTAL** | **205.6** | **251.8** | **311.3** | **409.8** | **588.7** | |

\* conc=64 uses fused ASM kernel (`fmoe_bf16_blockscaleFp8`) — gate_up+down merged into single 390.6 us kernel (18 kernels/layer vs 19-20)

### MoE GEMM Scaling (dominates layer time)

```
conc=4:   69.6 us (33.8%) = 47.1 + 22.5
conc=8:  116.3 us (46.2%) = 78.3 + 38.0
conc=16: 174.0 us (55.9%) = 116.5 + 57.5
conc=32: 268.8 us (65.6%) = 180.3 + 88.5
conc=64: 390.6 us (66.3%) = fused single kernel
```

MoE GEMM time grows ~linearly with batch size (compute-bound).
All other kernels remain flat (launch-bound at these small M dimensions).

## Key Observations

1. **MoE GEMM dominates and scales linearly** — 34% of layer at conc=4, 66% at conc=64
2. **Dense GEMMs are launch-bound** — O-proj (16-18 us) and QKV (19 us) don't change with batch size
3. **conc=64 switches to fused ASM MoE kernel** — `fmoe_bf16_blockscaleFp8` replaces separate CK `kernel_moe_gemm` calls
4. **PA scales with KV cache length** — 10.2 us at conc=4 → 28.6 us at conc=64
5. **TP=1 works** — 229 GB FP8 weights fit in 288 GB VRAM, 813 output tok/s at conc=64

## Files

- `conc{4,8,16,32,64}_layer.csv` — per-layer kernel CSV from `2_trace_layer.py`
- `kernel_traces/tp1/rank_0/*.json.gz` — raw trace files (not committed)
