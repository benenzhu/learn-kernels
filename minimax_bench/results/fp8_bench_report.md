# MiniMax-M2.5 FP8 Serving Benchmark Report

> Model: MiniMaxAI/MiniMax-M2.5 | GPU: MI355X | KV Cache: FP8 | Date: 2026-04-13

## Benchmark Config

| Parameter | Value |
|-----------|-------|
| Input tokens (ISL) | 8192 (range_ratio=0.8, actual [6554, 8192]) |
| Output tokens (OSL) | 512 (range_ratio=0.8, actual [410, 512]) |
| Request rate | inf (send all at once) |
| Num prompts | conc * 10 |
| ignore_eos | true |

## Results Summary

| Config | Out tok/s | Total tok/s | TTFT p50 (ms) | TTFT p99 (ms) | TPOT p50 (ms) | TPOT p99 (ms) | ITL p50 (ms) | ITL p99 (ms) |
|--------|-----------|-------------|---------------|---------------|---------------|---------------|--------------|--------------|
| TP=2, Conc=16 | 608.5 | 10,378 | 319.7 | 3,531.5 | 25.2 | 28.2 | 17.5 | 244.2 |
| TP=4, Conc=32 | 1,187.7 | 20,076 | 227.6 | 3,854.9 | 25.5 | 28.6 | 16.4 | 166.8 |

## Comparison with MXFP4

| Config | Out tok/s | Total tok/s | TTFT p50 (ms) | TPOT p50 (ms) |
|--------|-----------|-------------|---------------|---------------|
| TP=4 FP8, Conc=32 | 1,187.7 | 20,076 | 227.6 | 25.5 |
| TP=4 MXFP4, Conc=32 | 1,287.1 | 21,756 | 223.4 | 23.5 |
| **MXFP4 speedup** | **+8.4%** | **+8.4%** | **-1.8%** | **-7.8%** |

## Key Observations

1. **TP=2 → TP=4 scaling**: ~1.95x throughput (near linear), TTFT improved 29%
2. **TPOT consistent**: ~25 ms across TP=2 and TP=4 (decode is memory-bound, more GPUs doesn't help per-token latency much)
3. **TTFT p99 high**: 3.5-3.9s due to prefill queuing at high concurrency
4. **MXFP4 vs FP8**: +8% throughput, -8% TPOT (smaller weights → faster GEMM)

## CSV Files

- `tp2_conc16_metrics.csv` — TP=2 detailed metrics
- `tp4_conc32_metrics.csv` — TP=4 detailed metrics
- `fp8_bench_combined.csv` — Combined comparison
