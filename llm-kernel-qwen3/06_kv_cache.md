# 06 - KV Cache (FP8 量化存储)

## 功能

将当前 step 计算出的 K, V 向量量化为 FP8 并写入 paged KV cache。

```
K: [bs, 4, seq_len, 128] bf16
V: [bs, 4, seq_len, 128] bf16
    → per-token FP8 量化
    → 写入 paged KV cache blocks
```

## Kernel

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `reshape_and_cache_with_per_token_quant_kernel<BF16, FP8, true, 64>` | `aiter::reshape_and_cache_with_pertoken_quant` | BF16→FP8 量化 + 写入 cache |

模板参数:
- `BF16`: 输入类型
- `FP8` (DB8_f): 输出类型 (FP8 E4M3)
- `true`: 启用 per-token 量化
- `64`: block_size (每个 cache block 存 64 个 token 的 KV)

## 调用栈

```
PagedAttention.forward()                      # paged_attention.py:201
  → unified_attention_with_output_base()      # base_attention.py:232
    → MHAAttention.forward()                  # attention_mha.py:549
      → forward_impl_server_mode()            # attention_mha.py:85
        → rope_cache()                        # attention_mha.py:120
          → aiter::reshape_and_cache_with_pertoken_quant (C++)
```

注意: RoPE 和 KV Cache Store 在同一个 `rope_cache()` 函数中连续调用:
1. 先做 RoPE (旋转 Q, K)
2. 紧接着将 K, V 写入 cache

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_ops/attention_mha.py` | 120 | rope_cache() 中调用 |
| `aiter/ops/cache.py` | - | Python 入口 |

## Per-Token FP8 量化

```
对于每个 token 的 K (或 V) 向量 [128]:
  1. 计算该 token 的 absmax = max(|K|)
  2. scale = absmax / FP8_MAX (FP8 E4M3 max = 448)
  3. K_fp8 = round(K / scale)  → clamp to FP8 range
  4. 存储: K_fp8 [128] (1 byte each) + scale (1 float)

显存节省:
  BF16: 128 × 2B = 256 bytes/token/head
  FP8:  128 × 1B + 4B = 132 bytes/token/head
  节省 ~48%
```

## 耗时

| 阶段 | 单次 | 每步 (48层) |
|------|------|------------|
| Prefill | ~4 us | ~192 us |
| Decode | ~4-5 us | ~210 us |

## KV Cache 整体架构

```
┌──────────────────────────────────────────────┐
│ Physical Memory Pool (Paged)                  │
│                                               │
│ Block 0: [64 tokens × 4 KV heads × 128 dim] │
│ Block 1: [64 tokens × 4 KV heads × 128 dim] │
│ ...                                           │
│ Block N: [64 tokens × 4 KV heads × 128 dim] │
└──────────────────────────────────────────────┘
         ↑
    block_table[req_id] = [block_0, block_5, block_12, ...]
    (每个请求有自己的 block 映射表)
```

## 备注

- `kv_indices_generate_kernel` 在每个 decode step 开始时运行，生成 block_table 索引
- FP8 KV cache 是推理优化的关键技术，显著减少 decode 阶段的显存和带宽
- block_size=64 意味着每个物理 block 存储 64 个 token 的 KV
- per-token 量化比 per-tensor 精度更高，每个 token 独立 scale
