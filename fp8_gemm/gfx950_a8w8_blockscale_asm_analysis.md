# gfx950 FP8 Block-Scale ASM Kernel 反汇编分析

## 文件位置

| 文件 | 路径 |
|------|------|
| Host launcher | `aiter_meta/csrc/py_itfs_cu/asm_mi350_a8w8_blockscale.cu` |
| Header | `aiter_meta/csrc/include/asm_mi350_a8w8_blockscale.h` |
| GPU code object (x32) | `aiter_meta/hsa/gfx950/f8_block_scale_mi350_x32.co` (18K) |
| GPU code object (x64) | `aiter_meta/hsa/gfx950/f8_block_scale_mi350_x64.co` (26K) |
| GPU code object (x96) | `aiter_meta/hsa/gfx950/f8_block_scale_mi350_x96.co` (33K) |
| GPU code object (x128) | `aiter_meta/hsa/gfx950/f8_block_scale_mi350_x128.co` (41K) |

`aiter_meta` 完整路径: `/usr/local/lib/python3.12/dist-packages/aiter_meta`

### 反汇编

```bash
# 反汇编全部 4 个 .co → 清理后的 .s（去掉行尾 hex encoding 注释）
python disasm.py \
  /usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x32.co \
  /usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x64.co \
  /usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x96.co \
  /usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950/f8_block_scale_mi350_x128.co
```

生成的 `.s` 文件：

| 文件 | 行数 |
|------|------|
| `f8_block_scale_mi350_x32.s` | 1784 |
| `f8_block_scale_mi350_x64.s` | 3021 |
| `f8_block_scale_mi350_x96.s` | 4258 |
| `f8_block_scale_mi350_x128.s` | 5495 |

## Python 调用入口

```python
from aiter import gemm_a8w8_blockscale

# 需要 weight 做 B-preshuffle, gfx950, M>=16, K>=512, dtype=bf16
out = gemm_a8w8_blockscale(XQ, WQ, x_scale, w_scale, dtype=torch.bfloat16, isBpreshuffled=True)
```

调用链：`gemm_a8w8_blockscale()` → `gfx950_a8w8_blockscale_ASM()` → `gfx950_a8w8_blockscale_asm()` (JIT compiled C++ binding) → `mi350_a8w8_blockscale_asm()` (host launcher) → `.co` kernel

前置条件：
- `get_gfx() == "gfx950"`
- `m >= 16 and k >= 512`
- `dtype == torch.bfloat16`
- weight 已做 B-preshuffle（layout 变换）

## Host Launcher 参数

```cpp
// KernelArgs 结构体 (packed, 通过 kernarg segment 传递)
ptr_C   // output [M, N] bf16
ptr_X   // XQ [M, K] fp8
ptr_W   // WQ [N, K] fp8 (B-preshuffled)
ptr_XQ  // x_scale [K/128, M] f32
ptr_WQ  // w_scale [K/128, N/128] f32
K, N, M
Xs = K * element_size  // activation row stride
Ws = K * element_size  // weight row stride
Cs = N * 2             // output row stride (bf16)
splitk = 0             // 硬编码为 0
activation = 0
```

Grid 配置：
```
gdx = ceil(N / 256)    // 每个 workgroup 处理 2 个 N-tile (TileN=128, 256 columns)
gdy = ceil(M / TileM)   // TileM = 32 (小M) 或 128 (大M)
gdz = 1                // 无 grid 维度的 split-K
workgroup = 256 threads = 4 × wave64
```

## 指令统计

| 指令类别 | x32 kernel | x128 kernel | 说明 |
|----------|-----------|------------|------|
| `v_mfma_f32_16x16x128_f8f6f4` | 32 | 128 | 矩阵乘核心（CDNA4 专有） |
| `buffer_load` | 63 | 117 | 从 global memory 读 A/B/scale |
| `buffer_store` | 32 | — | 写 output（splitk=0 路径） |
| `global_atomic_add_f32` | 64 | 256 | 写 output（splitk≠0 路径，当前未启用） |
| `ds_write/store` (LDS) | 48 | 192 | 写 LDS |
| `ds_read/load` (LDS) | 116 | 464 | 从 LDS 读到寄存器 |
| `s_barrier` | 19 | 19 | workgroup 同步 |
| `v_mul_f32_dpp` | 24 | 96 | block scale 乘法 |
| `v_cvt_pk_bf16_f32` | 32 | 128 | FP32→BF16 打包转换 |

## 核心 MFMA 指令

```asm
v_mfma_f32_16x16x128_f8f6f4 v[8:11], a[32:39], a[0:7], 0
```

这是 **gfx950 (CDNA4 / MI355X) 专有指令**：
- 单条指令计算 **16×16×128** 的 FP8 矩阵乘
- 输入：2 组 AGPR，每组 8 个 32-bit AGPR = 256 bits = 32 个 FP8 元素
- 输出：4 个 VGPR (v[8:11])，16×16 的 FP32 结果中本 lane 负责的 4 个元素
- K 维度一次消化 128 个元素，对应 block-scale 的 group size

对比 gfx942 (MI300X) 的 `v_mfma_f32_16x16x32_f8f8`：K 维度从 32 提升到 128，**单指令计算密度 4x**

## 数据流 Pipeline

```
                    ┌─────────────────────────────────────────────────┐
                    │              Main K-Loop (双缓冲)                │
                    │                                                 │
  buffer_load ──→ ds_write ──→ s_barrier ──→ ds_read ──→ v_mul_f32_dpp ──→ v_mfma
  (global→VGPR)  (VGPR→LDS)   (同步)      (LDS→AGPR)    (scale乘法)      (矩阵乘)
                    │                                                 │
                    │  ping-pong: 奇偶迭代交替使用 LDS 两半             │
                    └─────────────────────────────────────────────────┘
                                        │
                                        ▼
                              v_cvt_pk_bf16_f32 (FP32→BF16)
                                        │
                                        ▼
                        ┌───────────── s74==0? ─────────────┐
                        │ Yes                           No  │
                  buffer_store                  global_atomic_add_f32
                  (直接写 output)               (原子累加, split-K)
```

### Scale 广播机制

```asm
v_mul_f32_dpp v4, v20, v30 row_newbcast:0 row_mask:0xf bank_mask:0xf
```

- Block scale 从 global memory 加载后存入 VGPR
- 通过 DPP `row_newbcast` 模式广播到 wave 内所有需要该 scale 的 lane
- 然后乘以 MFMA 输入数据
- **零 LDS 开销做 scale broadcast**，全部在寄存器文件内完成

## Split-K 支持

**Kernel 本身支持 split-K，但 host launcher 硬编码 `splitk=0` 未启用。**

判断逻辑在 ISA 中：
```asm
s_load_dword s74, s[0:1], 0x140    // 加载 args.splitk 到 s74
...
s_cmp_eq_u32 s74, 0                // splitk == 0?
s_cbranch_scc0 label_040D          // 如果 != 0，跳到 atomic 路径
```

| 路径 | 条件 | 写 output 方式 | atomic 指令数 |
|------|------|---------------|-------------|
| 正常 | `splitk == 0` | `buffer_store` (直接写) | 0 |
| Split-K | `splitk != 0` | `global_atomic_add_f32` (原子累加) | x32: 64, x128: 256 |

Split-K 用的是 **方案 B (Atomic Accumulate)**：每个 K-split 的 partial result 直接 `global_atomic_add_f32` 累加到 output，无需 partial buffer、counter 或 threadfence。

但 host launcher 写死了：
```cpp
args.splitk = 0;  // 硬编码，未暴露 split-K
```

Python 层的 `gfx950_a8w8_blockscale_asm()` 接口也没有 splitK 参数。

## Kernel 变体选择

```cpp
// host launcher 根据 M 选择不同 kernel
if (m <= 32)
    TileM = 32;   // 用 f8_block_scale_mi350_x32.co
else
    TileM = 128;  // 用 f8_block_scale_mi350_x128.co
```

实际有 4 个变体 (x32/x64/x96/x128)，但 host launcher 只用了 x32 和 x128。

| 变体 | TileM | .co 大小 | MFMA 数 | 适用 |
|------|-------|---------|---------|------|
| x32 | 32 | 18K | 32 | M ≤ 32 |
| x64 | 64? | 26K | — | 未启用 |
| x96 | 96? | 33K | — | 未启用 |
| x128 | 128 | 41K | 128 | M > 32 |

## 与现有 CK kernel 的对比

| | CK `gemm_a8w8_blockscale` | ASM `gfx950_a8w8_blockscale_asm` |
|---|---|---|
| 实现方式 | C++ 模板 (Composable Kernel) | 手写 AMDGPU ISA |
| MFMA 指令 | `v_mfma_f32_16x16x32_f8f8` (gfx942) | `v_mfma_f32_16x16x128_f8f6f4` (gfx950) |
| K per MFMA | 32 | 128 (4x) |
| Scale 处理 | 在模板中处理 | DPP `row_newbcast` 寄存器内广播 |
| Split-K | 通过 tuned config | 内置但未启用 |
| Weight layout | 原始 [N, K] | B-preshuffle 后的特殊 layout |
| 目标硬件 | gfx942 (MI300X) | gfx950 (MI355X) 专用 |
| 调度控制 | CK 框架管理 | 完全手工优化 |

## 关键发现

1. **gfx950 超宽 MFMA**：`v_mfma_f32_16x16x128_f8f6f4` 单指令 K=128，正好等于 block-scale group size，意味着**一条 MFMA 恰好对应一个 scale group**，天然匹配 block-scale 量化

2. **Split-K 隐藏能力**：kernel 已实现 atomic 累加的 split-K 路径，只是 host 没开。对我们的小 shape (N=K=3072) 可能有用——如果能 hack host launcher 传 splitk > 0

3. **B-preshuffle 是前置要求**：weight 需要特殊 layout 变换，aiter 应该有对应工具（待查找 `shuffle_weight` 或 `preshuffle`）

4. **纯寄存器 scale 广播**：DPP `row_newbcast` 避免了 scale 数据走 LDS，减少 LDS bank conflict 和同步开销
