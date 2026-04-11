# Kernel Walkthrough: RoPE (kn_entry_2c_sbhd_cached_indirect_inplace)

> Source: aiter | Language: HIP C++ | File: `aiter/csrc/kernels/rope/rope_common.h`

## Overview

Rotary Position Embedding: applies 2D rotation to Q and K vectors based on token position.
Each pair of dimensions (x_2i, x_2i+1) is rotated by angle theta_i * position.

This kernel is **2-channel** (processes Q and K together), **inplace** (overwrites input),
and uses **indirect position indexing** (position IDs looked up from a buffer).

---

## 1. Host Side

### Python Entry

```
aiter/rotary_embedding.py:256  forward_hip()
  → aiter/ops/rope.py:833     rope_cached_positions_2c_fwd_inplace()
    → C++: rope_cached_positions_2c_fwd_impl()
```

### Tensor Shapes (Qwen3-30B-A3B)

```
query:     [1, num_tokens, 32, 128]   (32 Q heads, head_dim=128)
key:       [1, num_tokens, 4,  128]   (4 KV heads)
cos_cache: [max_pos, 1, 1, 64]        (d//2 = 64, precomputed)
sin_cache: [max_pos, 1, 1, 64]
positions: [1, num_tokens]             (indirect: token → position mapping)
```

`reuse_freqs_front_part=True`: cos/sin only store d//2 values, reused for both halves.

### C++ Host Dispatch

```
aiter/csrc/kernels/rope/pos_fwd_kernels.cu:96

void rope_cached_positions_2c_fwd_impl(
    output_x, output_y,      // Q out, K out (same as input for inplace)
    input_x, input_y,        // Q in, K in
    cos, sin,                // precomputed cos/sin cache
    positions,               // indirect position buffer
    rotate_style=0,          // NEOX style
    reuse_freqs_front_part=true,
    nope_first=false)
```

### Grid/Block Configuration

```cpp
Grid:  (size_s, size_b, 1)  = (num_tokens, 1, 1)
Block: (256, 1, 1)  with __launch_bounds__(256, 8)

// 1 block per token, 256 threads
// 8 max blocks per CU (occupancy hint)
```

---

## 2. Device Kernel: Full Walkthrough

### Kernel Entry Point

```
rope_common.h:1902

kn_entry_2c_sbhd_cached_indirect_inplace<
    OpCachedFwd,               // operation: forward rotation
    RotateStyle=0,             // NEOX layout
    ReuseFreqsFrontPart=true,  // d//2 cos/sin
    NopeFirst=false,           // rotate front dims
    StrideDXEq1=true,         // contiguous dim stride
    StrideDYEq1=true>
```

### Step 1: Fetch Position (Indirect Indexing)

```cpp
const uint64_t sid = blockIdx.x;        // sequence index (which token)
const uint64_t bid = blockIdx.y;        // batch index (always 0 for bs=1)
const uint64_t ib_idx = sid * gridDim.y + bid;

// KEY: look up actual position from indirect buffer
const int64_t pos = p_indirect_buffer[ib_idx];
// e.g., token at seq_idx=5 might have position=42 (due to KV cache offset)
```

Why indirect? During decode, new tokens don't start at position 0 — they continue
from where prefill left off. The position buffer maps token index → absolute position.

### Step 2: Bounds Check

```cpp
if ((pos >= 0) && (pos < max_position)) {
    // valid position, proceed
} else {
    // skip this token (padding or invalid)
    return;
}
```

### Step 3: Compute Memory Offsets

```cpp
const uint64_t offset_x = sid * stride_x_s + bid * stride_x_b;  // Q base
const uint64_t offset_y = sid * stride_y_s + bid * stride_y_b;  // K base
const int64_t offset_f  = pos * size_f;                          // cos/sin offset

// For Qwen3: offset_f = pos * 64 (index into cos/sin cache)
```

### Step 4: Call OpCachedFwd::apply_2c

This is where the actual rotation happens. Defined at `rope_common.h:812`.

```
Thread assignment within the block:

256 threads total, working on:
  - 32 Q heads + 4 K heads
  - 64 dimension pairs (head_dim=128, half=64)

threadIdx.x: iterates over dimension pairs (0..63)
  → 256/64 = 4 threads per dimension (but only 64 used, rest idle? No...)
  → Actually: for(did = threadIdx.x; did < 64; did += blockDim.x)
  → With blockDim.x=256, each thread handles at most 1 dim pair
  → 256 threads for 64 dim pairs = 4x oversubscribed
  → First 64 threads do 1 pair each, threads 64-255 idle for dim loop
  → BUT: they handle different heads via the head loop
```

Wait, let me re-examine. The kernel uses a 2D thread mapping:

```
Actually: blockDim = (256, 1, 1) as 1D block

The loops:
  for (did = threadIdx.x; did < size_half_r; did += blockDim.x)
    for (hid = threadIdx.y; hid < num_heads; hid += blockDim.y)

With blockDim.y=1, each thread processes ALL heads serially.
With blockDim.x=256 and size_half_r=64:
  - Threads 0-63: each handles 1 dimension pair
  - Threads 64-255: idle (did >= 64, loop doesn't execute)
```

This means for Qwen3 (head_dim=128, half=64), only **64 out of 256 threads** are active.
The remaining 192 threads are wasted. This is acceptable because:
1. The kernel is already launch-bound (~6 us)
2. Larger block size helps with L1 cache and register allocation
3. Same kernel handles larger head_dim (256+) where all threads are used

### Step 5: Load cos/sin

```cpp
// load_cos_sin_cached<NEOX, forward, reuse_front_part=true>

// With reuse_freqs_front_part=true:
float cos_0 = float(p_cos[offset_f + did]);    // cos for dim pair
float sin_0 = float(p_sin[offset_f + did]);    // sin for dim pair
float cos_1 = cos_0;    // REUSE same cos/sin for both elements
float sin_1 = sin_0;

// Each thread loads 1 cos + 1 sin value from cache
// Cache is indexed by: position * 64 + dim_pair_index
```

### Step 6: Rotation per Head

```cpp
for (int hid = 0; hid < num_heads; hid++) {
    // Load 2 input elements (the pair to rotate)
    float in_0, in_1;
    load_payload<NEOX>(
        &in_0, &in_1, p_input, did, hid, stride_d, stride_h, size_half_r);

    // NEOX layout: in_0 = input[hid][did], in_1 = input[hid][did + 64]
    // (first half and second half of head_dim)
```

#### NEOX vs GPTJ Rotation Styles

```
NEOX (style 0) - used by Qwen3:
  head_dim = [x0, x1, ..., x63, x64, x65, ..., x127]
              \--- first half ---/ \--- second half --/
  Pairs: (x0, x64), (x1, x65), ..., (x63, x127)

GPTJ (style 1):
  head_dim = [x0, x1, x2, x3, ..., x126, x127]
  Pairs: (x0, x1), (x2, x3), ..., (x126, x127)
```

### Step 7: Apply 2D Rotation Matrix

```cpp
// The core math (2 multiply + 1 add + 1 sub per element):
float out_0 = in_0 * cos_0 - in_1 * sin_0;
float out_1 = in_1 * cos_1 + in_0 * sin_1;

// With cos_0 == cos_1 and sin_0 == sin_1 (reuse_front_part=true):
// out_0 = in_0 * cos - in_1 * sin
// out_1 = in_1 * cos + in_0 * sin
//
// This is the standard 2D rotation matrix:
// [out_0]   [cos  -sin] [in_0]
// [out_1] = [sin   cos] [in_1]
```

### Step 8: Store (Inplace)

```cpp
store_payload<NEOX>(p_output, out_0, out_1, did, hid, stride_d, stride_h, half_r);
// p_output == p_input (inplace), overwrites original Q/K data
```

### Step 9: Handle Q and K Separately

The "2c" (2-channel) variant processes both Q (channel X) and K (channel Y)
in the same kernel launch, using the same cos/sin values but different head counts.

```cpp
// Process Q heads (size_h_x = 32)
for (hid = 0; hid < 32; hid++) {
    rotate(p_inout_x, hid, cos, sin);  // Q
}

// Process K heads (size_h_y = 4)
for (hid = 0; hid < 4; hid++) {
    rotate(p_inout_y, hid, cos, sin);  // K
}

// Total work per block: (32 + 4) * 64 = 2304 rotations
// With 64 active threads: each thread does 36 rotations serially
```

---

## 3. Data Flow Diagram

```
cos_cache [max_pos, 64]
sin_cache [max_pos, 64]
positions [num_tokens]
     |
     v
 +---+---------------------------+
 | pos = positions[token_idx]    |  Indirect lookup
 | cos = cos_cache[pos, :]       |  → 64 values
 | sin = sin_cache[pos, :]       |  → 64 values
 +---+---------------------------+
     |
     v   For each head (32 Q + 4 K):
 +---+---------------------------+
 | in_0 = head[did]              |  First half
 | in_1 = head[did + 64]         |  Second half
 |                               |
 | out_0 = in_0*cos - in_1*sin   |  Rotation
 | out_1 = in_1*cos + in_0*sin   |
 |                               |
 | head[did]      = out_0        |  Write back (inplace)
 | head[did + 64] = out_1        |
 +-------------------------------+
```

---

## 4. Performance Analysis

```
Per token computation:
  Q: 32 heads * 128 dims * 2 FLOP (mul+add) = 8192 FLOP
  K: 4  heads * 128 dims * 2 FLOP           = 1024 FLOP
  Total: 9216 FLOP per token

Per token memory:
  Read:  Q(32*128*2B) + K(4*128*2B) + cos(64*2B) + sin(64*2B) = 9.25 KB
  Write: Q(32*128*2B) + K(4*128*2B) = 9.0 KB (inplace)
  Total: ~18.25 KB

At 6-7 us per kernel:
  Bandwidth = 18.25 KB / 6.5 us = 2.8 GB/s
  Compute = 9216 / 6.5us = 1.4 GFLOP/s
  → Heavily launch-bound (not BW or compute limited)
```

---

## 5. Why "cached" + "indirect"?

### Cached
cos/sin values are **precomputed** for all possible positions [0, max_position)
and stored in a lookup table. At runtime, just index by position — no trig computation.

```python
# Precomputation (in RotaryEmbedding.__init__):
freqs = 1.0 / (theta ** (torch.arange(0, d, 2) / d))  # [d//2]
positions = torch.arange(0, max_pos)                     # [max_pos]
angles = positions.unsqueeze(1) * freqs.unsqueeze(0)     # [max_pos, d//2]
cos_cache = torch.cos(angles)                            # [max_pos, d//2]
sin_cache = torch.sin(angles)                            # [max_pos, d//2]
```

### Indirect
Position IDs are passed as a buffer, not assumed sequential.
This is essential for:
- **KV cache**: during decode, token positions are not contiguous (e.g., [91, 92, 93...])
- **Variable-length batching**: different requests in a batch have different position offsets
- **Speculative decoding**: multiple candidate tokens at different positions

---

## 6. Source File Index

| File | Content |
|------|---------|
| `aiter/rotary_embedding.py:256` | `forward_hip()` — Python high-level dispatch |
| `aiter/ops/rope.py:833` | `rope_cached_positions_2c_fwd_inplace()` |
| `aiter/csrc/kernels/rope/pos_fwd_kernels.cu:96` | C++ host: kernel launch + stride extraction |
| `aiter/csrc/kernels/rope/rope_common.h:1902` | **Kernel entry**: `kn_entry_2c_sbhd_cached_indirect_inplace` |
| `aiter/csrc/kernels/rope/rope_common.h:812` | **Core rotation**: `OpCachedFwd::apply_2c` |
| `aiter/csrc/kernels/rope/rope_common.h:119` | `load_cos_sin_cached` helper |
| `aiter/csrc/kernels/rope/rope_common.h:234` | `load_payload` / `store_payload` helpers |
| `aiter/csrc/kernels/rope/rope_common.h:3180` | `dispatch_2c_sbhd_cached_indirect` (grid setup) |
