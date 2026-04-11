# 01 - Embedding Lookup

## 功能

将 token_id (int) 查表转换为 hidden_states 向量。

```
token_ids [bs, seq_len] (int)
    → Embedding Table [151936, 2048] (bf16)
    → hidden_states [bs, seq_len, 2048] (bf16)
```

## Kernel

| 阶段 | Kernel | 耗时 |
|------|--------|------|
| level 0 (纯 eager) | `indexSelectSmallIndex<BFloat16>` | ~5 us |
| level 3 (torch.compile) | `triton_poi_fused_embedding_0` | ~5 us |

- `--level 0` 时用 PyTorch native 的 `aten::index_select`
- `--level 3` (默认) 时 torch.compile 将 `F.embedding` 编译为 Triton kernel

## 调用栈

```
model_runner.py:1535  run_model()
  → model_runner.py:1691  forward()
    → Qwen3MoeForCausalLM.forward()          # qwen3_moe.py:490
      → Qwen3MoeModel.forward()              # qwen3_moe.py:401
        → get_input_embeddings()              # qwen3_moe.py:398
          → VocabParallelEmbedding.forward()  # embed_head.py:131
            → F.embedding()                   # torch/nn/functional.py
              → aten::index_select / aten::gather
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/models/qwen3_moe.py` | 398 | `get_input_embeddings()` 调用 |
| `atom/model_ops/embed_head.py` | 131 | `VocabParallelEmbedding.forward()` |
| PyTorch `nn/functional.py` | 2428 | `F.embedding()` 实现 |

## Shape

| 参数 | 值 |
|------|-----|
| vocab_size | 151936 |
| hidden_size | 2048 |
| weight dtype | bf16 |
| weight size | 151936 × 2048 × 2B = ~594 MB |

## 备注

- Embedding 权重与 LM Head 权重**共享** (weight tying)，Qwen3 用 `tie_word_embeddings`
- 单纯的查表操作，计算量极小，耗时可忽略
- 在 TP>1 时用 `VocabParallelEmbedding`，按 vocab 维度切分到不同 GPU
