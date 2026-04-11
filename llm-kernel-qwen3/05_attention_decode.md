# 05 - Attention Decode (Paged Attention + Reduce)

## 功能

Decode 阶段每次只生成 1 个 token，需要从 KV cache 中读取所有历史 K, V。
使用 Paged Attention: KV cache 按页 (block) 管理，支持不连续显存。

```
Q: [1, 32, 1, 128]        (当前 token 的 query)
K_cache: paged blocks      (FP8 量化存储)
V_cache: paged blocks      (FP8 量化存储)
    → PagedAttention(Q, K_cache, V_cache)
    → output: [1, 32, 1, 128]
```

## Kernel (2 个)

### 1. Paged Attention 主计算

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `pa_bf16_pertokenFp8_gqa8_2tg_4w` | `aiter::_pa_fwd_asm` | ASM Paged Attention |

模板参数含义:
- `bf16`: query 数据类型
- `pertokenFp8`: KV cache 是 per-token FP8 量化
- `gqa8`: GQA group size = 8
- `2tg`: 2 tile groups
- `4w`: 4 warps per tile group

### 2. SplitK Reduce

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `wv_splitk_small_fp16_bf16_kernel` | `aiter::wv_splitk_small_fp16_bf16` | SplitK 结果合并 |

PA 将 KV cache 分块并行计算 (splitK)，每块独立算 partial attention，
最后用 reduce kernel 合并所有 partial 结果 (使用 log-sum-exp 校正)。

## 调用栈

### PA 主 kernel:
```
PagedAttention.forward()                      # paged_attention.py:201
  → unified_attention_with_output_base()      # base_attention.py:232
    → MHAAttention.forward()                  # attention_mha.py:549
      → forward_impl_server_mode()            # attention_mha.py:85
        → paged_attention_asm()               # attention_mha.py:400
          → pa_fwd_asm()                      # aiter/ops/attention.py:129
            → aiter::_pa_fwd_asm (ASM binary)
```

### wv_splitk reduce:
```
注意: 这个 kernel 出现在 RowParallelLinear 的调用栈中!
这是因为 PA reduce 和 O projection 被 fuse/overlap 了。

RowParallelLinear.forward()                   # linear.py:398
  → tuned_gemm.mm()                          # aiter/tuned_gemm.py:447
    → gemm_a16w16()                          # aiter/tuned_gemm.py:213
      → skinny_gemm()                        # aiter/tuned_gemm.py:284
        → wv_splitk_small_fp16_bf16 (C++)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_ops/attention_mha.py` | 400 | paged_attention_asm() |
| `aiter/ops/attention.py` | 129 | pa_fwd_asm() Python 入口 |
| `aiter/hsa/gfx950/pa/*.co` | - | ASM binary (pa_bf16_pertokenFp8_gqa8_2tg_4w) |
| `aiter/tuned_gemm.py` | 284 | skinny_gemm() 调用 wv_splitk |

## Paged Attention 算法要点

```
1. KV cache 按固定大小 block 分配 (如 128 tokens/block)
2. 每个请求有 block_table 记录哪些物理 block 属于它
3. PA kernel 遍历所有 blocks:
   - 对每个 block 计算 QK^T → attention score
   - 用 online softmax 更新 partial sum
4. SplitK: 多个 threadblock 并行处理不同 block 范围
5. Reduce: 合并 partial results, 用 log-sum-exp trick 保证数值稳定

FP8 KV cache:
  - K, V 以 per-token FP8 存储 (每个 token 一个 scale)
  - PA kernel 读取 FP8 → 解量化到 BF16 → 计算 attention
  - 显存减半: 128-bit KV → 64-bit FP8 KV
```

## 耗时

| | 单次 | 每步 (48层) |
|--|------|------------|
| PA 主 kernel | 7-12 us | ~430 us |
| wv_splitk reduce | 3-4 us | ~180 us |
| **合计** | 10-16 us | ~610 us |

## 备注

- PA 只在 **decode** 阶段使用; prefill 用 Flash Attention
- FP8 KV cache 显著减少显存和带宽需求
- `gqa8` 表示 8 个 Q heads 共享 1 对 KV heads
- 序列越长 → 需要读更多 KV cache blocks → PA 耗时线性增长
- ASM kernel 针对 MI355X (gfx950) 硬件优化，手写汇编
