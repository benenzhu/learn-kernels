---
name: kernel-walkthrough
description: Deep kernel source-level walkthrough for aiter/atom/CK stack
user-invocable: true
---

# Kernel Walkthrough Skill

Generate a deep source-level walkthrough for a GPU kernel in the aiter/atom/CK stack.

## When to use

User asks to understand how a kernel works, wants a source walkthrough,
or asks "how does X kernel work" / "trace kernel X".

## Walkthrough Structure

```markdown
# Kernel Walkthrough: <Name>

> Source: <provider> | Language: <HIP C++ / ASM / Triton> | File: <path>

## Overview
What the kernel does, what operations it fuses.

## 1. Host Side: Python → C++ → Kernel Launch
- Python entry point (file:line)
- C++ dispatch logic
- Grid/Block selection (how BlockSize/thread_data_size chosen based on shape)
- Kernel launch code (dim3 grid, dim3 block, template params)

## 2. Device Kernel: Step-by-Step
- Template parameters explained
- Thread-to-data mapping (which thread handles which elements)
- Load pattern (vectorized? coalesced? shared memory?)
- Core computation (inline ASM instructions, reductions)
- Store pattern

## 3. Data Flow Diagram (ASCII art, English only for alignment)

## 4. Memory Access Analysis
- Bytes read/written per invocation
- Bandwidth utilization vs hardware peak
- Is it compute-bound, memory-bound, or launch-bound?

## 5. AMD ISA / Hardware Details
- Specific instructions used (v_pk_mul_f32, v_max3_f32, etc.)
- Warp shuffle / wave reduce patterns
- Shared memory usage

## 6. Source File Index
Table of all relevant source files with line numbers.
```

## aiter Source Code Navigation

```
aiter codebase layout:
  aiter/ops/*.py              Python entry points (@compile_ops decorator)
  aiter/csrc/kernels/*.cu     HIP kernel implementations
  aiter/csrc/include/         Shared utilities:
    hip_reduce.h              block_reduce, wave_reduce
    aiter_opus_plus.h         load_vector_nbytes, store_vector, opus::vector_t
    aiter_hip_common.h        Type definitions, constants
  aiter/csrc/pybind/*.cu      Pybind registration (thin wrappers)
  aiter/hsa/gfx950/           Pre-compiled ASM kernels (.co binaries)
  aiter/jit/                  JIT compilation infrastructure
  aiter/tuned_gemm.py         GEMM dispatch (shape → kernel/tile selection)
  aiter/fused_moe.py          MoE pipeline (sort → 2-stage GEMM)
  aiter/rotary_embedding.py   RoPE high-level logic
```

## Key aiter Patterns

### Vectorized Load/Store
```cpp
// 128-bit vector load (8 x bf16 in one instruction)
load_vector_nbytes<DTYPE_I, thread_data_size, 16/*chunk_bytes*/, ...>(buffer, offset);

// Store with optional type conversion (float → bf16/fp8)
store_vector<DTYPE_O, float, thread_data_size, ...>(buffer, data, offset, scale);
```

### Block Reduce (2-level)
```cpp
// Level 1: warp-level reduce (64 threads → 1 value)
// Level 2: cross-warp via shared memory (N warps → 1 value, broadcast)
float result = block_reduce<float, Op, BlockSize, true>(local_val, op);
```

### Grid/Block Heuristics
```
Common patterns in aiter:
  RMSNorm:  grid(num_tokens), block(256)     — 1 block/row
  RoPE:     grid(seq_len, batch), block(256)  — 1 block/token
  KV Cache: grid(num_tokens, num_heads), block(64) — 1 warp/token/head
  Sampling: grid(batch_size), block(1024)     — 1 block/sequence
```

### AMD ISA Quick Reference
```
v_pk_mul_f32     Packed 2x float32 multiply (2 FLOP/cycle)
v_pk_fma_f32     Packed 2x float32 FMA
v_max3_f32       3-operand max (useful for absmax in quant)
v_rcp_f32        Fast reciprocal (1/x)
rsqrtf()         Reciprocal square root (~4 cycles)
row_shr:N        Warp shuffle: shift right by N lanes
wave_shr:1       Cross-row shift within wave
row_bcast:N      Broadcast lane N within row
```

## Known Kernel → Source Mappings

| Kernel | Host Entry | Device Code |
|--------|-----------|-------------|
| `add_rmsnorm_quant_kernel` | `aiter/ops/rmsnorm.py:62` | `csrc/kernels/rmsnorm_quant_kernels.cu:14` |
| `kn_entry_2c_sbhd_cached_indirect_inplace` | `aiter/ops/rope.py:833` | `csrc/kernels/rope/rope_common.h:1902` |
| `reshape_and_cache_with_per_token_quant_kernel` | `aiter/ops/cache.py` | `csrc/kernels/cache_kernels.cu:327` |
| `fmha_fwd_hd128_bf16_causal_group` | `aiter/ops/mha.py:1980` | `hsa/gfx950/fmha_v3_fwd/*.co` (ASM) |
| `pa_bf16_pertokenFp8_gqa8_*` | `aiter/ops/attention.py:129` | `hsa/gfx950/pa/*.co` (ASM) |
| `wv_splitk_small_fp16_bf16_kernel` | `aiter/ops/custom.py:17` | `csrc/kernels/custom_kernels.cu:437` |
| `mix_sample_outer_exponential_kernel` | `aiter/ops/sample.py:40` | `csrc/kernels/sample_kernels.cu:420` |
| `topkGatingSoftmax` | `atom/model_ops/topK.py:90` | vllm CUDA kernel |
| `MoeSortingKernel` | `aiter/fused_moe.py:28` | CK ck_tile kernel |
| `kernel_moe_gemm` | `aiter/fused_moe.py:1688` | CK kernel |
