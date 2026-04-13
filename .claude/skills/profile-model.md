# Profile Model Skill

Profile an LLM with ATOM, extract all GPU kernels, and generate kernel inventory.

## When to use

User asks to profile/trace a model, wants to know what kernels are used,
or wants to understand the inference pipeline of a model.

## ATOM Profiling Command

```bash
# Pure eager mode (no torch.compile artifacts, no CUDA graph):
ATOM_PROFILER_MORE=1 python -m atom.examples.profile_offline \
  --model <MODEL_NAME> \
  --enforce-eager \
  --level 0 \
  --torch-profiler-dir <OUTPUT_DIR> \
  --kv_cache_dtype fp8 \
  --tensor-parallel-size <TP>

# Key flags:
#   --enforce-eager    Disable CUDA graph capture/replay
#   --level 0          Disable torch.compile (NO_COMPILATION)
#                      Without this, embedding becomes triton_poi_fused_embedding_0
#   ATOM_PROFILER_MORE=1  Enable python_function events for call stack reconstruction
#                         (record_shapes=True, with_stack=True, profile_memory=True)
#                         WARNING: trace file grows from ~5MB to ~50MB
```

## Compilation Levels

```
--level 0  NO_COMPILATION     Pure eager, no torch.compile
--level 1  DYNAMO_AS_IS       torch.compile + eager backend
--level 2  DYNAMO_ONCE        torch.compile + Inductor
--level 3  PIECEWISE (default) Piecewise compilation + CUDA graphs
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

## Kernel Extraction Script

```python
import gzip, json
from collections import Counter

with gzip.open('trace.json.gz', 'rt') as f:
    trace = json.load(f)

kernels = Counter()
for ev in trace['traceEvents']:
    if ev.get('cat') == 'kernel':
        kernels[ev['name']] += 1

# Print unique kernels sorted by count
for name, cnt in kernels.most_common():
    short = name.replace('void ', '')[:80]
    print(f"{cnt:>6}x  {short}")
```

## Call Stack Reconstruction (requires ATOM_PROFILER_MORE=1)

```python
import bisect

# Get python_function events on main thread
py_funcs = [ev for ev in trace['traceEvents']
            if ev.get('cat') == 'python_function' and ev.get('ph') == 'X']
py_funcs.sort(key=lambda x: x['ts'])
py_starts = [p['ts'] for p in py_funcs]
py_ends = [p['ts'] + p.get('dur', 0) for p in py_funcs]

# Map kernel → cpu_op via External id
cpuop_by_extid = {}
for ev in trace['traceEvents']:
    if ev.get('cat') == 'cpu_op':
        ext_id = ev.get('args', {}).get('External id')
        if ext_id: cpuop_by_extid[ext_id] = ev

def find_stack(ts, max_depth=15):
    idx = bisect.bisect_right(py_starts, ts)
    stack = []
    for i in range(idx-1, max(0, idx-2000), -1):
        if py_starts[i] <= ts <= py_ends[i]:
            stack.append(py_funcs[i]['name'])
        if len(stack) >= max_depth: break
    stack.reverse()
    return stack
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
| Dense GEMM | `Cijk_*` | rocBLAS |
| MoE Gate | `topkGatingSoftmax` | vllm |
| MoE Sort | `MoeSortingKernel`, `MoeSortingMultiPhase*` | CK (ck_tile) |
| MoE Expert GEMM | `kernel_moe_gemm` | CK |
| Sampling | `mix_sample_outer_exponential` | aiter |

## Output Format

Generate:
1. `readme.md` - Overview with architecture params, kernel inventory, time breakdown
2. `NN_<component>.md` - Per-component docs (embedding, rmsnorm, rope, etc.)
3. `<model>_source_trace.md` - Full call chain Python → C++ → GPU
