# 10 - LM Head (Final Norm + Logits Projection)

## 功能

将最后一层 decoder 的 hidden_states 转换为 vocab 维度的 logits。

```
hidden [1, 1, 2048]
    → Final RMSNorm
    → LM Head GEMM: [1, 2048] × [2048, 151936]
    → logits [1, 151936]
```

## Kernel 序列 (4 个)

| # | Kernel | cpu_op | 说明 |
|---|--------|--------|------|
| 1 | `add_rmsnorm_quant_kernel<..., 256, 8, false>` | `aiter::rmsnorm` | Final RMSNorm (无残差加) |
| 2 | `elementwise_kernel (aten::sub)` | `aten::sub` | 偏移调整 |
| 3 | `elementwise_kernel (aten::copy_)` | `aten::copy_` | 数据类型/布局转换 |
| 4 | `Cijk_..._MT32x16x256` | `aten::mm` | LM Head GEMM (巨大 N) |

## 调用栈

```
Qwen3MoeForCausalLM.forward()                # qwen3_moe.py:490
  → compute_logits()                         # qwen3_moe.py:507
    → ParallelLMHead.forward()               # embed_head.py:168
      → aten::sub (bias 偏移)
      → aten::copy_ (数据准备)
      → tuned_gemm.mm()                     # aiter/tuned_gemm.py:447
        → gemm_a16w16()
          → torch_gemm() / skinny_gemm()
            → rocBLAS GEMM
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/models/qwen3_moe.py` | 507 | compute_logits() |
| `atom/model_ops/embed_head.py` | 168 | ParallelLMHead.forward() |
| `aiter/tuned_gemm.py` | 447 | mm() 路由 |

## GEMM Shape

| 参数 | 值 |
|------|-----|
| M | 1 (decode) 或 seq_len (prefill, 但只取最后 token) |
| N | 151936 (vocab_size) |
| K | 2048 (hidden_size) |
| 数据类型 | BF16 × BF16 → BF16 |

## 耗时

| | 耗时 | 说明 |
|--|------|------|
| Final RMSNorm | ~3-4 us | |
| Elementwise ×2 | ~8 us | sub + copy |
| **LM Head GEMM** | **~105 us** | **单个最耗时的 Dense GEMM!** |
| 合计 | ~116 us | |

## 为什么 LM Head 这么慢?

```
即使 M=1, N=151936 是一个巨大的数:
  计算量: 2 × 1 × 151936 × 2048 = 623 MFLOP
  读权重: 151936 × 2048 × 2B = 594 MB

  105 us → 带宽 = 594MB / 105us = 5.66 TB/s
  MI355X 峰值带宽 ~8 TB/s → 利用率 ~71%

  极度 memory-bound: 每读 594MB 权重只做 623M 次乘加
  arithmetic intensity = 623M / 594M = 1.05 FLOP/byte
```

## Weight Tying

```
Qwen3 使用 weight tying:
  LM Head 的权重 = Embedding Table 的权重 (转置)

  Embedding: token_id → hidden  (查表, 取行)
  LM Head:   hidden → logits   (矩阵乘, 全部列)

  共享同一个 [151936, 2048] 的权重矩阵
  节省 ~594 MB 显存
```

## 备注

- LM Head 虽然每步只执行 1 次 (不像 decoder layer 执行 48 次)，但单次耗时 105 us，约占每步总时间的 3%
- 可以通过 vocab parallelism (TP) 来切分这个大 GEMM
- `aten::sub` 是 ParallelLMHead 中的 logits 偏移调整
- Prefill 时通常只需要最后一个 token 的 logits (不需要全部)
