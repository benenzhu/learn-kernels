# TP2 Conc4 FP8 GEMM Optimization for MiniMax-M2.5

## Target Shape

MiniMax-M2.5 `o_proj`: `Linear(6144, 3072)`，TP=2 下：

```
Weight: [N=3072, K=3072] FP8 (per-128×128 block-scale, 预量化)
Input:  [M=4,   K=3072] BF16 (动态 per-1×128 量化)
Output: [M=4,   N=3072] BF16
```

所有维度固定，hardcode 为 constexpr，**只为这一个 shape 服务**。

---

## 现有方案性能 (Baseline)

### CK 端到端 (quant + gemm, N=K=3072)

```
 batch |  CK q+g(us) |  CK gemm(us) |  BF16(us)
     4 |        ~8.5 |         ~7.4 |      ~6.9
```

### Triton tuned (fused quant+gemm, N=K=3072)

| M | Best time (us) | KSPLIT | BLOCK_M×N | cache_mod |
|---|---------------|--------|-----------|-----------|
| 4 | 10.16 | 4 | 4×16 | .cg |

**目标：击败 CK 的 ~8.5 us（端到端）。**

---

## Kernel 设计

### 总体架构

单个 fused kernel 完成：**BF16 量化 → FP8 GEMM → split-K reduce → BF16 输出**

```
Grid: (num_N_tiles × KSPLIT,)
  num_N_tiles = N / BLOCK_N = 3072 / 16 = 192
  KSPLIT = 8
  Total CTAs = 192 × 8 = 1536

PID remapping:
  pid → (tile_n, split_k)
  同一 tile_n 的 8 个 split 用连续 PID → 同一 XCD
```

### 固定参数 (全部 constexpr)

```
M             = 4         (pad to 16 for MFMA)
N             = 3072
K             = 3072
BLOCK_N       = 16
BLOCK_K       = 128
KSPLIT        = 8
K_PER_SPLIT   = 384       (3072 / 8)
NUM_K_TILES   = 3         (384 / 128)
NUM_N_TILES   = 192       (3072 / 16)
```

### MFMA 指令选择

使用 CDNA4 的 `v_mfma_f32_16x16x128_f8f6f4`：

| 属性 | 值 |
|------|---|
| Output tile | 16 × 16 |
| K per instruction | 128 |
| FLOPs per instruction | ~65K |
| 输入 | FP8 × FP8 → FP32 accumulate |

- M=4 pad 到 16（补 0），MFMA 输出取前 4 行
- 每个 K tile (block_k=128) 只需 **1 条 MFMA**
- 3 个 K tile = **3 条 MFMA / CTA**

---

## 每个 CTA 的执行流程

### Phase 1: Compute (fused quant + GEMM)

```
// 所有循环全展开，地址全是编译期常量
// Pipeline depth=2: 同时最多 2 个 tile load in-flight

Prologue:
  issue load(A0_bf16[4,128], B0_fp8[128,16])     // tile 0
  issue load(A1_bf16[4,128], B1_fp8[128,16])     // tile 1 prefetch

Tile 0:
  s_waitcnt vmcnt(...)                            // wait tile 0
  quant A0: BF16→FP8                              // VALU, ~80 cycles
    ├─ local absMax per 32 elements
    ├─ DPP reduce (0xb1 + 0x4e), 4 threads/group
    ├─ scale = absMax / FP8_MAX
    └─ quantize: mul + cvt_f32_to_fp8
  issue load(A2_bf16, B2_fp8)                     // tile 2 prefetch
  acc = MFMA_16x16x128(A0_fp8, B0_fp8)           // 1 instruction, Matrix pipeline
                                                   // MFMA 执行期间 tile 2 load 在飞

Tile 1:
  s_waitcnt vmcnt(...)                            // wait tile 1
  quant A1                                        // VALU, 和上一条 MFMA 尾巴重叠
  acc += MFMA_16x16x128(A1_fp8, B1_fp8)

Tile 2:
  s_waitcnt vmcnt(0)                              // wait tile 2
  quant A2
  acc += MFMA_16x16x128(A2_fp8, B2_fp8)
```

### Phase 2: Split-K Reduce

两种方案对比实现：

#### 方案 A: Atomic Counter + Last-CTA Reduce

```
// acc: [16, 16] FP32 (只有前 4 行有效)

// 1. 写 partial result
partial_buf[split_id][0:4, 0:BLOCK_N] = acc[0:4, :]  // global store

// 2. Memory fence + atomic sync
__threadfence()                          // flush L1, 等 L2 确认 (~几百 cycles)
old = atomicAdd(&counter[tile_n], 1)     // L2 local (同 XCD)

// 3. Last CTA reduces
if old == KSPLIT - 1:
    result = 0
    for s in range(KSPLIT):              // 全展开, 8 次
        result += partial_buf[s][0:4, 0:BLOCK_N]   // L2 hit (同 XCD)
    result *= a_scale * w_scale          // apply block scale
    output[0:4, tile_n*16 : (tile_n+1)*16] = cvt_f32_to_bf16(result)
```

#### 方案 B: 直接 Atomic Add

```
// acc: [16, 16] FP32

acc *= a_scale * w_scale                 // apply scale
acc_bf16 = cvt_f32_to_bf16(acc[0:4, :])

// 直接 atomic 累加到 output
for i in range(4):
    for j in range(BLOCK_N):             // 全展开
        atomicAdd(&output[i, tile_n*16+j], acc_bf16[i][j])
```

---

## 数据量分析

### Per-CTA 寄存器需求

```
Per tile (in-flight 最多 2 个):
  A tile: [4, 128] BF16 = 1024 B → load 后就地 quant, 不需同时存 2 份原始数据
  B tile: [128, 16] FP8 = 2048 B

同时 in-flight:
  A (正在 quant): 1024 B
  A (prefetch):   1024 B
  B (当前):       2048 B
  B (prefetch):   2048 B
  ≈ 6 KB → ~96 VGPRs (每 VGPR 64 bytes = 4B × 64 lanes)

Accumulator: [16, 16] FP32 = 1024 B → 16 VGPRs (每 lane 持有部分)
Scale + misc: ~10 VGPRs

Total: ~120 VGPRs → 占用率不高，但我们不在乎，寄存器随便用
```

### LDS 需求

M=4 全部走 VGPR，**不需要 LDS**。
B 矩阵（weight）如果同 block 内多个 wave 共享可考虑 LDS broadcast，但单 wave 下不必要。

---

## 关键优化点

### 1. Fuse Quant — 省掉 global memory round-trip

```
不 fuse:  BF16 → [global write FP8] → [global read FP8] → MFMA
fuse:     BF16 → [register FP8] → MFMA

省掉 activation 的一次 global write + read:
  [4, 3072] FP8 = 12 KB write + 12 KB read = 24 KB memory traffic
  在 ~2 TB/s HBM 带宽下 ≈ 0.01 us，看似不多
  但关键是省掉了一次 kernel launch (~3-5 us without graph)
  以及 graph 下的额外 node
```

### 2. XCD 局部性 — PID Remapping

MI300X/MI355X 有 8 个 XCD，每个有独立 L2 cache (~32 MB)。

```
PID remapping (连续 KSPLIT 个 PID 映射到同一 tile):
  PID 0..7   → tile_n=0 的 8 个 K-split → 大概率同一 XCD
  PID 8..15  → tile_n=1 的 8 个 K-split → 大概率同一 XCD
  ...
  PID 1528..1535 → tile_n=191 的 8 个 K-split

效果:
  - partial_buf 在同一 L2 partition → reduce 时 cache hit
  - atomic counter 在同一 L2 → 低延迟
  - 避免 cross-XCD coherence traffic
```

每个 XCD ~38 CUs。1536 CTAs / 8 XCDs = 192 CTAs/XCD，每个 XCD 处理 24 个 tile_n（每个 tile 8 个 split）。

### 3. 全展开 + constexpr — 消除一切运行时开销

```
所有 constexpr:
  - 循环 trip count → 全展开，0 branch overhead
  - 地址偏移 → 编译期常量，省 VALU
  - 无 bounds check → 不会越界
  - tile 大小 → 编译器可以做最优 register allocation
```

### 4. Load/MFMA Interleave — 隐藏 memory latency

```
不 interleave:
  load A0,B0 → wait → quant → MFMA → load A1,B1 → wait → ...
  总时间 = 3 × (load_latency + quant + MFMA)

interleave (pipeline depth=2):
  load A0,B0
  load A1,B1
  wait A0,B0 → quant A0 → load A2,B2 → MFMA(A0,B0)  ← load 和 MFMA 重叠
  wait A1,B1 → quant A1 → MFMA(A1,B1)
  wait A2,B2 → quant A2 → MFMA(A2,B2)
  总时间 ≈ load_latency + 3 × max(quant, MFMA)   ← 首次 load 不可避免
```

### 5. Quant 用 DPP — 最快的 cross-lane reduce

```
per_1x128 量化, 4 threads 合作:
  local absMax (32 elements)         ~32 VALU cycles
  DPP 0xb1: stride=1 交换           ~4 cycles + 2 wait
  DPP 0x4e: stride=2 交换           ~4 cycles
  scale = absMax * (1/FP8_MAX)       ~4 cycles
  quantize (mul + cvt) × 32          ~32 cycles
  Total: ~80 cycles per group

vs LDS reduce: ~50 cycles 仅 reduce 部分, 还要额外的 LDS write/read
DPP 快 3-4x 且不占用 LDS
```

---

## Roofline 分析 & 时序估算

### 数据量

```
Weight B:  [3072, 3072] × 1B (FP8)  = 9 MB     ← 绝对大头，无 reuse
A input:   [4, 3072]    × 2B (BF16) = 24 KB     ← L2 缓存，被 192 个 N-tile 复用
A scale:   [4, 24]      × 4B (FP32) = 384 B
B scale:   [24, 24]     × 4B (FP32) = 2.3 KB
Output:    [4, 3072]    × 2B (BF16) = 24 KB

Total HBM read  ≈ 9 MB   (B 每个元素跨所有 CTA 只读一次)
Total HBM write ≈ 24 KB  (最终输出)
```

### Roofline

```
Compute:   2 × 4 × 3072 × 3072 = 75.5 MFLOP
Memory:    ~9 MB

Arithmetic Intensity = 75.5 MFLOP / 9 MB = 8.4 FLOP/byte
                       ← 非常低，完全 memory bound!

MI355X:
  HBM peak:  8 TB/s
  有效带宽:  ~5 TB/s (考虑其他指令消耗)
  FP8 peak:  ~2.6 PFLOPS

Memory time:  9 MB / 5 TB/s  = 1.8 us    ← 理论下界!
Compute time: 75.5M / 2.6P   = 0.03 us   ← 可忽略

结论: 瓶颈 100% 在 HBM 带宽, 不在计算
      理论最优 ≈ 1.8 us (仅 weight 读取)
```

### 对比 Baseline

```
CK 端到端 (M=4, N=K=3072): ~8.5 us
理论下界:                    ~1.8 us
CK 达到的有效带宽:           9 MB / 8.5 us ≈ 1.06 TB/s (仅 peak 的 13%)

差距来源:
  - CK quant 是独立 kernel (~1 us)
  - CK gemm kernel 本身 ~7.4 us
  - M=4 太小，CTA 数量不够多，HBM 带宽利用率低
  - CK 的 tile config 不是为这个 shape 优化的
```

### Per-CTA 视角

```
Per CTA (KSPLIT=8, BLOCK_N=16):
  B tile load: [384, 16] FP8 = 6 KB       ← 每个 CTA 的 weight 部分
  A tile load: [4, 384]  BF16 = 3 KB      ← 但 L2 hit (被同 K-split 的 192 个 CTA 共享)
  Per CTA unique HBM read ≈ 6 KB (B)

  Total CTAs: 192 × 8 = 1536
  Total B across CTAs: 1536 × 6 KB = 9 MB ✓ (无重复，每个 CTA 读不同的 B 块)
```

### Per-CTA Pipeline 时序

```
Quant (VALU pipeline):  ~80 cycles per tile
MFMA (Matrix pipeline): ~32-64 cycles per instruction (16x16x128)
VALU 和 Matrix 是不同 pipeline，可以重叠!

单 CTA load 6+3 = 9 KB, HBM latency ~200-400 cycles

Timeline (per CTA, 粗估):
  Cycle 0:     issue load(A0, B0), load(A1, B1)
  Cycle ~300:  A0,B0 ready (HBM latency)
  Cycle 300:   quant A0 (VALU, ~80 cycles)
  Cycle 380:   issue load(A2, B2), MFMA(A0, B0) (~64 cycles)
  Cycle 380:   quant A1 (VALU, overlaps MFMA)     ← VALU + Matrix 并行
  Cycle 444:   MFMA(A0) done
  Cycle 460:   quant A1 done, MFMA(A1, B1)
  Cycle 460:   quant A2 (overlaps MFMA)
  Cycle 524:   MFMA(A1) done
  Cycle 540:   MFMA(A2, B2)
  Cycle 604:   MFMA(A2) done → acc ready
  Cycle 650:   epilogue (scale + store)
  Cycle 700+:  atomic + possible reduce

  单 CTA 执行时间 ≈ 700 cycles ≈ 0.35 us @ 2 GHz

但这不是瓶颈! 瓶颈是 1536 个 CTA 争抢 HBM 带宽:
  1536 × 9 KB / 5 TB/s = 2.8 us
  减去 A 的 L2 复用 (仅 24 KB 从 HBM):
  (9 MB + 24 KB) / 5 TB/s ≈ 1.8 us
```

### 理论耗时总结

```
                              时间 (us)
HBM weight read (9 MB @ 5TB/s):  1.8     ← 不可避免的下界
Compute (3 MFMA per CTA):        0.03    ← 可忽略
Quant overhead:                   fused, hidden by memory
Split-K reduce + atomic:          0.1-0.3 ← 取决于方案
Kernel launch (graph):            ~0.5    ← CUDA graph 最低开销

理论总耗时: ~2.3-2.6 us
目标:       < 4 us (2x better than CK's 8.5 us)
```

**核心认知：这是一个纯 bandwidth-bound 问题。优化目标不是减少计算，而是最大化 HBM 带宽利用率。**
关键是让 1536 个 CTA 产生足够的并发 memory 请求来饱和 5 TB/s 带宽。

---

## 方案 A vs B 对比

| | 方案 A: Atomic Counter | 方案 B: Atomic Add |
|---|---|---|
| 正确性 | 精确 | FP32 atomic 有微小精度差异 |
| 额外 memory | partial_buf [8, 4, 16] per tile = 2KB | 无 |
| 同步开销 | threadfence (~200+ cycles) + 1 atomic | 4×16=64 atomics (但无 fence) |
| 7/8 CTA 浪费 | 算完就退出 | 算完就退出 |
| Reduce 开销 | 1 CTA 读 8 份, ~8 global loads | 无 (硬件 atomic 做 reduce) |
| M×N contention | 无 | 4×16=64 地址, 8 splits 竞争 |
| 实现复杂度 | 中等 | 简单 |

**两种都实现，benchmark 决定胜负。**

---

## 实现计划

1. **Phase 1: HIP C++ Kernel**
   - 所有维度 constexpr，手动展开 3 次 K 循环
   - Fused quant (DPP reduce) + MFMA_16x16x128
   - 先不做 split-K，单 CTA 跑完整 K=3072（24 条 MFMA，验证正确性）

2. **Phase 2: Split-K**
   - 加入 KSPLIT=8，PID remapping
   - 实现方案 A (atomic counter) 和方案 B (atomic add)
   - Benchmark 对比

3. **Phase 3: 极致优化**
   - `s_setprio` / `sched_barrier` 控制指令调度
   - 验证 XCD 局部性（rocprof 看 CTA 分布）
   - 尝试 KSPLIT=4 vs 8 对比
   - 如果 B 矩阵有 reuse 机会，考虑 LDS broadcast

4. **Phase 4: 集成**
   - 对接到推理框架
   - 端到端 latency 对比 CK baseline

---

## 参考

- [Matrix Core Programming on CDNA3/CDNA4](https://rocm.blogs.amd.com/software-tools-optimization/matrix-cores-cdna/README.html)
- [FP8 GEMM Optimization on CDNA4](https://rocm.blogs.amd.com/software-tools-optimization/cdna4-gemm-kernels/README.html)
- [AMD CDNA4 ISA Reference Guide](https://www.amd.com/content/dam/amd/en/documents/instinct-tech-docs/instruction-set-architectures/amd-instinct-cdna4-instruction-set-architecture.pdf)
- [AMD GCN Assembly Cross-Lane Operations](https://gpuopen.com/learn/amd-gcn-assembly-cross-lane-operations/)
- [AMDGPU Kernel Optimization Guide](https://github.com/nod-ai/amd-shark-ai/blob/main/docs/amdgpu_kernel_optimization_guide.md)
