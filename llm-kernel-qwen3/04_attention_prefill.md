# 04 - Attention Prefill (Flash Attention)

## 功能

Prefill 阶段一次处理整个输入序列的 attention 计算。使用 Flash Attention v3 (变长版本)。

```
Q: [1, 32, seq_len, 128]   (32 query heads)
K: [1, 4,  seq_len, 128]   (4 KV heads, GQA group=8)
V: [1, 4,  seq_len, 128]
    → FlashAttention(Q, K, V, causal=True)
    → output: [1, 32, seq_len, 128]
```

## Kernel

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `fmha_fwd_hd128_bf16_causal_group` | `aiter::fmha_v3_varlen_fwd` | Flash Attention v3, ASM kernel |

- `hd128`: head_dim = 128
- `bf16`: 数据类型
- `causal`: 因果 mask (下三角)
- `group`: GQA group attention (8 Q heads 共享 1 KV head)
- 这是一个**手写 ASM kernel** (`.co` binary)，从 `/app/aiter-test/hsa/gfx950/fmha_v3_fwd/` 加载

## 调用栈

```
PagedAttention.forward()                      # paged_attention.py:201
  → unified_attention_with_output_base()      # base_attention.py:232
    → MHAAttention.forward()                  # attention_mha.py:549
      → forward_impl_server_mode()            # attention_mha.py:85
        → prefill_attention()                 # attention_mha.py:453
          → flash_attn_varlen_func()          # aiter/ops/mha.py:2543
            → FlashAttnVarlenFunc.forward()   # aiter/ops/mha.py:2342
              → _flash_attn_varlen_forward()  # aiter/ops/mha.py:1980
                → aiter::fmha_v3_varlen_fwd (ASM)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_ops/attention_mha.py` | 453 | prefill_attention() 分发 |
| `aiter/ops/mha.py` | 1980, 2342, 2543 | Flash Attention Python API |
| `aiter/hsa/gfx950/fmha_v3_fwd/*.co` | - | 预编译 ASM binary |

## Flash Attention 算法要点

```
1. 分块 tiling: 将 Q, K, V 按 block 切块
2. Online softmax: 边算 attention score 边更新 softmax 归一化
3. 不需要 O(N²) 显存存储完整 attention matrix
4. Memory-efficient: 只需 O(N) 额外显存
5. causal mask: 只计算下三角部分
```

## 耗时

| seq_len | 单次 | 说明 |
|---------|------|------|
| 91 | ~10-11 us | 短序列，kernel launch overhead 占主导 |
| 2048 | ~更长 | 计算量 O(N²d)，随 seq_len 二次增长 |

## Prefill vs Decode

| | Prefill | Decode |
|---|---------|--------|
| 算法 | Flash Attention (fmha) | Paged Attention (PA) |
| Q shape | [bs, heads, **seq_len**, hd] | [bs, heads, **1**, hd] |
| 复杂度 | O(N²d) | O(Nd) |
| 实现 | 分块 tiling + online softmax | 逐 block 遍历 KV cache |

## 备注

- Qwen3-30B-A3B 用 GQA: 32 Q heads, 4 KV heads → group_size = 8
- 变长版本 (`varlen`) 支持不同请求不同长度，通过 `cu_seqlens` 描述
- ASM kernel 针对 gfx950 (MI355X) 硬件优化
