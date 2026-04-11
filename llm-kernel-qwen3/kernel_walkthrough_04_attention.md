# Kernel Walkthrough: Flash Attention & Paged Attention

> Source: aiter | Language: **Hand-written ASM** (.co binary) | Host dispatch in HIP C++

These are the most complex kernels in the pipeline. Both are hand-written GCN assembly
optimized for gfx950 (MI355X), shipped as precompiled `.co` (code object) binaries.

We can't read the device code, but we can fully trace the host-side dispatch
and understand the algorithm from the interface.

---

## Part A: Flash Attention v3 (Prefill)

### Kernel

```
Name: fmha_fwd_hd128_bf16_causal_group
Binary: /app/aiter-test/hsa/gfx950/fmha_v3_fwd/fwd_hd128_bf16_causal_group.co
Loaded via: hipModuleLoad + hipModuleGetFunction
```

### Python Entry

```
aiter/ops/mha.py:2543  flash_attn_varlen_func()
  → mha.py:2342  FlashAttnVarlenFunc.forward()
    → mha.py:1980  _flash_attn_varlen_forward()
      → aiter::fmha_v3_varlen_fwd (C++ JIT compiled)
```

### Host-Side Dispatch Decision

```python
# mha.py:1292-1303 — can_impl_fmha_v3_fwd()
# v3 is chosen when ALL of:
#   - No alibi slopes, no bias, no dropout
#   - head_dim_v == 128
#   - head_dim_q == 128 or 192
#   - num_heads_q % num_heads_k == 0 (GQA compatible)
#   - No sliding window
#   - BF16 or FP8
#   - seqlen_q > 128 (for short sequences, v2 may be better)
```

### Function Signature

```python
fmha_v3_varlen_fwd(
    q, k, v,                      # [total_tokens, num_heads, head_dim] bf16
    cu_seqlens_q, cu_seqlens_k,    # cumulative sequence lengths [batch+1]
    max_seqlen_q, max_seqlen_k,    # max seq lengths
    softmax_scale,                 # 1/sqrt(head_dim) = 1/sqrt(128) = 0.0884
    is_causal=True,                # causal masking
    out=None,                      # output tensor
    block_table=None,              # for paged KV (not used in prefill)
)
```

### Algorithm: Flash Attention

```
Standard Flash Attention tiling:

For each Q block (tile_q):
  For each K block (tile_k):
    1. Compute S = Q_tile @ K_tile^T              # [tile_m, tile_n]
    2. Apply causal mask (set future positions to -inf)
    3. Online softmax:
       m_new = max(m_old, rowmax(S))              # running max
       P = exp(S - m_new)                         # attention weights
       l_new = l_old * exp(m_old - m_new) + rowsum(P)  # running sum
    4. Update output:
       O = O * exp(m_old - m_new) * (l_old/l_new) + P @ V_tile * (1/l_new)

Key properties:
  - O(N) extra memory (not O(N^2))
  - Single pass over K, V (streaming)
  - Numerically stable via online softmax

Tile sizes (from CK codegen):
  For hd=128: typical tile_m=64-128, tile_n=64-128, tile_k=128
  These are hardware-tuned for gfx950's SRAM/register file
```

### GQA Handling

```
Qwen3: 32 Q heads, 4 KV heads → group_size = 8

"group" in kernel name means:
  8 Q heads share the same K, V head
  K, V are loaded once and broadcast to 8 Q computations
  Reduces KV memory reads by 8x
```

### Performance (Qwen3 prefill, seq=91)

```
~10-11 us per layer (very fast — short sequence)
With longer sequences (2048+), this becomes the dominant cost.

Arithmetic intensity for seq=91:
  Compute: 2 * 91^2 * 128 * 32 heads = ~68 GFLOP
  Memory: Q(91*32*128*2B) + K(91*4*128*2B) + V(91*4*128*2B) + O(91*32*128*2B) = ~1.6 MB
  AI = 68G / 1.6M = ~42 FLOP/byte → compute-bound
```

---

## Part B: Paged Attention (Decode)

### Kernel

```
Name: pa_bf16_pertokenFp8_gqa8_2tg_4w
Binary: /app/aiter-test/hsa/gfx950/pa/pa_bf16_pertokenFp8_gqa8_2tg_4w.co
Loaded via: hipModuleLoad + hipModuleGetFunction
```

### Python Entry

```
aiter/ops/attention.py:129  pa_fwd_asm()
  → aiter::_pa_fwd_asm (C++ pybind, dispatches to ASM)

Selection logic (attention.py:193 paged_attention_common):
  → _should_use_asm_kernel(): ASM preferred when:
      - total_heads > 2 * num_CUs (enough parallelism)
      - head_size == 128
      - not int8 KV (or force ASM for int8)
```

### Kernel Name Decode

```
pa_bf16_pertokenFp8_gqa8_2tg_4w

pa          = Paged Attention
bf16        = Query dtype is BF16
pertokenFp8 = KV cache is FP8 with per-token dequant scales
gqa8        = GQA group size = 8 (8 Q heads per KV head)
2tg         = 2 tile groups (parallelism along sequence dim)
4w          = 4 warps per tile group (4 * 64 = 256 threads per group)
```

### Function Signature

```python
pa_fwd_asm(
    Q,              # [num_seqs, num_heads, head_size]  bf16
    K_cache,        # [num_blocks, num_kv_heads, head_size/x, block_size, x]  fp8
    V_cache,        # [num_blocks, num_kv_heads, block_size/X, head_size, X]  fp8
    block_tables,   # [num_seqs, max_num_blocks_per_seq]  int32
    context_lens,   # [num_seqs]  int32
    K_QScale,       # per-token K dequant scales
    V_QScale,       # per-token V dequant scales
    max_qlen=1,     # query length (1 for standard decode)
)
```

### Algorithm: Paged Attention

```
For each sequence (each request being served):
  Q = query[seq]                  # [1, num_heads, 128] bf16

  For each KV cache block in block_table[seq]:
    block_id = block_table[seq][block_idx]
    K_block = key_cache[block_id]   # [64, head_size] fp8
    V_block = value_cache[block_id] # [64, head_size] fp8

    # Dequantize K, V on the fly:
    K_bf16 = K_fp8 * k_scale[block_id, :, :]   # per-token scale
    V_bf16 = V_fp8 * v_scale[block_id, :, :]

    # Compute attention for this block:
    S = Q @ K_bf16^T              # [1, 64] attention scores
    S = S * softmax_scale         # 1/sqrt(128)

    # Online softmax (accumulate across blocks):
    m_new = max(m_old, max(S))
    P = exp(S - m_new)
    l_new = l_old * exp(m_old - m_new) + sum(P)
    O = O * correction + P @ V_bf16

  # Final normalization:
  O = O / l_new
```

### SplitK and Reduce

PA uses **splitK**: multiple thread groups process different blocks in parallel,
producing partial results that must be merged.

```
2 tile groups (2tg):
  Tile Group 0: processes blocks [0, 2, 4, ...]
  Tile Group 1: processes blocks [1, 3, 5, ...]

Each produces partial: (O_partial, m_partial, l_partial)

Then wv_splitk_small kernel merges:
  (O_0, m_0, l_0) + (O_1, m_1, l_1) → (O_final, m_final, l_final)
```

### Performance (Qwen3 decode, context=91)

```
PA kernel: 7-12 us per layer
wv_splitk:  3-4 us per layer
Total:     10-16 us per layer

For context length 91 (only ~2 cache blocks):
  Memory: 2 blocks * 64 * 128 * 1B (fp8) * 2 (K+V) = 32 KB
  → launch-bound at short context

For context length 4096:
  Memory: 64 blocks * 64 * 128 * 1B * 2 = 1 MB
  → memory-bandwidth bound
  PA time scales linearly with context length
```

---

## Part C: wv_splitk_small (PA Reduce)

### Kernel

```
Name: wv_splitk_small_fp16_bf16_kernel
File: aiter/csrc/kernels/custom_kernels.cu:437
Language: HIP C++ (not ASM)
```

### What It Does

Merges split-K partial attention results. Despite the name containing "splitk",
this kernel is actually used as a **skinny GEMM** for the O projection in decode.

From the trace, it appears in the call stack of `RowParallelLinear.forward()` →
`tuned_gemm.mm()` → `skinny_gemm()`, not directly in attention.

### Algorithm (Skinny GEMM for M=1)

```cpp
// Template: <bf16, THRDS=64, YTILE=1, WvPrGrp=1, A_CHUNK=8, UNRL=4, N=1>

// Each wave (64 threads) computes one output element of C = A @ B
// A: [N, K] activation (N=1 for decode)
// B: [M, K] weight matrix
// C: [N, M] output

// Each thread processes A_CHUNK=8 elements per iteration
// K dimension split across 64 lanes: stride = 64*8 = 512 per iteration
// UNRL=4: unroll 4 iterations before sync
```

### Key Implementation Details

```cpp
// Warp-level reduction using AMD ISA row_shr instructions:
asm("v_add_f32 %0, %2, %3 row_shr:8 ..."  // shift by 8 lanes
asm("v_add_f32 %0, %2, %3 row_shr:4 ..."  // shift by 4 lanes
asm("v_add_f32 %0, %2, %3 row_shr:2 ..."  // shift by 2 lanes
asm("v_add_f32 %0, %2, %3 wave_shr:1 ..." // shift by 1 lane
asm("v_add_f32 %0, %2, %3 row_bcast:15 ..."  // broadcast within row
asm("v_add_f32 %0, %2, %3 row_bcast:31 ..."  // broadcast across rows

// 6 instructions → full 64-lane reduction
// Thread 63 (lane 63) writes the final result
```

### Performance

```
~3-4 us per layer
For M=1, K=4096, N=2048 (O projection):
  Compute: 2 * 4096 * 2048 = 16.8 MFLOP
  Weight read: 4096 * 2048 * 2B = 16 MB
  → Heavily memory-bound (AI = 1.0 FLOP/byte)
```

---

## Source File Index

| File | Content |
|------|---------|
| `aiter/ops/mha.py:1980,2342,2543` | Flash Attention Python API |
| `aiter/ops/attention.py:129,193` | Paged Attention Python dispatch |
| `aiter/hsa/gfx950/fmha_v3_fwd/*.co` | Flash Attention v3 ASM binary |
| `aiter/hsa/gfx950/pa/*.co` | Paged Attention ASM binary |
| `aiter/csrc/kernels/custom_kernels.cu:437` | wv_splitk_small HIP kernel |
| `aiter/ops/custom.py:17` | wv_splitk Python entry |
