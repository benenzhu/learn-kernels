# 02 - RMSNorm (+ Residual Add + Quantization)

## 功能

RMS Layer Normalization，Qwen3 用的是 Pre-Norm 架构（Norm 在 Attention/MLP 之前）。
aiter 将 RMSNorm + 残差加法 + 可选量化 fuse 成单个 kernel。

## Data Flow Diagrams

### Residual Stream: Single Decoder Layer

```
              hidden                  residual
          (from prev layer)       (from prev layer)
                |                        |
                v                        v
        +---------------+               |
        |  add_rmsnorm  |<--------------+
        |  (fused)      |---> new residual = hidden + residual
        +-------+-------+                          |
                |                                   |
                v  normalized                       |
        +---------------+                          |
        |   Attention   |                          |
        +-------+-------+                          |
                |                                   |
                v  attn_out                         v
        +---------------+                          |
        |  add_rmsnorm  |<-------------------------+
        |  (fused)      |---> new residual = attn_out + prev_residual
        +-------+-------+                          |
                |                                   |
                v  normalized                       |
        +---------------+                          |
        |   MoE MLP     |                          |
        +-------+-------+                          |
                |                                   |
                v                                   v
              hidden  ----------------------> residual
          (to next layer)                 (to next layer)
```

### Residual Accumulation Across Layers

The residual is NOT always adding back to the embedding.
It **accumulates** every sub-layer's contribution:

```
Embedding output = emb
        |
        v
 +--- Layer 0 ---------------------------------------------------+
 |  residual = emb                        (initialized)           |
 |  hidden   = RMSNorm(emb)              (no add, first layer)   |
 |  hidden   = Attn_0(hidden)                                    |
 |  residual = emb + Attn_0_out          (1st accumulation)      |
 |  hidden   = RMSNorm(residual)                                 |
 |  hidden   = MoE_0(hidden)                                     |
 +----------------------------------------------------------------+
        |                        |
        v hidden                 v residual = emb + Attn_0
 +--- Layer 1 ---------------------------------------------------+
 |  residual = MoE_0_out + (emb + Attn_0)                        |
 |           = emb + Attn_0 + MoE_0      (2nd accumulation)      |
 |  hidden   = RMSNorm(residual)                                 |
 |  hidden   = Attn_1(hidden)                                    |
 |  residual = emb + Attn_0 + MoE_0 + Attn_1                    |
 |  hidden   = RMSNorm(residual)                                 |
 |  hidden   = MoE_1(hidden)                                     |
 +----------------------------------------------------------------+
        |                        |
        v                        v residual = emb + Attn_0 + MoE_0 + Attn_1
       ...                      ...
        |                        |
        v                        v
 +--- Layer 47 --------------------------------------------------+
 |  residual = emb + sum(Attn_i + MoE_i, i=0..46) + Attn_47     |
 |  ...                                                           |
 +----------------------------------------------------------------+
        |                        |
        v                        v
  Final add_rmsnorm:
    residual = emb + sum(Attn_i + MoE_i, i=0..47)
    output   = RMSNorm(residual)
        |
        v
    LM Head --> logits
```

**Key insight**: the residual is a "highway" that accumulates
ALL sub-layer outputs. After 48 layers:

```
residual = emb + Attn_0 + MoE_0 + Attn_1 + MoE_1 + ... + Attn_47 + MoE_47
                 \_______________/   \_______________/       \_____________/
                    Layer 0              Layer 1                Layer 47
```

### Why Fuse: Naive vs Fused Kernel

```
Naive (2 kernels):                  Fused (1 kernel):

  HBM --read--> residual             HBM --read--> residual
  HBM --read--> hidden               HBM --read--> hidden
                  |                                   |
           +------+------+              +-------------+-------------+
           |     ADD     | kernel 1     | add + rmsnorm (1 kernel) |
           +------+------+              +------+-----------+-------+
                  |                            |           |
           +------+------+               write to HBM  write to HBM
           |   RMSNorm  | kernel 2      (normalized)   (new residual)
           +------+------+
                  |
  HBM read+write x4                  HBM read+write x2  (halved!)
```

## Code (`qwen3_moe.py:330-352`)

```python
def forward(self, positions, hidden_states, residual):
    # pre-attention RMSNorm
    if residual is None:              # Layer 0: no residual yet
        residual = hidden_states
        hidden_states = self.input_layernorm(hidden_states)           # no add
    else:                             # Layer 1~47: fused add + norm
        hidden_states, residual = self.input_layernorm(hidden_states, residual)

    hidden_states = self.self_attn(hidden_states, ...)

    # post-attention RMSNorm (always fused add + norm)
    hidden_states, residual = self.post_attention_layernorm(hidden_states, residual)

    hidden_states = self.mlp(hidden_states)
    return hidden_states, residual    # both passed to next layer
```

Four RMSNorm call sites:

```
Layer 0 input_layernorm:    RMSNorm(x)            no add   (residual=None)
Layer 1-47 input_layernorm: add_rmsnorm(x, res)   fused    (prev MoE residual)
All post_attn_layernorm:    add_rmsnorm(x, res)   fused    (attention residual)
Final model.norm:           add_rmsnorm(x, res)   fused    (last layer output)
```

### Why fuse residual add?

Naive: 2 kernels, 2 full HBM round-trips for hidden_states
```python
hidden_states = hidden_states + residual   # kernel 1: elementwise add
hidden_states = RMSNorm(hidden_states)     # kernel 2: normalize
```

Fused: 1 kernel, 1 round-trip (halved bandwidth)
```python
hidden_states, residual = add_rmsnorm(hidden_states, residual)
# internally: residual_new = hidden + residual
#             output = RMSNorm(residual_new)
# outputs both normalized result AND new residual for next sub-layer
```

Especially important for small hidden_size=2048 where ops are memory-bound.

### Residual connection fundamentals

Every sub-layer: `output = SubLayer(input) + input`

Qwen3 has 2 residual paths per layer:
1. Attention: `residual += Attention(RMSNorm(residual))`
2. MoE MLP:  `residual += MoE(RMSNorm(residual))`

All Pre-Norm Transformers (GPT-2 onward) use this pattern.
Post-Norm (original Transformer, BERT) also has residuals, but Norm placement differs.

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
