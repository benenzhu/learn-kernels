# 07 - Dense GEMM (QKV / O Projection)

## 功能

Attention 模块中的线性投影，将 hidden_states 映射到 Q/K/V 空间，以及将 attention 输出映射回 hidden 空间。

```
Attention 中有 3 组 Dense GEMM:

1. QKV Projection (合并为一个 GEMM):
   hidden [bs, seq, 2048] × W_qkv [2048, 32*128 + 2*4*128]
   → Q [bs, seq, 4096] + K [bs, seq, 512] + V [bs, seq, 512]
   → 合并 N = 4096 + 512 + 512 = 5120

2. O Projection:
   attn_out [bs, seq, 4096] × W_o [4096, 2048]
   → hidden [bs, seq, 2048]

3. Gate Projection (MoE router, 见 08_moe_gate.md):
   hidden [bs, seq, 2048] × W_gate [2048, 128]
   → router_logits [bs, seq, 128]
```

## Kernel 与 Linear 类型映射

| 用途 | atom Linear 类 | Prefill Tile | Decode Tile |
|------|----------------|-------------|-------------|
| QKV Proj | `QKVParallelLinear` | MT64x32x256 | MT32x16x256 |
| O Proj | `RowParallelLinear` | MT32x32x512 | MT64x16x128 |
| Gate Proj | `ReplicatedLinear` | MT16x16x1024 | (same tile) |

所有 GEMM 都通过 `aiter/tuned_gemm.py` 路由:
- Prefill (大 M): 用 rocBLAS 的大 tile 配置
- Decode (M=1): 用 skinny GEMM 或 `wv_splitk` 小矩阵优化

## 调用栈

### QKV Projection:
```
Qwen3MoeAttention.forward()
  → QKVParallelLinear.forward()       # 通过 decorators.py:127 wrapped
    → linear.py:398  forward()
      → tuned_gemm.py:447  mm()
        → tuned_gemm.py:213  gemm_a16w16()
          → tuned_gemm.py:340  torch_gemm()   # prefill, 大 M
          → tuned_gemm.py:284  skinny_gemm()  # decode, M=1
            → F.linear() / wv_splitk_small_fp16_bf16()
```

### O Projection:
```
Qwen3MoeAttention.forward()
  → RowParallelLinear.forward()
    → linear.py:398  forward()
      → tuned_gemm.py:447  mm()
        → (同上路由)
```

## 源码位置

| 文件 | 行号 | 说明 |
|------|------|------|
| `atom/model_ops/linear.py` | 398 | 所有 Linear 的 forward |
| `aiter/tuned_gemm.py` | 213 | gemm_a16w16() 根据 M 大小选路径 |
| `aiter/tuned_gemm.py` | 284 | skinny_gemm() 小 M 优化 |
| `aiter/tuned_gemm.py` | 340 | torch_gemm() 调用 rocBLAS |
| `aiter/tuned_gemm.py` | 447 | mm() 顶层入口 |

## GEMM Shape 详细

| 投影 | M (prefill/decode) | N | K | 说明 |
|------|-------------------|---|---|------|
| QKV | 91 / 1 | 5120 | 2048 | Q(4096)+K(512)+V(512) |
| O | 91 / 1 | 2048 | 4096 | 32 heads × 128 → hidden |
| Gate | 91 / 1 | 128 | 2048 | router logits |

## rocBLAS Tile 配置 (Cijk naming)

```
Cijk_Alik_Bljk_BBS_BH_Bias_HA_S_SAV_UserArgs_MTAxBxC_...

MT = MacroTile: AxBxC
  A = ThreadTile M 维度
  B = ThreadTile N 维度
  C = ThreadTile K 维度 (unroll)

例: MT64x32x256 = M方向64, N方向32, K方向unroll 256
    MT32x16x256 = skinny M (decode 用)
```

## 耗时

| 投影 | Prefill (us) | Decode (us) |
|------|-------------|-------------|
| QKV Proj | 11-14 | 9-10 |
| O Proj | 13-15 | 12-18 |
| Gate Proj | 7-8 | (同 tile) |
| **每层合计** | ~32 | ~30 |
| **每步合计 (48层)** | ~1500 | ~1440 |

## Decode 的 Skinny GEMM

当 M=1 (decode, bs=1) 时，标准 GEMM 效率很低（利用率极低）。
aiter 的 `skinny_gemm()` 策略:
- 对于 N 较小的 GEMM (如 N=128, N=2048): 用 `wv_splitk_small_fp16_bf16` kernel
- 对于 N 较大的 GEMM (如 N=5120): 仍用 rocBLAS 但选 skinny tile

## 备注

- 所有 Dense GEMM 都是 BF16 × BF16 → BF16 (无量化)
- Qwen3 的 `tie_word_embeddings` 意味着 embedding 和 LM Head 共享权重
- TP>1 时 QKV 用 `ColumnParallelLinear`，O 用 `RowParallelLinear`
- aiter 的 `tuned_gemm` 会根据 shape 查 csv 配置表选最优 kernel/tile
