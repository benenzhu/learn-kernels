# 02 - RMSNorm (+ Residual Add + Quantization)

## 功能

RMS Layer Normalization，Qwen3 用的是 Pre-Norm 架构（Norm 在 Attention/MLP 之前）。
aiter 将 RMSNorm + 残差加法 + 可选量化 fuse 成单个 kernel。

实际代码逻辑 (`qwen3_moe.py:330-352`):

```python
def forward(self, positions, hidden_states, residual):
    # ---- 第一个 RMSNorm (pre-attention) ----
    if residual is None:                    # 第 0 层: embedding 刚出来, 没有 residual
        residual = hidden_states
        hidden_states = self.input_layernorm(hidden_states)           # 无残差加
    else:                                   # 第 1~47 层: 上一层的 MoE 输出
        hidden_states, residual = self.input_layernorm(hidden_states, residual)  # 有残差加

    # ---- Attention ----
    hidden_states = self.self_attn(hidden_states, ...)

    # ---- 第二个 RMSNorm (post-attention / pre-MoE) ----
    hidden_states, residual = self.post_attention_layernorm(hidden_states, residual)  # 有残差加

    # ---- MoE MLP ----
    hidden_states = self.mlp(hidden_states)
    return hidden_states, residual   # residual 传给下一层
```

对应到 4 种 RMSNorm 调用:

```
第 0 层 input_layernorm:   RMSNorm(x)                    → 无残差加 (residual=None, 首次进入)
第 1~47 层 input_layernorm: RMSNorm(x, residual)          → 有残差加 (fuse 了上一层 MoE 的残差)
所有层 post_attn_layernorm: RMSNorm(attn_out, residual)   → 有残差加 (fuse 了 attention 的残差)
最后 model.norm:            RMSNorm(x, residual)          → 有残差加 (最后一层输出后)
```

### 为什么要 fuse 残差加?

Pre-Norm Transformer 的标准写法是两步：
```python
# 朴素写法 (2 个 kernel, 2 次读写 hidden_states)
hidden_states = hidden_states + residual   # kernel 1: elementwise add
hidden_states = RMSNorm(hidden_states)     # kernel 2: normalize
```

aiter 的 fused 写法合并成 1 个 kernel：
```python
# Fused (1 个 kernel, 1 次读写)
hidden_states, residual = add_rmsnorm(hidden_states, residual)
# 内部: residual_new = hidden + residual
#        output = RMSNorm(residual_new)
# 同时输出 normalized 结果和新的 residual (供下一个子层使用)
```

好处：hidden_states 只需从 HBM 读 1 次（而不是 2 次），对于 memory-bound 的小 hidden_size=2048 尤其重要。

### 残差连接的本质

残差连接 (residual connection) 让梯度能直接流过深层网络，避免梯度消失：
```
每个子层的输出 = 子层计算结果 + 输入 (跳过子层的直连)

即: output = SubLayer(input) + input
```

Qwen3 每层有 **2 条残差路径**:
1. Attention 子层: `residual = hidden + Attention(RMSNorm(hidden))`
2. MoE MLP 子层:  `residual = hidden + MoE(RMSNorm(hidden))`

所有 Pre-Norm 架构的 Transformer (GPT-2 以后基本都是) 都有这种残差加。
Post-Norm 架构 (原始 Transformer, BERT) 也有残差，只是 Norm 的位置不同。

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
