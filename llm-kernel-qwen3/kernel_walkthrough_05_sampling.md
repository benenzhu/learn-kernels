# Kernel Walkthrough: Sampling (mix_sample_outer_exponential_kernel)

> Source: aiter | Language: HIP C++ | File: `aiter/csrc/kernels/sample_kernels.cu`

## Overview

Fused kernel that combines temperature scaling + softmax + Gumbel-max sampling
in a **single pass** over the logits. No need for separate softmax → multinomial steps.

Key idea: instead of `softmax(logits/T)` then `multinomial(probs)`,
use the **Gumbel-max trick** with outer exponential noise.

---

## 1. Host Side

### Python Entry

```
atom/model_ops/sampler.py:91  _temperature_sample()
  → aiter::mixed_sample_outer_exponential (C++ pybind)
```

### C++ Host Launch

```cpp
// sample_kernels.cu:555-590
dim3 grid(M);          // M = batch size (number of sequences)
dim3 block(1024);      // 1024 threads per block

mix_sample_outer_exponential_kernel<bf16, 1024, 64, 4, true>
    <<<grid, block, 0, stream>>>(
        input,          // logits [M, N] bf16, N=151936 (vocab)
        exponentials,   // pre-generated exponential noise [M, N] float
        temperatures,   // [M] float, per-sequence temperature
        output,         // [M] int, sampled token IDs
        N, stride_M, exponentials_stride0, eps);
```

### Grid/Block for Qwen3

```
grid.x  = M (batch size, typically 1 in decode)
block   = 1024 threads
VecSize = 4 (each thread loads 4 elements at a time)

Each block processes: 1 sequence, all 151936 vocab entries
Stride: 1024 * 4 = 4096 elements per iteration
Iterations: 151936 / 4096 = ~37 iterations to cover full vocab
```

---

## 2. Kernel Entry Point

```cpp
// sample_kernels.cu:420-448
template <typename DTYPE_I, int BlockSize=256, int WarpSize=64, int VecSize=4, bool NeedSum=false>
__global__ void mix_sample_outer_exponential_kernel(
    const DTYPE_I* input,         // logits [M, N]
    const float* exponentials,    // Gumbel noise [M, N]
    const float* temperatures,    // [M]
    int* output,                  // [M] output token IDs
    int N, int stride_M, int exponentials_stride0, float eps)
{
    int m_idx = blockIdx.x;
    float temperature = temperatures[m_idx];

    if (temperature == 0.0f) {
        // Greedy: argmax(logits)
        argmax_impl<...>(input, output, m_idx, N, stride_M);
    } else {
        // Stochastic: Gumbel-max sampling
        random_sample_outer_exponential_impl<...>(
            input, exponentials, output,
            temperature, m_idx, N, stride_M, exponentials_stride0, eps);
    }
}
```

Temperature=0 → greedy argmax (deterministic).
Temperature>0 → Gumbel-max stochastic sampling.

---

## 3. Core Algorithm: random_sample_outer_exponential_impl

### The Gumbel-Max Trick

Standard sampling:
```
probs = softmax(logits / temperature)
token = multinomial(probs)  // requires CDF or sorting → expensive
```

Gumbel-max equivalent (single pass, no sorting):
```
For each vocab entry i:
  score[i] = softmax_prob[i] / exponential_noise[i]
token = argmax(score)    // just find max → cheap!
```

This works because `argmax(log(prob) + Gumbel_noise)` ≡ `multinomial(prob)`.
Using exponential noise with division is equivalent.

### Step-by-Step Walkthrough

#### Step 1: Initialize

```cpp
float max_softmax = -FLT_MAX;    // running softmax max (for numerical stability)
float sum_softmax = 0.0f;        // running softmax sum (if NeedSum=true)
kvp thread_kvp{0, -FLT_MAX};    // (index, value) pair for argmax

temperature = 1.0f / temperature; // precompute reciprocal
```

#### Step 2: Vectorized Loop Over Vocab

```cpp
// Each thread processes VecSize=4 elements per iteration
// 1024 threads * 4 = 4096 elements per iteration
// ~37 iterations for vocab_size=151936

for (k = threadIdx.x * 4; k < N; k += 1024 * 4) {
    // Load 4 logits + 4 exponential noise values
    vec_inp = load<bf16x4>(input, k);     // 4 logits
    vec_exp = load<float4>(exponentials, k); // 4 noise values
```

#### Step 3: Online Softmax + Gumbel Scoring (per 4-element vector)

```cpp
// a) Apply temperature + track running max
float new_max = max_softmax;
for (int i = 0; i < 4; i++) {
    vec_f[i] = float(vec_inp[i]) * temperature;  // logit / T
    new_max = max(new_max, vec_f[i]);
}

// b) Compute softmax numerator: exp(logit/T - max)
for (int i = 0; i < 4; i++) {
    vec_f[i] = expf(vec_f[i] - new_max);
}

// c) Correct previous accumulated values for new max
float ratio = expf(max_softmax - new_max);
thread_kvp.value *= ratio;    // rescale previous best score
max_softmax = new_max;

// d) Accumulate softmax denominator (if NeedSum)
sum_softmax = sum_softmax * ratio;
for (int i = 0; i < 4; i++) {
    sum_softmax += vec_f[i];
}

// e) Gumbel scoring: divide softmax prob by exponential noise
for (int i = 0; i < 4; i++) {
    vec_exp[i] += eps;                    // avoid div-by-zero
    vec_f[i] = vec_f[i] / vec_exp[i];    // THE KEY: prob / noise

    // Track argmax
    if (vec_f[i] > thread_kvp.value) {
        thread_kvp.key = k + i;           // vocab index
        thread_kvp.value = vec_f[i];       // score
    }
}
```

#### Step 4: Block-Wide Reduce

```cpp
// a) Find global max across all threads (for softmax correction)
float global_max = BlockReduce(max_softmax, fmax);
// Broadcast to all threads via shared memory

// b) If NeedSum: reduce sum for normalization
sum_softmax = sum_softmax * expf(max_softmax - global_max);
float global_sum = BlockReduce(sum_softmax, sum);

// c) Correct thread's best score with global normalization
thread_kvp.value *= expf(max_softmax - global_max) / global_sum;

// d) Find global argmax across all threads
thread_kvp = BlockReduce(thread_kvp, ArgMax);

// e) Thread 0 writes the winning token ID
if (threadIdx.x == 0)
    output[m_idx] = thread_kvp.key;
```

---

## 4. Data Flow Diagram

```
logits [151936] bf16        exponential noise [151936] float
       |                              |
       v                              v
  +----+-----+                   +----+-----+
  | /= temp  |                   | += eps   |
  | softmax  | (online,          |          |
  | exp(x-m) | no materialization)|         |
  +----+-----+                   +----+-----+
       |                              |
       v                              v
  +---------+    prob / noise    +---------+
  |  DIVIDE |<------------------| noise   |
  +---------+                   +---------+
       |
       v score[i]
  +---------+
  | ARGMAX  | (block reduce, 1024 threads)
  +---------+
       |
       v
  token_id (int)
```

---

## 5. Why This Works

### Mathematical Equivalence

The **Gumbel-max theorem** states:

```
argmax_i(log(p_i) + G_i) ~ Categorical(p_1, ..., p_n)
where G_i ~ Gumbel(0, 1)
```

Using outer exponential noise E_i ~ Exp(1):

```
argmax_i(p_i / E_i) ~ Categorical(p_1, ..., p_n)
```

This is what the kernel computes. Benefits:
- **Single pass**: no need to materialize full softmax probabilities
- **No sorting**: just argmax (reducible in O(log n) with block reduce)
- **Numerically stable**: online softmax avoids overflow
- **Fused**: temperature + softmax + sampling in one kernel

---

## 6. Performance

```
For vocab_size=151936, 1024 threads, VecSize=4:

Read: logits  151936 * 2B = 304 KB
      noise   151936 * 4B = 608 KB
      Total:  912 KB

Compute: ~37 iterations * 1024 threads * 4 elems * ~10 FLOP = ~1.5 GFLOP

At 40 us:
  BW = 912 KB / 40 us = 22.8 GB/s
  → Memory-bound (reading exponential noise dominates)
```

---

## 7. Source File Index

| File | Content |
|------|---------|
| `atom/model_ops/sampler.py:51,91` | `Sampler.forward()`, `_temperature_sample()` |
| `aiter/ops/sample.py:40` | Python entry (compile_ops) |
| `aiter/csrc/kernels/sample_kernels.cu:24-156` | **Core impl**: `random_sample_outer_exponential_impl` |
| `aiter/csrc/kernels/sample_kernels.cu:420-448` | **Kernel entry**: `mix_sample_outer_exponential_kernel` |
| `aiter/csrc/kernels/sample_kernels.cu:555-590` | Host launch code |
