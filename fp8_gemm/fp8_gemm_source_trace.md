# FP8 Block-Scale GEMM Source Trace

o_proj TP=8: `[batch, 768] × [3072, 768]^T → [batch, 3072]`
Activation quant: per-1×128, Weight quant: per-128×128

## Quantization Path (per-1×128)

- [group_fp8_quant](aiter/ops/quant.py:258)                          # Python 入口
  - [per_group_quant_hip](aiter/ops/quant.py:258)
    - torch.empty(shape, dtype=fp8)                                 # 分配 output tensor
    - torch.empty((*shape[:-1], shape[-1]//128), dtype=fp32)        # 分配 scale tensor [M, K/128]
    - x.view(-1, 128)                                               # reshape 成 [M*K/128, 128] 的 group
    - [dynamic_per_token_scaled_quant](aiter/ops/quant.py:413)      # compile_ops("module_quant")
      - [custom_wrapper](aiter/jit/core.py:968)
        - [wrapper](aiter/jit/core.py:804)
          - HIP Kernel ↓

### HIP Kernel: `dynamic_per_group_scaled_quant_kernel`
- 源码: [quant_kernels.cu:20](aiter_meta/csrc/kernels/quant_kernels.cu:20)
- BlockSize=256, thread_data_size=32
- 每个 thread 读 32 个元素, 每组 128 个元素由 4 个 thread 处理
- 流程:
  1. 每 thread 读 `vec_t<BF16, 32>` 数据
  2. 遍历求局部 absMax
  3. `multithread_reduce(absMax, hipcub::Max(), 4)` → 组内 4 thread reduce 得到 group absMax
  4. `scale = absMax / FP8_MAX` (inverted_scale = absMax * (1/FP8_MAX))
  5. thread 0 写 scale
  6. `vec_convert<FP8, BF16, 32>(data, 1/inverted_scale)` → 量化并写回

## GEMM Path (CK block-scale)

- [gemm_a8w8_blockscale](aiter/ops/gemm_op_a8w8.py:541)             # Python 入口
  - assert dtype in [bf16, fp16]
  - Y = torch.empty(M, N, dtype=bf16)
  - get_gfx() → 判断芯片型号
  - isBpreshuffled?
    - True  → gfx950_a8w8_blockscale_ASM (ASM kernel, 仅 gfx950)
    - False → 走 CK 路径 ↓
  - [get_CKGEMM_config](aiter/jit/core.py:138)                     # 查找 tuned config
    - 读取 a8w8_blockscale_tuned_gemm.csv
    - 匹配 (M, N, K) → {libtype: "ck"/"cktile", ...}
  - config found?
    - libtype=="ck"     → [gemm_a8w8_blockscale_ck](aiter/ops/gemm_op_a8w8.py:146)
    - libtype=="cktile" → [gemm_a8w8_blockscale_cktile](aiter/ops/gemm_op_a8w8.py:160)
    - no config         → fallback to gemm_a8w8_blockscale_ck
  - compile_ops("module_gemm_a8w8_blockscale")
    - [custom_wrapper](aiter/jit/core.py:968)
      - [wrapper](aiter/jit/core.py:804)
        - HIP Kernel ↓

### HIP Kernel: `gemm_a8w8_blockscale` (CK)
- 入口: [gemm_a8w8_blockscale.cu:66](aiter_meta/csrc/ck_gemm_a8w8_blockscale/gemm_a8w8_blockscale.cu:66)
- dispatch: [gemm_a8w8_blockscale.cu:10](aiter_meta/csrc/ck_gemm_a8w8_blockscale/gemm_a8w8_blockscale.cu:10)
  - `blockscale_dispatch<FP32, BF16>(M, N, K)` → 查 lookup table 匹配 kernel
  - 先精确匹配 (M,N,K), 再 padded_M 匹配, 最后 fallback 默认 kernel
- 默认 kernel: `a8w8_blockscale_1x128x128_256x16x128x256_16x16_16x16_1x2_...intrawave_v1`
- kernel 模板: [gemm_a8w8_blockscale_common.cuh:97](aiter_meta/csrc/ck_gemm_a8w8_blockscale/include/gemm_a8w8_blockscale_common.cuh:97)
  - `DeviceGemmMultiD_ABScale_Xdl_CShuffle_V3`
  - Scale block: `Scale_Block_M=1, Scale_Block_N=128, Scale_Block_K=128`
    - A (activation) scale: per-1×128 → 每行每 128 列一个 scale
    - B (weight) scale: per-128×128 → 每 128 行 × 128 列一个 scale
  - A0/B0: FP8, A1/B1 (scale): FP32, Acc: FP32, Output: BF16
  - A layout: RowMajor, B layout: ColMajor (即 weight 是 [N, K] 按行存, GEMM 内部转置)
- impl: [gemm_a8w8_blockscale_common.cuh:123](aiter_meta/csrc/ck_gemm_a8w8_blockscale/include/gemm_a8w8_blockscale_common.cuh:123)
  - `gemm_a8w8_blockscale_impl` → 构造 CK device_gemm, 调用 invoker.Run()

### CK Kernel Tile 参数 (默认 kernel 为例)
```
命名格式: a8w8_blockscale_{ScaleM}x{ScaleN}x{ScaleK}_{BlockSize}x{MPerBlock}x{NPerBlock}x{KPerBlock}_...
默认:      a8w8_blockscale_1x128x128_256x16x128x256_16x16_16x16_1x2_...

BlockSize     = 256 threads
MPerBlock     = 16
NPerBlock     = 128
KPerBlock     = 256
MPerXDL       = 16
NPerXDL       = 16
MXdlPerWave   = 1
NXdlPerWave   = 2
```

## 完整端到端调用链 (单次推理)

```
input_bf16 [M, K=768]
  │
  ▼
per_group_quant_hip                          # aiter/ops/quant.py:258
  ├─ input.view(-1, 128)                     # reshape [M, 768] → [M*6, 128]
  ├─ dynamic_per_group_scaled_quant_kernel   # aiter_meta/csrc/kernels/quant_kernels.cu:20
  │    ├─ absMax per group (4 threads reduce)
  │    ├─ scale = absMax / 448.0
  │    └─ quantize BF16 → FP8
  ├─ output: a_fp8 [M, 768], a_scale [M, 6]
  │
  ▼
gemm_a8w8_blockscale                         # aiter/ops/gemm_op_a8w8.py:541
  ├─ XQ=a_fp8 [M, K=768]    x_scale=a_scale [M, 6]       # per-1×128
  ├─ WQ=w_fp8 [N=3072, K=768]  w_scale [24, 6]            # per-128×128
  ├─ blockscale_dispatch → 选择 CK kernel
  ├─ DeviceGemmMultiD_ABScale_Xdl_CShuffle_V3              # CK GEMM with fused dequant
  │    ├─ tile 内: FP8 matmul → FP32 accumulate
  │    ├─ 每个 tile 乘对应的 a_scale × w_scale
  │    └─ CShuffle → convert FP32 → BF16
  └─ output: Y [M, 3072] in BF16
```
