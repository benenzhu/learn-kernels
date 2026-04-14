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

## Profiling Workflow

### 1. Start server with profiler enabled

```bash
export OMP_NUM_THREADS=1
python -m atom.entrypoints.openai_server \
  --model <MODEL_NAME> \
  --kv_cache_dtype fp8 \
  -tp <TP> \
  --torch-profiler-dir <OUTPUT_DIR> \
  --max-num-seqs <MAX_BATCH>          # SERVER-SIDE batch limit!
  --server-port 8200
```

### 2. Run bench_serving with --profile

```bash
# Clone bench tool (if not already):
git clone https://github.com/benenzhu/bench_serving.git

# Run benchmark with profiling:
python bench_serving/1_bench.py \
  --model <MODEL_NAME> \
  --isl 1024 \
  --osl 50 \
  --conc-start 4 \
  --conc-end 32 \
  --port 8200 \
  --profile \
  --num-prompts-mul 1

# ISL=8192:
python bench_serving/1_bench.py \
  --model <MODEL_NAME> \
  --isl 8192 \
  --osl 50 \
  --conc-start 4 \
  --conc-end 32 \
  --port 8200 \
  --profile \
  --num-prompts-mul 1
```

`--profile` is passed through to benchmark_serving.py which calls
`/start_profile` and `/stop_profile` server endpoints automatically.
Each concurrency level produces a separate trace file.

## CRITICAL: Client vs Server Concurrency

```
--max-num-seqs=N  (server)  = SERVER-side batch limit
  - Controls actual max decode batch size
  - Use this to get controlled batch sizes for profiling
  - Example: --max-num-seqs 4 → decode bs <= 4

Client-side --max-concurrency is just a semaphore!
  - Does NOT limit server-side batch size
  - With rate=inf, all requests are queued on server immediately
  - Server scheduler batches freely → decode bs >> concurrency

To profile with exact batch sizes:
  Server: --max-num-seqs=<DESIRED_BS>
```

### Verify batch sizes in trace

```python
# Check actual prefill/decode batch sizes in trace:
from collections import Counter
annotations = [ev['name'] for ev in trace['traceEvents']
               if 'decode' in ev.get('name', '').lower()
               or 'prefill' in ev.get('name', '').lower()]
print(Counter(annotations).most_common(20))

# Expected: decode[bs=4 tok=4 d=4] if --max-num-seqs=4
# Bad sign: decode[bs=29 ...] means server is batching beyond your intent
```

## Compilation Levels

```
--level 0  NO_COMPILATION     Pure eager, no torch.compile, no CUDA graph
--level 3  PIECEWISE (default) torch.compile + CUDA graphs (production mode)

NOTE: --level 0 may crash for some models (e.g., MiniMax-M2.5 TP=1).
      Some models require torch.compile to work correctly.
NOTE: --enforce-eager only disables CUDA graphs, NOT torch.compile.
      Level 0 is the only way to fully disable torch.compile.
```

## GPU Memory Check Before Profiling

```bash
# Always check GPU memory first:
rocm-smi --showmeminfo vram | grep "Used"
# If GPUs are occupied, profiling will OOM
```

## Trace Output

- Location: `<torch_profiler_dir>/rank_0/<model>_ts_<timestamp>.pt.trace.json.gz`
- Format: Chrome JSON trace (gzip compressed)
- View in: Perfetto (https://ui.perfetto.dev/) or chrome://tracing
- Rename after capture: `mv <latest>.json.gz <tag>_trace.json.gz`

## Kernel Extraction Script

```python
import gzip, json
from collections import defaultdict

with gzip.open('trace.json.gz', 'rt') as f:
    trace = json.load(f)

# Extract kernels with duration
kernel_dur = defaultdict(lambda: {"count": 0, "total_us": 0})
for ev in trace['traceEvents']:
    if ev.get('cat') == 'kernel':
        name = ev['name'].replace('void ', '')[:80]
        kernel_dur[name]["count"] += 1
        kernel_dur[name]["total_us"] += ev.get('dur', 0)

# Print sorted by total time
total = sum(v["total_us"] for v in kernel_dur.values())
for name, data in sorted(kernel_dur.items(), key=lambda x: -x[1]["total_us"]):
    avg = data["total_us"] / data["count"]
    pct = data["total_us"] / total * 100
    print(f"{data['count']:>6}x  {avg:>8.1f} us  ({pct:>5.1f}%)  {name}")
```

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
| MoE Gate | `topkGatingSoftmax` | vllm |
| MoE Sort | `MoeSortingKernel`, `MoeSortingMultiPhase*` | CK (ck_tile) |
| MoE Expert GEMM (BF16) | `kernel_moe_gemm` | CK |
| MoE Expert GEMM (FP8) | `fmoe_bf16_blockscaleFp8*` | aiter (fused) |
| Sampling | `mix_sample_outer_exponential` | aiter |

## Server-Side Parameters That Affect Kernel Behavior

| Parameter | Default | Effect on kernels |
|-----------|---------|-------------------|
| `--max-num-seqs` | 512 | Max decode batch size → affects GEMM M dimension |
| `--max-num-batched-tokens` | 16384 | Max prefill tokens per step → affects prefill GEMM M |
| `--level` | 3 | 0=raw kernels, 3=fused+CUDA graph |
| `--kv_cache_dtype` | fp8 | PA reads FP8 cache, adds quant kernels |
| `--enforce-eager` | false | true=no CUDA graph (but still torch.compile) |

## Output Format

Generate:
1. `readme.md` - Overview with architecture params, kernel inventory, time breakdown
2. `NN_<component>.md` - Per-component docs (embedding, rmsnorm, rope, etc.)
3. `<model>_source_trace.md` - Full call chain Python → C++ → GPU
4. `*_kernels.csv` - Per-config kernel CSV (name, count, total_us, avg_us, pct)
