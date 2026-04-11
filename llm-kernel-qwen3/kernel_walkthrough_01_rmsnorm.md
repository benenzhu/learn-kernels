# Kernel Walkthrough: RMSNorm (add_rmsnorm_quant_kernel)

> Source: aiter | Language: HIP C++ | File: `aiter/csrc/kernels/rmsnorm_quant_kernels.cu`

## Overview

A single fused kernel that does up to 3 operations in one pass:
1. **Residual Add**: `x = input + residual` (optional)
2. **RMSNorm**: `x = x / sqrt(mean(x^2) + eps) * weight`
3. **Quantization**: `x_quant = round(x / scale)` to FP8/INT8/FP4 (optional)

All controlled by template booleans `ADD_RESIDUAL` and `FUSE_QUANT`.

---

## 1. Host Side: Python → C++ → Kernel Launch

### Python Entry

```
aiter/ops/rmsnorm.py
  rmsnorm2d_fwd()           → calls aiter::rmsnorm       (no add, no quant)
  rmsnorm2d_fwd_with_add()  → calls aiter::add_rmsnorm   (add, no quant)
```

For Qwen3 (hidden_size=2048), the custom HIP kernel is used (CK version only for >8192).

### C++ Host Dispatch

```
aiter/csrc/kernels/rmsnorm_quant_kernels.cu

void add_rmsnorm(out, input, residual_in, residual_out, weight, epsilon)
void rmsnorm(out, input, weight, epsilon)
```

### Grid/Block Selection (based on hidden_size n)

```
n = 2048 for Qwen3-30B-A3B:

 n range       | BlockSize | thread_data_size | elements/block
 --------------|-----------|------------------|----------------
 n <= 512      |    64     |        8         |   64 * 8 = 512
 512 < n <=1024|   128     |        8         |  128 * 8 = 1024
 1024< n <=2048|   256     |        8         |  256 * 8 = 2048  <-- Qwen3
 2048< n <=4096|   256     |       16         |  256 *16 = 4096
 4096< n <=6144|   256     |       24         |  256 *24 = 6144
 6144< n <=8192|   256     |       32         |  256 *32 = 8192
```

For Qwen3 (n=2048): **BlockSize=256, thread_data_size=8**
- Each thread handles 8 bf16 elements
- 256 threads * 8 = 2048 elements = exactly 1 row
- **1 block processes 1 row** (1 token)

### Kernel Launch

```cpp
dim3 grid(m);           // m = num_tokens, 1 block per token
dim3 block(256);        // 256 threads per block

add_rmsnorm_quant_kernel<bf16, bf16, 256, 8, ADD_RESIDUAL=true, FUSE_QUANT=false>
    <<<grid, block, 0, stream>>>(out, residual_out, scale,
                                  input, residual_in, weight,
                                  epsilon, m, n, ...);
```

---

## 2. Device Kernel: Line-by-Line Walkthrough

### Template Parameters

```cpp
template <
    typename DTYPE_I,       // bf16 (input type)
    typename DTYPE_O,       // bf16 (output type, or fp8/int8 if quantizing)
    int BlockSize,          // 256 (threads per block)
    int thread_data_size,   // 8 (elements per thread)
    bool ADD_RESIDUAL,      // true/false
    bool FUSE_QUANT,        // true/false
    bool interleave,        // false for n<=2048
    int num_row>            // 1 (rows per block)
```

### Step 1: Vectorized Load Setup

```cpp
// For bf16, thread_data_size=8:
//   8 * 2 bytes = 16 bytes per thread → load_chunk_bytes = 16
//   load_vec_size = 16/2 = 8 elements per load instruction
//   num_load_inst = 8/8 = 1 (single 128-bit load!)

static constexpr int32_t load_chunk_bytes = 16;  // 128-bit load
static constexpr int32_t load_vec_size = 8;       // 8 x bf16
static constexpr int32_t num_load_inst = 1;       // 1 instruction
```

Key insight: each thread does a **single 128-bit vector load** to fetch all 8 bf16 elements.

### Step 2: Thread-to-Data Mapping

```
Thread layout for n=2048, BlockSize=256, thread_data_size=8:

Thread 0:   elements [0..7]
Thread 1:   elements [8..15]
Thread 2:   elements [16..23]
...
Thread 255: elements [2040..2047]

Total: 256 * 8 = 2048 = n (perfect coverage)
```

```cpp
int row_offset = tid * thread_data_size;  // = tid * 8
// Thread 0 → offset 0, Thread 1 → offset 8, ...
```

### Step 3: Load Data

```cpp
// Load input[row, offset..offset+7] (128-bit vector load)
vec_i thread_data_i = load_vector_nbytes<bf16, 8, 16, ...>(buffer_i, row_offset);

// Load weight[offset..offset+7]
vec_i thread_data_weight = load_vector_nbytes<bf16, 8, 16, ...>(weight_buffer, row_offset);

// If ADD_RESIDUAL: load residual_in[row, offset..offset+7]
vec_i thread_data_residual_in = load_vector_nbytes<bf16, 8, 16, ...>(...);
```

### Step 4: Residual Add (if ADD_RESIDUAL)

```cpp
// Each thread: 8 additions in float32
for (int i = 0; i < 8; i++) {
    thread_data_float[i] = float(input[i]) + float(residual_in[i]);
}

// Store result to residual_out (for next layer's residual)
store_vector(buffer_residual_out, thread_data_float, row_offset);
```

Output: `residual_out = input + residual_in` (the new residual for next sub-layer)

### Step 5: Compute Sum of Squares (local)

```cpp
float square_sum = 0.0f;
for (int i = 0; i < 8; i++) {
    square_sum += thread_data_float[i] * thread_data_float[i];
}
// Each thread now holds sum of squares for its 8 elements
```

### Step 6: Block-Wide Reduce (sum of squares)

```cpp
// Two-level reduction:
//   Level 1: warp-level reduce (64 threads → 1 value per warp)
//   Level 2: cross-warp reduce via shared memory (4 warps → 1 value)

float total_sq = block_reduce<float, sum_op, 256, true>(square_sum, sum_f);
// Result broadcast to ALL threads in block
```

Block reduce implementation:
```
Warp 0 (threads 0-63):   wave_reduce → lane 63 writes to smem[0]
Warp 1 (threads 64-127): wave_reduce → lane 63 writes to smem[1]
Warp 2 (threads 128-191):wave_reduce → lane 63 writes to smem[2]
Warp 3 (threads 192-255):wave_reduce → lane 63 writes to smem[3]
__syncthreads()
smem[0..3] → wave_reduce across 4 values → broadcast to all threads
```

### Step 7: RMSNorm Scale

```cpp
// rcp = 1 / sqrt(sum_of_squares / n + epsilon)
float rcp = rsqrtf(total_sq / 2048 + 1e-6);
```

### Step 8: Normalize + Weight (using AMD v_pk_mul_f32)

```cpp
// Pack rcp into vec2 for packed multiply
vec2_f rcp_pair = {rcp, rcp};

// Multiply normalized values by rcp (2 floats at a time)
for (int i = 0; i < 4; i++) {  // 8 elements / 2 = 4 pairs
    asm volatile("v_pk_mul_f32 %0, %1, %2"
        : "=v"(data_pair[i])
        : "v"(data_pair[i]), "v"(rcp_pair));
}

// Multiply by weight (2 floats at a time)
for (int i = 0; i < 4; i++) {
    vec2_f w = {float(weight[2*i]), float(weight[2*i+1])};
    asm volatile("v_pk_mul_f32 %0, %1, %2"
        : "=v"(data_pair[i])
        : "v"(data_pair[i]), "v"(w));
}
```

`v_pk_mul_f32` is an AMD GFX9+ instruction that multiplies **2 float32 values** in a single instruction cycle. This doubles the throughput for element-wise multiply.

### Step 9: Store Output

```cpp
// If no quantization (Qwen3 RMSNorm case):
store_vector<bf16, float, 8, ...>(buffer_out, thread_data_float, row_offset);
// Converts float32 → bf16 and writes 128-bit vector
```

### Step 10: Multi-Row with Prefetch

```cpp
// If num_row > 1: process multiple rows per block with prefetching
for (int r = 0; r < num_row - 1; r++) {
    core_loop(std::true_type{});   // with prefetch: load next row while computing
    idx += 1;
}
core_loop(std::false_type{});      // last row: no prefetch
```

Prefetch hides memory latency: while computing RMSNorm for row N, load data for row N+1.

---

## 3. Memory Access Pattern

```
For 1 token (1 row, n=2048, bf16):

READ:
  input:        2048 * 2B =  4 KB
  residual_in:  2048 * 2B =  4 KB  (if ADD_RESIDUAL)
  weight:       2048 * 2B =  4 KB  (shared across all tokens, cached in L2)

WRITE:
  residual_out: 2048 * 2B =  4 KB  (if ADD_RESIDUAL)
  output:       2048 * 2B =  4 KB

Total per token:
  Without add: read 8KB + write 4KB = 12KB
  With add:    read 12KB + write 8KB = 20KB

At ~3-4 us per kernel:
  Bandwidth = 20KB / 3.5us = ~5.7 GB/s
  MI355X peak = ~8 TB/s
  Utilization = 0.07% (extremely low — kernel is launch-bound, not compute/BW-bound)
```

This shows that for small n=2048, the kernel is **launch-overhead dominated** (~3 us HIP launch), not memory or compute bound.

---

## 4. AMD ISA Instructions Used

| Instruction | Purpose | Throughput |
|-------------|---------|-----------|
| `v_pk_mul_f32` | Packed 2x float32 multiply | 2 FLOP/cycle/thread |
| `v_max3_f32` | 3-operand max (for quant) | 1 op/cycle |
| `v_rcp_f32` | Fast reciprocal 1/x | 1 op/cycle |
| `rsqrtf()` | Reciprocal sqrt | ~4 cycles |
| Wave shuffle | Warp-level reduce | 1 cycle/step |

---

## 5. Variant Summary for Qwen3

| Call Site | Kernel Config | Purpose |
|-----------|--------------|---------|
| Layer 0 input_layernorm | `<bf16, bf16, 256, 8, false, false>` | RMSNorm only, no residual |
| Layer 1-47 input_layernorm | `<bf16, bf16, 256, 8, true, false>` | Add residual + RMSNorm |
| All post_attn_layernorm | `<bf16, bf16, 256, 8, true, false>` | Add residual + RMSNorm |
| Final model.norm | `<bf16, bf16, 256, 8, true, false>` | Add residual + RMSNorm |

Note: No quantization (`FUSE_QUANT=false`) in Qwen3's RMSNorm. Quantization is only used when feeding into FP8 GEMM (not the case here since MoE GEMM takes bf16 input).

---

## 6. Source File Index

| File | Content |
|------|---------|
| `aiter/ops/rmsnorm.py:62,76` | Python entry: `rmsnorm2d_fwd`, `rmsnorm2d_fwd_with_add` |
| `atom/model_ops/layernorm.py:59,68,210` | atom wrapper: dispatches to aiter |
| `aiter/csrc/kernels/rmsnorm_quant_kernels.cu:14-291` | **HIP kernel** (full implementation) |
| `aiter/csrc/kernels/rmsnorm_quant_kernels.cu:293-450` | Host launch + dispatch macros |
| `aiter/csrc/include/hip_reduce.h:195-235` | `block_reduce` (warp + cross-warp reduce) |
| `aiter/csrc/include/aiter_opus_plus.h:381-411` | `load_vector_nbytes` (vectorized loads) |
| `aiter/csrc/include/aiter_opus_plus.h:520-560` | `store_vector` (vectorized stores) |
