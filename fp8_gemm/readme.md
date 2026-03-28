# FP8 Block-Scale GEMM Benchmark

## Background

MiniMax-M2.5 attention `o_proj` (RowParallelLinear) 在 TP=8 下的 GEMM shape:
- Weight: `[N=3072, K=768]` (FP8, per-128x128 block-scale)
- Input:  `[M, K=768]` (BF16, 动态 per-1x128 量化为 FP8)
- Output: `[M, N=3072]` (BF16)

### RowParallelLinear TP Shape (o_proj)

o_proj 原始 shape: `Linear(6144, 3072)`，沿 input 维度切分，output 不变。

| TP | Weight [N, K] | Input [M, K] |
|----|--------------|--------------|
| 1  | [3072, 6144] | [M, 6144]    |
| 2  | [3072, 3072] | [M, 3072]    |
| 4  | [3072, 1536] | [M, 1536]    |
| 8  | [3072, 768]  | [M, 768]     |

### 量化方案 (DeepSeek style)

| 对象 | 粒度 | Scale shape | 原因 |
|------|------|-------------|------|
| Activation | per-1x128 | [M, K/128] | token 间分布差异大，需逐 token scale |
| Weight | per-128x128 | [N/128, K/128] | 权重分布稳定，粗粒度省开销 |

128 对齐 GPU Tensor Core tile，dequant 可融合进 GEMM 累加，零额外开销。

## Files

| File | Description |
|------|-------------|
| `test_fp8_gemm.py` | Benchmark: CK quant+gemm / CK gemm-only / fused triton / BF16, CUDA graph replay |
| `fp8_gemm_source_trace.md` | 完整源码调用链 (quant + CK GEMM + fused triton) |
| `tune_triton_gemm_a8w8_blockscale.py` | Triton fused kernel 的 tuning 脚本 |
| `tune.sh` | 多 GPU 并行 tuning 启动脚本 |

## Benchmark Results

CUDA graph replay x100, `triton.testing.do_bench` median, batch_size 4~256.

```
o_proj TP=8: weight [3072, 768], CUDA graph replay x100
 batch |  CK q+g(us) |  CK gemm(us) |  fused(us) |  BF16(us) | fused/CK
------------------------------------------------------------------------
     4 |         8.5 |          7.4 |       30.2 |       6.9 |    0.28x
     8 |         8.5 |          7.4 |       30.3 |       7.1 |    0.28x
    16 |         8.8 |          7.6 |       30.4 |       7.1 |    0.29x
    32 |         9.2 |          7.8 |       30.9 |       9.2 |    0.30x
    64 |         9.3 |          8.1 |       31.7 |       9.4 |    0.29x
   128 |         9.5 |          8.1 |       34.0 |      10.3 |    0.28x
   256 |        11.0 |          9.8 |       34.1 |       9.8 |    0.32x
```

- **CK q+g**: aiter HIP quant kernel + CK `gemm_a8w8_blockscale` (端到端)
- **CK gemm**: CK `gemm_a8w8_blockscale` only (activation 已预量化)
- **fused**: triton `gemm_a16w8_blockscale` with `PREQUANT=True` (BF16 输入，kernel 内 fused quant+gemm)
- **BF16**: `torch.mm` baseline

## Conclusions

1. **CK quant 开销很小**: graph 下 quant 只占 ~1.1 us (8.5 - 7.4)，之前 do_bench 看到的 ~4 us 大部分是 CPU kernel launch overhead
2. **CK gemm 对小 batch 没有明显加速**: 小 M (4~16) 时 CK FP8 gemm (~7.4 us) 反而比 BF16 mm (~7.0 us) 略慢，因为 FP8 dequant 逻辑有额外开销，且矩阵太小无法充分利用 FP8 的计算密度优势
3. **Fused triton kernel 目前很慢 (~30 us)**: 比 CK 端到端慢 ~3.5x，原因：
   - 没有 tuned config（shape 3072x768 未出现在 tuned CSV 中）
   - Triton 生成的 FP8 dot 指令效率低于 CK 手写 XDL kernel
   - 但 fused 路径省掉了 activation 的 global memory round-trip，tune 后有潜力
4. **这个 shape (3072x768) 偏小**: K=768 意味着只有 768/128=6 个 scale group，计算量不大，各 kernel 都处于 launch-bound 区域

---

## Triton Kernel Tuning Results (N=K=3072)

在 gfx950 (CDNA4, MI355X) 上对 `gemm_a8w8_blockscale` triton kernel 做了 3457 种 config 的搜索。

### Best Configs

| M | Best time (us) | TFLOPS | BLOCK_M | BLOCK_N | KSPLIT | stages | cache_mod |
|---|---------------|--------|---------|---------|--------|--------|-----------|
| 4 | 10.16 | 7.4 | 4 | 16 | 4 | 2 | .cg |
| 8 | 10.24 | 14.8 | 16 | 16 | 4 | 2 | .cg |
| 16 | 10.56 | 28.6 | 16 | 16 | 4 | 2 | .cg |
| 32 | 10.92 | 55.3 | 32 | 16 | 4 | 2 | .cg |
| 64 | 13.04 | 92.6 | 16 | 64 | 4 | 1 | .cg |

### Tuning 发现

1. **KSPLIT=4 全面胜出**: K=3072 / 4 = 768 per split，每个 split 6 次 K 迭代（block_k=128），工作量合理
2. **cache_modifier=`.cg`（cache global）全面胜出**: 绕过 L1 直读 L2，减少 L1 thrashing
3. **小 tile 占优**: BLOCK_N=16 对小 M 最优，因为 N=3072/16=192 个 tile 可以铺满更多 CU
4. **stages=2 略优于 1**: 双缓冲 prefetch 对 K 循环有帮助

---

## 学到的关键知识

### 1. 量化 Kernel 实现细节

**Kernel**: `dynamic_per_group_scaled_quant_kernel` (`quant_kernels.cu:20`)

per_1x128 量化路径：
- 每个 group (128 个元素) 由 **4 个 thread** 合作处理（每 thread 持有 32 个元素）
- 使用 **DPP (Data Parallel Primitives)** 指令做 cross-lane reduce

```
流程：
  vec_t<BF16, 32> data = vectorized_load(input + offset)  // 向量化读 32 个元素
  float absMax = local_max(data)                           // 本地求 max
  absMax = multithread_reduce(absMax, Max(), 4)            // 4-thread DPP reduce
  scale = absMax / FP8_MAX
  quantized = data / scale → 写出 FP8
```

### 2. DPP 指令机制

DPP 是 AMD CDNA 的 **wave 内 lane 间寄存器直接交换**机制，不走 LDS。

**`wave_reduce` 的 6 级蝶形归约**（64 lane → 1 个值）：

| 阶段 | DPP 操作 | 编码 | stride |
|------|---------|------|--------|
| 1 | quad_perm:[1,0,3,2] | 0xb1 | 1 |
| 2 | quad_perm:[2,3,0,1] | 0x4e | 2 |
| 3 | row_ror:4 | 0x124 | 4 |
| 4 | row_ror:8 | 0x128 | 8 |
| 5 | row_bcast:15 | 0x142 | 16 |
| 6 | row_bcast:31 | 0x143 | 32 |

对于 per_1x128 量化（只需 4 thread reduce），只用前 2 级（0xb1 + 0x4e），两条指令搞定。

**延迟对比**（MI300 实测）：

| 操作 | 硬件单元 | 延迟 |
|------|---------|------|
| DPP | VALU | 4-12 cycles |
| v_permlane | VALU | 4-8 cycles |
| ds_permute | LDS | ~50 cycles |

### 3. DPP Hazard

DPP 读的是**其他 lane 的 VGPR**。如果前一条 VALU 刚写了这个 VGPR，需要等它把 64 个 lane 全写完（4 cycles on SIMD16）。

- **VALU 写 → DPP 读同一 VGPR**: 需要 **2 wait states**（编译器自动插 `s_nop 1`）
- **VALU 改 EXEC → DPP**: 需要 **5 wait states**

2 级 DPP reduce 总开销 ≈ 4 + 2 + 4 = **~10 cycles**。

### 4. v_permlane vs DPP

| | DPP | v_permlane |
|---|---|---|
| 模式 | 固定模式（quad_perm, row_ror 等） | SGPR 控制的任意 XOR permute |
| 范围 | wave 内 | wave 内（16/32/64 lane 分组） |
| 硬件 | VALU modifier | VALU 指令 |
| 延迟 | 4-12 cycles | 4-8 cycles |
| 适用 | reduce / scan | 任意 shuffle |

gfx950 新增 `v_permlane16_swap_b32` / `v_permlane32_swap_b32` 双向交换变体。

---

## 下一步：自定义 Split-K Fused Kernel

### 目标

写一个 Triton kernel，fuse quant + GEMM + split-K reduce，单个 kernel 完成全部工作。

### 方案 A：Atomic Counter + Last-CTA Reduce

```
每个 CTA:
  1. 从 BF16 input 做 on-the-fly 量化
  2. FP8 matmul，累加 partial result (FP32)
  3. 写 partial result 到 global memory buffer
  4. __threadfence()
  5. old = atomicAdd(&counter[tile_id], 1)
  6. if old == NUM_SPLITS - 1:    # 我是最后一个
       读所有 partial results，reduce-sum，写最终 BF16 输出
```

**优点**：
- 单 kernel，无 launch overhead
- fuse quant 省掉 activation 的 global memory round-trip
- last-CTA reduce 不需要第二个 kernel

**注意**：
- `__threadfence()` 代价不可忽略（几百 cycles），flush L1 + 等 L2 确认
- PID remapping 让同一 tile 的所有 split CTA 落在同一个 XCD → atomic 和 partial result 都命中本地 L2

### 方案 B：直接 Atomic Accumulate

```
每个 CTA:
  1. 从 BF16 input 做 on-the-fly 量化
  2. FP8 matmul，得到 partial result (FP32)
  3. atomicAdd(&output[m][n], partial_value)   # 直接累加到输出
```

**优点**：
- 不需要 partial buffer、counter、threadfence
- 实现最简

**缺点**：
- FP32 atomic add 非结合律，有微小精度差异
- M×N 大时 contention 高

### 方案对比

| | 方案 A (counter) | 方案 B (atomic add) |
|---|---|---|
| 正确性 | 精确 | FP32 精度微差 |
| 额外 memory | partial buffer [splits, M, N] | 无 |
| 同步开销 | threadfence + 1 atomic per tile | N_per_tile atomics per CTA |
| 复杂度 | 中等 | 简单 |
| 适合 | split 多、M 大 | split 少、M 小 |

### MI300X/MI355X XCD 局部性

MI300X 有 8 个 XCD，每个有独立 L2 cache。关键优化：

```
Grid Layout (PID remapping):
  PID 0..3  → tile (0,0) 的 4 个 K-split → 同一个 XCD
  PID 4..7  → tile (0,1) 的 4 个 K-split → 同一个 XCD
  ...
```

连续 workgroup ID 在 AMD 硬件上大概率分发到同一个 XCD（每个 XCD ~38 CUs）。
这样同一 tile 的 partial result 和 atomic counter 都在同一个 L2 partition 内，避免 cross-XCD coherence 开销。

### Split 数量选择

从 tuning 结果来看 **KSPLIT=4** 优于 8：

| KSPLIT | K per split (K=3072) | 迭代数 (block_k=128) | 评估 |
|--------|---------------------|---------------------|------|
| 2 | 1536 | 12 | 并行度不够 |
| 4 | 768 | 6 | **最佳平衡** ✓ |
| 8 | 384 | 3 | 太少，overhead 占比高 |

### 实现计划

1. 先实现方案 A 和方案 B 的 Triton kernel（N=K=3072, M=4~64）
2. Benchmark 对比两种方案 vs CK 端到端
3. 验证 PID remapping 是否真的让 CTA 落在同一 XCD（用 rocprof 看 XCD 分布）
4. 尝试不同 KSPLIT (2, 4, 8) 对比

## Usage

```bash
# Benchmark
python bench_kernels/fp8_gemm/test_fp8_gemm.py

# Tuning (多 GPU 并行)
cd bench_kernels/fp8_gemm && bash tune.sh
```
