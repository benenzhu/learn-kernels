# 02 - RMSNorm (+ Residual Add + Quantization)

## 功能

RMS Layer Normalization，Qwen3 用的是 Pre-Norm 架构（Norm 在 Attention/MLP 之前）。
aiter 将 RMSNorm + 残差加法 + 可选量化 fuse 成单个 kernel。

```
x = RMSNorm(x)                    # pre-attention norm (无残差)
x = RMSNorm(attn_out + residual)   # post-attention norm (有残差加)
x = RMSNorm(moe_out + residual)    # post-MoE norm (有残差加)
x = RMSNorm(x)                    # final norm (最后一层, 无残差)
```

## RMSNorm 公式

```
RMSNorm(x) = x / sqrt(mean(x²) + eps) * weight

其中:
  eps = 1e-6
  weight: [2048] (learnable, bf16)
```

## Kernel 变体 (3 种)

| Kernel | cpu_op | 用途 | 次数/步 |
|--------|--------|------|---------|
| `add_rmsnorm_quant_kernel<..., 64, 8, false, false>` | `aiter::rmsnorm` | Pre-attn norm, 无残差 | 48 |
| `add_rmsnorm_quant_kernel<..., 256, 8, true, false>` | `aiter::add_rmsnorm` | Post-attn/MoE, 有残差加 | 96 (48×2) |
| `add_rmsnorm_quant_kernel<..., 256, 8, false, false>` | `aiter::rmsnorm` | Final norm | 1 |

模板参数含义:
- `64/256`: block size (线程数)
- `8`: vector width
- `true/false`: 是否做残差加法 (add)
- 后续 false: 是否输出量化

## 调用栈

```
Qwen3MoeDecoderLayer.forward()          # qwen3_moe.py:234
  → RMSNorm.forward()                   # 通过 decorators.py:127 wrapped
    → layernorm.py:210  forward()
      → layernorm.py:59   rmsnorm2d_fwd_()        # 无残差版
      → layernorm.py:68   rmsnorm2d_fwd_with_add_() # 有残差版
        → aiter/ops/rmsnorm.py:62  rmsnorm2d_fwd()
          → aiter::rmsnorm (C++ pybind)
        → aiter/ops/rmsnorm.py:76  rmsnorm2d_fwd_with_add()
          → aiter::add_rmsnorm (C++ pybind)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/models/qwen3_moe.py` | 234 | Decoder layer 中调用 |
| `atom/model_ops/layernorm.py` | 59, 68, 210 | RMSNorm forward 和 fwd 分发 |
| `aiter/ops/rmsnorm.py` | 62, 76 | aiter Python 入口 |
| `aiter/csrc/...` | - | C++ HIP kernel 实现 |

## 耗时

| 阶段 | 单次 | 每步总计 (145次) | 占比 |
|------|------|------------------|------|
| Prefill | 3-5 us | ~600 us | 12.2% |
| Decode | 3-4 us | ~500 us | 12.2% |

## 备注

- aiter 的 fused kernel 同时做 `residual_add + rmsnorm`，避免额外的 memory read/write
- 每层有 2 个 RMSNorm: pre-attention 和 post-attention(pre-MoE)
- `elementwise_kernel (aten::copy_)` 紧跟在某些 RMSNorm 后出现，是 reshape 操作
- hidden_size=2048 较小，RMSNorm 是 memory-bound 操作
