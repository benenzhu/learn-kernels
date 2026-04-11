# 03 - RoPE (Rotary Position Embedding)

## 功能

对 Q 和 K 向量施加旋转位置编码，使 attention score 天然包含相对位置信息。

```
Q, K: [bs, num_heads, seq_len, head_dim=128]
    → 按 head_dim 维度两两配对，施加 rotation matrix
    → Q_rotated, K_rotated (inplace)
```

## RoPE 公式

```
对 head_dim 中的每对 (x_2i, x_{2i+1}):
  x_2i'   = x_2i   * cos(θ_i * pos) - x_{2i+1} * sin(θ_i * pos)
  x_{2i+1}' = x_{2i+1} * cos(θ_i * pos) + x_2i   * sin(θ_i * pos)

其中:
  θ_i = 1 / (base^(2i/head_dim))
  base = rope_theta (模型配置)
  pos = token 的绝对位置
```

## Kernel

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `kn_entry_2c_sbhd_cached_indirect_inplace` | `aiter::rope_cached_positions_2c_fwd_impl` | Fused RoPE, inplace, 2-channel |

- `2c`: 2-channel 格式 (cos/sin 预计算 cache)
- `sbhd`: 数据布局 seq × batch × head × dim
- `cached`: cos/sin 值预计算并缓存
- `indirect`: 通过 position_ids 间接索引
- `inplace`: 直接修改 Q, K 内存

## 调用栈

```
PagedAttention.forward()                      # paged_attention.py:201
  → unified_attention_with_output_base()      # base_attention.py:232
    → MHAAttention.forward()                  # attention_mha.py:549
      → forward_impl_server_mode()            # attention_mha.py:85
        → rope_cache()                        # attention_mha.py:120
          → RotaryEmbedding.forward()         # aiter/rotary_embedding.py:142
            → forward_hip()                   # aiter/rotary_embedding.py:256
              → rope_cached_positions_2c_fwd_inplace()  # aiter/ops/rope.py:833
                → aiter::rope_cached_positions_2c_fwd_impl (C++)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_ops/attention_mha.py` | 120 | rope_cache() 调用入口 |
| `aiter/rotary_embedding.py` | 142, 256 | RotaryEmbedding forward |
| `aiter/ops/rope.py` | 833 | Python → C++ 桥接 |

## 耗时

| 阶段 | 单次 | 每步 (48层) |
|------|------|------------|
| Prefill | 6-8 us | ~340 us |
| Decode | 6-7 us | ~310 us |

## 备注

- RoPE 在 QKV projection 之后、Attention 之前执行
- 只对 Q 和 K 做旋转，V 不做
- cos/sin 表预计算后 cache，运行时只做查表 + element-wise 乘加
- head_dim=128，每个 head 64 对旋转
- 对于 Qwen3 的 GQA (32 Q heads, 4 KV heads)，Q 旋转 32 个 head，K 只旋转 4 个
