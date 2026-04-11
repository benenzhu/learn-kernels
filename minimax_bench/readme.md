# MiniMax-M2.5 FP8 吞吐 Benchmark

## 环境

- **模型**: MiniMaxAI/MiniMax-M2.5 (MoE, 256 experts, top-8, hidden=3072, 62 layers)
- **量化**: FP8 E4M3 per-128×128 block-scale (预量化), KV cache FP8
- **GPU**: 8× MI355X (gfx950, 288GB HBM each)
- **框架**: ATOM (vllm fork), aiter, CK, `--level 3` (piecewise CUDA graph)
- **ISL**: 8192, **OSL**: 512, `--random-range-ratio 0.8`

## 吞吐测试结果

| 配置 | TP | EP | Conc | Prompts | Output tok/s | Total tok/s | TTFT p50 (ms) | TTFT p99 (ms) | TPOT p50 (ms) | TPOT p99 (ms) | E2EL p50 (ms) | E2EL p99 (ms) | 状态 |
|------|---:|---:|-----:|--------:|-------------:|------------:|--------------:|--------------:|--------------:|--------------:|--------------:|--------------:|------|
| tp1conc8    | 1 | - |  8 |  - |    - |     - |    - |    - |    - |    - |    - |    - | OOM (285GB > 288GB) |
| tp2conc16   | 2 | - | 16 | 160 | **606.3** | **10340.5** | 317.9 | 3527.7 | 25.2 | 28.2 | 11906.8 | 15574.8 | OK |
| tp4conc32   | 4 | - | 32 | 320 | **1189.0** | **20098.1** | 228.9 | 3864.5 | 25.4 | 28.7 | 12073.2 | 16082.8 | OK |
| tp8conc64   | 8 | - | 64 |  - |    - |     - |    - |    - |    - |    - |    - |    - | 维度不兼容 |
| tp8ep conc64 | 8 | yes | 64 | 640 | **2138.0** | **36457.8** | 227.7 | 5031.7 | 28.9 | 33.6 | 13498.2 | 18587.1 | OK |

### 关键结论

1. **TP=8 EP 吞吐最高**: 2138 tok/s output, 是 TP=4 的 **1.8×**, TP=2 的 **3.5×**
2. **吞吐近线性 scaling**: TP2→TP4 = 2.0×, TP4→TP8EP = 1.8× (接近理想 2×)
3. **TPOT 随 TP 增大略升**: 25.2 → 25.4 → 28.9 ms (TP=8 EP 多了 expert alltoall 通信)
4. **TTFT p50 TP=4 和 TP=8EP 一致** (~228 ms): prefill 并行度饱和
5. **TP=8 EP E2EL 更高**: 13.5s vs 12.1s (TPOT 高 + 更多 batching 排队)
6. **TP=1 OOM**: 模型权重 285GB 超过单卡 288GB
7. **TP=8 (纯 TP) 不兼容**: intermediate_size=1536/8=192 不能被 FP8 block_n=128 整除
8. **EP 解决了 TP=8 维度问题**: Expert Parallel 不切分单个 expert 权重，改为分发 experts 到不同 GPU

### 失败配置分析

**tp1conc8**: `torch.OutOfMemoryError` — 加载权重 285GB 后仅剩 ~2GB，无法分配 KV cache

**tp8conc64 (纯TP)**: `ValueError: output_size of gate's and up's weight = 192 is not divisible by weight quantization block_n = 128` — MoE gate/up_proj TP=8 切分后 1536/8=192，不是 128 的倍数。**解决方案: 用 `--enable-expert-parallel`**

---

## Profiling 分析 (单请求, ISL ~7.3k, OSL ~465)

### 延迟概览

| 指标 | TP=2 | TP=4 | TP=8 EP |
|------|-----:|-----:|--------:|
| Prefill (ms, ~7.3k tok) | ~58 | ~60 | ~59 |
| Decode mean (us/step) | 700.5 | 790.9 | 644.2 |
| Decode min (us/step) | 581.1 | 615.5 | 508.9 |
| TPOT (ms, 单请求) | 14.2 | 14.3 | 15.1 |

### Top GPU Kernels (5 请求, ISL~7.3k)

| # | Kernel | 类型 | TP=2 avg(us) | TP=2 % | TP=4 avg(us) | TP=4 % | TP=8EP avg(us) | TP=8EP % |
|---|--------|------|------:|------:|------:|------:|------:|------:|
| 1 | `pa_bf16_pertokenFp8_gqa8` | Paged Attention | 40.7 | 17.7% | 41.3 | 17.8% | 40.3 | 16.4% |
| 2 | `reduce_scatter_cross_device_store` | AllReduce | 9.4 | 8.2% | 7.3 | 6.3% | 16.6 | **13.5%** |
| 3 | `gemm_blockscale_b_preshuffle` | Attention GEMM | 12.5 | 5.4% | 18.7 | 8.1% | 13.2 | **10.8%** |
| 4 | `ncclDevKernel_Generic` | NCCL Comm | 13.4 | 5.9% | 12.3 | 5.4% | 20.7 | **8.6%** |
| 5 | `kernel_moe_gemm` (stage1) | MoE GEMM up/gate | 21.1 | 9.2% | 20.2 | 8.7% | 14.9 | 6.1% |
| 6 | `dynamic_per_group_scaled_quant` | FP8 Quant | 5.0 | 8.7% | 5.7 | 9.8% | 4.8 | 7.9% |
| 7 | `Cijk_Alik_Bljk` (rocBLAS gate) | Gate GEMM | 12.2 | 5.3% | 12.5 | 5.4% | 11.9 | 4.9% |
| 8 | `local_device_load_rmsnorm` | Fused RMSNorm | 5.3 | 4.6% | 5.7 | 5.0% | 5.3 | 4.3% |
| 9 | `MoeSortingKernel` | MoE Token Sort | 8.3 | 3.6% | 8.4 | 3.6% | 9.0 | 3.7% |
| 10 | `kernel_moe_gemm` (stage2) | MoE GEMM down | 7.7 | 3.4% | 7.0 | 3.0% | 7.1 | 2.9% |

### Kernel 分类统计

| 类别 | TP=2 % | TP=4 % | TP=8 EP % |
|------|-------:|-------:|----------:|
| **Attention (PA + GEMM + KV cache)** | ~32% | ~34% | ~32% |
| **Communication (reduce_scatter + NCCL)** | ~14% | ~12% | **~22%** |
| **MoE (GEMM + sort + topk)** | ~19% | ~18% | ~16% |
| **FP8 Quant** | ~9% | ~10% | ~8% |
| **Norm (RMSNorm fused)** | ~5% | ~5% | ~4% |
| **Triton (RoPE/norm)** | ~15% | ~15% | ~13% |
| **Other (sampling, embedding)** | ~6% | ~6% | ~5% |

### 关键观察

1. **Paged Attention 始终是最大单 kernel** (~16-18%): `pa_bf16_pertokenFp8_gqa8_2tg_4w`, ~40 us, 不随 TP 变化
2. **TP=8 EP 通信开销显著增大** (22% vs 14%): reduce_scatter 每次 16.6 us (vs TP=2 的 9.4 us), NCCL 每次 20.7 us (vs 13.4 us) — EP 需要额外的 expert alltoall
3. **MoE GEMM 在 EP 下更快**: stage1 14.9 us (vs TP=2 的 21.1 us) — 每个 GPU 只处理 256/8=32 个 experts
4. **Decode 单步 TP=8 EP 最低** (644 us): 虽然通信多，但计算量更小（更多 GPU 分担）
5. **TP=4 下 attention GEMM 反而最慢** (18.7 us): head 数变少后 tile config 效率降低
6. **通信是 TP=8 EP 的主要瓶颈**: 22% GPU 时间花在通信，是吞吐未达理想 2× scaling 的原因

---

## 吞吐 Scaling 分析

```
配置        GPU数  Output tok/s   per-GPU tok/s  Scaling效率
tp2conc16    2      606.3          303.2          baseline
tp4conc32    4     1189.0          297.3          98.1%
tp8ep c64    8     2138.0          267.3          88.2%
```

- TP2→TP4: 几乎完美 scaling (98%)
- TP4→TP8EP: 效率下降到 88%，主要因为 EP 的 alltoall 通信开销
- 随着 GPU 数翻倍, per-GPU 效率: 303 → 297 → 267 tok/s

---

## 文件列表

```
results/
├── tp2_conc16_bench.log          # tp2 benchmark 原始输出
├── tp4_conc32_bench.log          # tp4 benchmark 原始输出
├── tp8ep_conc64_bench.log        # tp8 EP benchmark 原始输出
├── tp1_conc8_server.log          # tp1 OOM 日志
├── tp8_conc64_server.log         # tp8 纯TP 维度错误日志
├── tp2_top_kernels.txt           # tp2 kernel profiling
├── tp4_top_kernels.txt           # tp4 kernel profiling
├── tp8ep_top_kernels.txt         # tp8 EP kernel profiling
├── tp2_trace_summary.md          # tp2 prefill/decode summary
├── trace_tp2/                    # tp2 torch profiler traces
├── trace_tp4/                    # tp4 torch profiler traces
└── trace_tp8ep/                  # tp8 EP torch profiler traces
```
