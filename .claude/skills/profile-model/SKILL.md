---
name: profile-model
description: Profile LLM with ATOM, extract GPU kernels, generate kernel inventory
user-invocable: true
---

# Profile Model Skill

Profile an LLM with ATOM, extract all GPU kernels, and generate kernel inventory.

## When to use

User asks to profile/trace a model, wants to know what kernels are used,
or wants to understand the inference pipeline of a model.

## IMPORTANT: Always use bench_serving scripts

- **Benchmarking**: `bench_serving/1_bench.py` — NEVER call `benchmark_serving.py` directly
- **Layer extraction**: `bench_serving/2_trace_layer.py` — per-layer kernel breakdown from trace
- Run `1_bench.py` from inside `bench_serving/` directory (it calls `benchmark_serving.py` internally)

## Profiling Workflow

### 1. Start server with profiler enabled

```bash
cd /app/ATOM
export OMP_NUM_THREADS=1
export KINETO_BUFFER_SIZE_MB=256   # CRITICAL: default 32MB only captures ~2s of GPU events
python -m atom.entrypoints.openai_server \
  --model <MODEL_NAME> \
  --kv_cache_dtype fp8 \
  -tp <TP> \
  --torch-profiler-dir <OUTPUT_DIR> \
  --server-port 8200
```

### 2. Run bench_serving/1_bench.py with --profile

```bash
cd bench_serving
echo "y" | python 1_bench.py \
  --model <MODEL_NAME> \
  --isl 1024 --osl 50 \
  --conc-start 4 --conc-end 32 \
  --port 8200 \
  --profile \
  --num-prompts-mul 5
```

`--profile` is passed through to benchmark_serving.py which calls
`/start_profile` and `/stop_profile` server endpoints automatically.
Each concurrency level produces a separate trace file.

### 3. Extract per-layer kernel breakdown

```bash
# Auto-detects decode bs, auto-saves conc{bs}_layer.csv
python bench_serving/2_trace_layer.py <trace.json.gz>

# With explicit CSV — auto-prepends conc{bs}_ to filename
python bench_serving/2_trace_layer.py <trace.json.gz> --csv layer.csv
```

## CRITICAL: rocprofiler Ring Buffer

rocprofiler-sdk uses a fixed-size ring buffer (~32MB default) for GPU kernel events.
Old events are overwritten in FIFO order. CPU annotations use separate unbounded storage.

**Symptom**: GPU kernel events only appear for the last ~2s of a trace.
**Fix**: `export KINETO_BUFFER_SIZE_MB=256` before starting the server.

## CRITICAL: Client vs Server Concurrency

```
--max-num-seqs=N  (server)  = SERVER-side batch limit
  - Controls actual max decode batch size
  - Use this to get controlled batch sizes for profiling

Client-side --max-concurrency is just a semaphore!
  - With rate=inf, all requests are queued on server immediately
  - Server scheduler batches freely → decode bs >> concurrency
```

## Compilation Levels

```
--level 0  NO_COMPILATION     Pure eager, no torch.compile, no CUDA graph
--level 3  PIECEWISE (default) torch.compile + CUDA graphs (production mode)

NOTE: --level 0 may crash for some models (e.g., MiniMax-M2.5 TP=1).
NOTE: --enforce-eager only disables CUDA graphs, NOT torch.compile.
      Level 0 is the only way to fully disable torch.compile.
```

## GPU Memory Check Before Profiling

```bash
rocm-smi --showmeminfo vram | grep "Used"
```

## Trace Output

- Location: `<torch_profiler_dir>/rank_0/<model>_ts_<timestamp>.pt.trace.json.gz`
- Format: Chrome JSON trace (gzip compressed)
- View in: Perfetto (https://ui.perfetto.dev/) or chrome://tracing

## Kernel Categorization Template

| Category | Kernel patterns | Provider |
|----------|----------------|----------|
| Embedding | `indexSelectSmallIndex`, `triton_poi_fused_embedding` | PyTorch / Triton |
| RMSNorm | `add_rmsnorm_quant_kernel` | aiter |
| RoPE | `kn_entry_2c_sbhd_cached_indirect` | aiter |
| KV Cache | `reshape_and_cache_with_per_token_quant` | aiter |
| Flash Attention | `fmha_fwd_*` | aiter (ASM) |
| Paged Attention | `pa_bf16_*` | aiter (ASM) |
| PA Reduce | `wv_splitk_small_*` | aiter |
| Dense GEMM (BF16) | `Cijk_*` | rocBLAS |
| Dense GEMM (FP8) | `kernel_gemm_xdl_cshuffle_v3*blockscale` | CK |
| FP8 Activation Quant | `dynamic_per_group_scaled_quant` | aiter |
| MoE Gate | `topkGatingSoftmax`, `grouped_topk` | vllm / aiter |
| MoE Sort | `MoeSortingKernel`, `MoeSortingMultiPhase*` | CK (ck_tile) |
| MoE Expert GEMM (BF16) | `kernel_moe_gemm` | CK |
| MoE Expert GEMM (FP8) | `fmoe_bf16_blockscaleFp8*` | aiter (fused) |
| Sampling | `mix_sample_outer_exponential` | aiter |

## Output Format

Generate:
1. `readme.md` - Overview with architecture params, kernel inventory, time breakdown
2. `*_kernels.csv` - Per-config kernel CSV (from `2_trace_layer.py --csv`)
