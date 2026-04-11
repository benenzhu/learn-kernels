# 08 - MoE Gate (TopK Routing + Token Sorting)

## 功能

MoE 的路由机制: 对每个 token 选出 top-8 个 expert，计算归一化权重，然后将 token 排序分配到各 expert。

```
hidden [bs, seq, 2048]
    → Gate GEMM: [2048] × [2048, 128] → router_logits [128]
    → TopK Softmax: 选 top-8, softmax 归一化
    → Token Sorting: 按 expert 重排 token 顺序
    → sorted_token_ids, sorted_expert_ids, sorted_weights
```

## Kernel

### 1. Gate Projection (Dense GEMM)
见 `07_dense_gemm.md` — 通过 `ReplicatedLinear` 做 [2048→128] 的投影。

### 2. TopK Gating Softmax

| Kernel | cpu_op | 说明 |
|--------|--------|------|
| `topkGatingSoftmax<bf16, 16, 128, 8, 32, true, 0, SharedExpertScaleMode::No>` | `aiter::topk_softmax` | Top-8 选择 + Softmax |

模板参数:
- `bf16`: 输入类型
- `16`: WARP_SIZE/2 (half warp)
- `128`: num_experts
- `8`: num_experts_per_tok (topk)
- `32`: WARP_SIZE
- `true`: renormalize weights
- `SharedExpertScaleMode::No`: 无 shared expert

### 3. Token Sorting

| Kernel | cpu_op | 阶段 | 说明 |
|--------|--------|------|------|
| `MoeSortingKernel` | `aiter::moe_sorting_fwd` | decode | 单阶段排序 (token 数少) |
| `MoeSortingMultiPhaseKernel_P0_v2` | `aiter::moe_sorting_fwd` | prefill | 多阶段 phase 0 |
| `MoeSortingMultiPhaseKernel_P23` | `aiter::moe_sorting_fwd` | prefill | 多阶段 phase 2+3 |

- Decode (M=1): token 少，单 phase 即可
- Prefill (M=91): token 多，需要多 phase 排序

## 调用栈

### TopK Softmax:
```
FusedMoE.forward()                           # moe.py:2540
  → moe_forward()                           # moe.py:1829
    → forward_impl()                        # moe.py:2600
      → apply()                             # moe.py:453
        → select_experts()                  # moe.py:2471
          → rocm_aiter_topk_softmax()       # topK.py:363
            → rocm_aiter_topk_softmax_impl() # topK.py:90
              → aiter::topk_softmax (C++)
```

### Token Sorting:
```
FusedMoE.forward()
  → moe_forward() → forward_impl() → apply()
    → fused_moe()                           # aiter/fused_moe.py:119
      → fused_moe_()                        # aiter/fused_moe.py:206
        → moe_sorting()                     # aiter/fused_moe.py:71
          → _moe_sorting_impl()             # aiter/fused_moe.py:28
            → aiter::moe_sorting_fwd (C++)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_ops/moe.py` | 2471 | select_experts() |
| `atom/model_ops/topK.py` | 90, 363 | topk_softmax 调用 |
| `aiter/fused_moe.py` | 28, 71, 119, 206 | fused_moe + sorting |

## TopK Routing 算法

```
1. router_logits = hidden @ W_gate     # [bs*seq, 128]
2. top8_values, top8_indices = topk(router_logits, k=8)
3. weights = softmax(top8_values)       # 归一化到 sum=1
4. sorted_token_ids = sort tokens by expert assignment
   → 让同一 expert 的 token 连续排列, 方便 batched GEMM
```

## Token Sorting 输出

```
输入: topk_ids [num_tokens, 8], topk_weights [num_tokens, 8]
输出:
  sorted_token_ids:  [num_tokens * 8] — 哪些 token 分配到哪
  sorted_expert_ids: [num_tokens * 8] — 对应的 expert id
  sorted_weights:    [num_tokens * 8] — 对应的 softmax 权重
  num_valid_ids:     [128] — 每个 expert 被分配了多少 token
```

## 耗时

| 组件 | 单次 | 每步 (48层) |
|------|------|------------|
| TopK Softmax | 7-9 us | ~380 us |
| Token Sort (decode, single) | 6-7 us | ~310 us |
| Token Sort (prefill, multi) | 6+4 us | ~480 us |

## 备注

- Qwen3-30B-A3B: 128 experts, topk=8 → 每个 token 激活 8/128 = 6.25% 的 expert
- 没有 shared expert (SharedExpertScaleMode::No)
- Token sorting 是 MoE 的关键瓶颈之一 — 排序后的数据布局决定了 Expert GEMM 的效率
- 多阶段排序 (P0 + P23): P0 做 local sort, P23 做 global merge
