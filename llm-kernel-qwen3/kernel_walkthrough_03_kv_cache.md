# Kernel Walkthrough: KV Cache Store (reshape_and_cache_with_per_token_quant_kernel)

> Source: aiter | Language: HIP C++ | File: `aiter/csrc/kernels/cache_kernels.cu:327`

## Overview

After computing K, V for the current step, this kernel:
1. **Quantizes** K and V from BF16 to FP8 (per-token scale)
2. **Writes** them into the paged KV cache at the correct block/offset

One kernel handles both K and V simultaneously.

---

## 1. Host Side

### Python Entry

```
atom/model_ops/attention_mha.py:120  rope_cache()
  → aiter::reshape_and_cache_with_pertoken_quant (C++ pybind)
```

Called right after RoPE — the `rope_cache()` function does both RoPE and KV cache store.

### C++ Host Launch

```cpp
// cache_kernels.cu:3026
dim3 grid(num_tokens, num_heads);   // (num_tokens, 4) for Qwen3
dim3 block(64);                      // 1 warp = 64 threads (AMD wavefront)

reshape_and_cache_with_per_token_quant_kernel<bf16, fp8, float, asmLayout=true>
    <<<grid, block, 0, stream>>>(...);
```

### Grid/Block for Qwen3

```
grid.x = num_tokens (1 for decode, 91 for prefill)
grid.y = num_heads = 4 (KV heads)
block  = 64 threads (1 warp/wavefront)

Each block (1 warp) processes: 1 token, 1 head, all 128 dims
```

---

## 2. Device Kernel: Full Walkthrough

### Template Parameters

```cpp
template <
    typename scalar_t,         // bf16 (input K, V dtype)
    typename cache_t,          // fp8_t (FP8 E4M3, cache dtype)
    typename dequant_scale_t,  // float (scale dtype)
    bool asmLayout = false,    // true: ASM-friendly layout for PA kernel
    int wg_size = 256>         // workgroup size (but we launch 64)
```

### Step 1: Thread Assignment

```cpp
const int32_t tokens_per_wg = wg_size / warpSize;  // 256/64 = 4
int wave_id = threadIdx.x / warpSize;   // which wave in workgroup (0)
int lane_id = threadIdx.x % warpSize;   // lane within wave (0..63)

const int64_t token_idx = blockIdx.x * tokens_per_wg + wave_id;  // token index
const int32_t head_idx  = blockIdx.y;   // head index (0..3)
```

Since we launch with block=64, there's only 1 wave per block, so wave_id=0.

### Step 2: Slot Mapping (Logical → Physical)

```cpp
const int64_t slot_idx = slot_mapping[token_idx];
// slot_idx maps logical token position → physical cache slot

if (token_idx >= num_tokens || slot_idx < 0)
    return;  // padding token, skip

const int64_t block_idx    = slot_idx / block_size;   // which physical block
const int64_t block_offset = slot_idx % block_size;   // position within block
// For block_size=64: slot 130 → block 2, offset 2
```

### Step 3: Load K and V (Vectorized by Warp)

```cpp
constexpr int local_dim_elems = 8;  // each lane handles up to 8 dims

float k_local_dim[8] = {0};
float v_local_dim[8] = {0};

for (int i_d = 0; i_d < 8; i_d++) {
    int current_d = lane_id + i_d * warpSize;  // lane 0: dims 0,64; lane 1: dims 1,65; ...
    if (current_d < head_size) {                // head_size=128
        k_local_dim[i_d] = float(key[token_idx, head_idx, current_d]);
        v_local_dim[i_d] = float(value[token_idx, head_idx, current_d]);
    }
}
```

Data distribution across 64 lanes:

```
head_size = 128, warpSize = 64, local_dim_elems = 8

Lane 0:  dims [0, 64]         (2 elements used, 6 unused)
Lane 1:  dims [1, 65]
Lane 2:  dims [2, 66]
...
Lane 63: dims [63, 127]

Total: 64 lanes * 2 dims = 128 = head_size (perfect coverage)
```

### Step 4: Compute Per-Token Absmax (Warp Reduce)

```cpp
// Local max per lane
float k_local_max = max(abs(k_local_dim[0]), abs(k_local_dim[1]));  // over 2 elements

// Warp-level reduce: find max across all 64 lanes
float k_max = wave_reduce(k_local_max, fmax);
// Now ALL lanes have the same k_max (broadcast)

float v_local_max = max(abs(v_local_dim[0]), abs(v_local_dim[1]));
float v_max = wave_reduce(v_local_max, fmax);
```

`wave_reduce` uses AMD's warp shuffle instructions to reduce across 64 lanes in ~6 steps.

### Step 5: Compute Scale

```cpp
float dtypeMax = 448.0f;  // FP8 E4M3 max value

float k_token_scale = k_max / dtypeMax;           // e.g., 3.5 / 448 = 0.00781
float v_token_scale = v_max / dtypeMax;

float k_token_scale_inverted = 1.0 / k_token_scale;  // = 448 / 3.5 = 128.0
float v_token_scale_inverted = 1.0 / v_token_scale;
```

### Step 6: Quantize (Scale to FP8 Range)

```cpp
for (int i_d = 0; i_d < 8; i_d++) {
    k_local_dim[i_d] = k_local_dim[i_d] * k_token_scale_inverted;
    // Maps [-k_max, k_max] → [-448, 448] (FP8 range)
    v_local_dim[i_d] = v_local_dim[i_d] * v_token_scale_inverted;
}
```

### Step 7: Store Scale

```cpp
if constexpr (asmLayout) {
    // ASM PA kernel expects: [num_blocks, num_heads, block_size]
    scale_idx = block_size * num_heads * block_idx
              + block_size * head_idx
              + block_offset;
} else {
    // Default: [num_heads, max_kv_tokens]
    scale_idx = head_idx * max_kv_tokens + slot_idx;
}

k_dequant_scales[scale_idx] = k_token_scale;
v_dequant_scales[scale_idx] = v_token_scale;
// Only need 1 lane to write (all lanes have same value after reduce)
// But all lanes write the same value (redundant but harmless)
```

### Step 8: Store Quantized K, V to Paged Cache

```cpp
for (int i = 0; i < local_dim_elems; i++) {
    int i_d = lane_id + i * warpSize;
    if (i_d >= head_size) break;

    // K cache layout: [num_blocks, num_heads, head_size/x, block_size, x]
    //   x = vectorization factor (e.g., 16 for 128-bit vector loads in PA)
    const int x_idx    = i_d / x;       // which x-group
    const int x_offset = i_d % x;       // offset within x-group

    tgt_key_idx = block_idx * num_heads * (head_size/x) * block_size * x
                + head_idx * (head_size/x) * block_size * x
                + x_idx * block_size * x
                + block_offset * x
                + x_offset;

    key_cache[tgt_key_idx] = cast<fp8>(k_local_dim[i]);
    value_cache[tgt_value_idx] = cast<fp8>(v_local_dim[i]);
}
```

The complex indexing ensures K cache is laid out for efficient vector loads
during Paged Attention (PA reads block_size consecutive tokens at once).

---

## 3. KV Cache Memory Layout

### K Cache: `[num_blocks, num_heads, head_size/x, block_size, x]`

```
x = vectorization factor (e.g., 16 for FP8)

For head_size=128, block_size=64, x=16:
  Shape: [num_blocks, 4, 8, 64, 16]

Physical layout (for 1 block, 1 head):
  Group 0: tokens[0..63] for dims [0..15]    (64 * 16 = 1024 bytes)
  Group 1: tokens[0..63] for dims [16..31]   (64 * 16 = 1024 bytes)
  ...
  Group 7: tokens[0..63] for dims [112..127] (64 * 16 = 1024 bytes)

This layout enables PA to load all 64 tokens' K values for a dim-group
with a single coalesced memory access pattern.
```

### V Cache (ASM layout): `[num_blocks, num_heads, block_size/X, head_size, X]`

```
Different from K cache! Optimized for V's access pattern in attention.
```

### Scale Layout (ASM): `[num_blocks, num_heads, block_size]`

```
1 float32 scale per (block, head, token_within_block)
Used by PA kernel to dequantize: value_bf16 = value_fp8 * scale
```

---

## 4. Performance Analysis

```
Per token, per head:
  Read:  K[128] bf16 = 256 bytes
         V[128] bf16 = 256 bytes
  Write: K_cache[128] fp8 = 128 bytes
         V_cache[128] fp8 = 128 bytes
         k_scale fp32 = 4 bytes
         v_scale fp32 = 4 bytes
  Total: 512 bytes read + 264 bytes write = 776 bytes

Per token (all 4 KV heads):
  776 * 4 = 3104 bytes

At ~4 us per kernel:
  BW = 3104 / 4 us = 776 MB/s
  → Heavily launch-bound (MI355X can do 8 TB/s)
```

---

## 5. Quantization Precision

```
FP8 E4M3:
  - 4 exponent bits, 3 mantissa bits + 1 sign bit = 8 bits
  - Range: [-448, 448]
  - Precision: ~1/8 mantissa → relative error ~6-12%

Per-token vs Per-tensor:
  Per-tensor: 1 scale for entire KV cache → high quantization error
  Per-token:  1 scale per token per head  → adapts to each token's magnitude
  → Per-token is ~2x more accurate for KV cache

Cost of per-token scales:
  4 bytes per token per head = 4 * 4 = 16 bytes per token
  vs KV data: 128 * 2 = 256 bytes per token per head
  Overhead: 16/256 = 6.25% (negligible)
```

---

## 6. Source File Index

| File | Content |
|------|---------|
| `atom/model_ops/attention_mha.py:120` | `rope_cache()` — calls both RoPE and KV cache store |
| `aiter/csrc/kernels/cache_kernels.cu:327-472` | **HIP kernel** (full implementation) |
| `aiter/csrc/kernels/cache_kernels.cu:3005-3050` | Host launch code (grid/block config) |
| `aiter/csrc/kernels/cache_kernels.cu:2717` | Launch macro `CALL_RESHAPE_AND_CACHE_WITH_PERTOKEN_QUANT` |
