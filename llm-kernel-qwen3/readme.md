# Qwen3-30B-A3B MoE 推理 Kernel 全景图

> 模型: Qwen/Qwen3-30B-A3B | GPU: MI355X (gfx950) | 框架: ATOM (eager mode) | dtype: BF16 + FP8 KV Cache

## 模型架构参数

| 参数 | 值 |
|------|-----|
| hidden_size | 2048 |
| num_hidden_layers | 48 |
| num_attention_heads | 32 (GQA, 4 KV heads → group=8) |
| head_dim | 128 |
| intermediate_size | 6144 (per expert gate_up) |
| vocab_size | 151936 |
| num_experts | 128 |
| num_experts_per_tok (topk) | 8 |
| rms_norm_eps | 1e-6 |
| max_position_embeddings | 40960 |

## 完整推理流水线 (端到端)

```
tokens ──► Embedding ──► [Decoder Layer × 48] ──► Final RMSNorm ──► LM Head ──► Sampling ──► token_id
```

---

## 阶段 1: Token → Embedding

```
token_ids [bs, seq_len]
    │
    ▼
┌─────────────────────────────┐
│  Embedding Lookup (triton)  │  weight: [151936, 2048] bf16
│  triton_poi_fused_embedding_0│  查表, 无计算
└─────────────────────────────┘
    │
    ▼
hidden_states [bs, seq_len, 2048] bf16
```

**kernel**: `triton_poi_fused_embedding_0` (~5 us)
**本质**: token_id → 查 embedding table → 取出 2048 维向量, 每个 token 一行

---

## 阶段 2: Decoder Layer × 48 (重复, 每层结构完全一致)

每层包含两个子模块: **Attention** + **MoE MLP**, 通过 RMSNorm + 残差连接。

### Prefill (一次处理 seq_len 个 token) — 每层 15 个 kernel

```
hidden_states
    │
    ▼
┌──────────────────────────────────────────────────────────────────┐
│ 1. RMSNorm (pre-attention)                                       │
│    aiter::add_rmsnorm_quant_kernel<..., 64, 8, false, false>     │
│    输入 normalization, 不加残差 (第一个 norm)                      │
│    ~3-4 us                                                        │
├──────────────────────────────────────────────────────────────────┤
│                     ATTENTION 子模块                              │
├──────────────────────────────────────────────────────────────────┤
│ 2. QKV Projection — 看不到独立 GEMM (被 fused 进其他 op)          │
│    这里 trace 显示 Layer 0 有一个额外的 GEMM+Elementwise           │
│    但常规 layer 是内部处理的                                       │
│                                                                   │
│ 3. RoPE (Rotary Position Embedding)                              │
│    aiter::kn_entry_2c_sbhd_cached_indirect_inplace               │
│    对 Q, K 施加旋转位置编码, fused + inplace                       │
│    ~6-8 us                                                        │
│                                                                   │
│ 4. KV Cache Store (FP8 量化写入)                                  │
│    aiter::reshape_and_cache_with_per_token_quant_kernel           │
│    K, V → per-token FP8 量化 → 写入 paged KV cache                │
│    ~4 us                                                          │
│                                                                   │
│ 5. Flash Attention (Prefill)                                      │
│    aiter::fmha_fwd_hd128_bf16_causal_group                       │
│    变长 flash attention, causal mask, GQA group=8                  │
│    head_dim=128, bf16                                             │
│    ~10-11 us                                                      │
│                                                                   │
│ 6. O Projection (Attention output → hidden)                       │
│    Cijk_..._MT64x32x256 (rocBLAS GEMM)                           │
│    [bs*seq, 32*128=4096] × [4096, 2048] → [bs*seq, 2048]         │
│    ~13-15 us                                                      │
├──────────────────────────────────────────────────────────────────┤
│ 7. RMSNorm + Residual Add (post-attention / pre-MoE)             │
│    aiter::add_rmsnorm_quant_kernel<..., 256, 8, true>            │
│    hidden = RMSNorm(attn_out + residual), fused 一个 kernel       │
│    ~4-5 us                                                        │
├──────────────────────────────────────────────────────────────────┤
│                     MoE MLP 子模块                                │
├──────────────────────────────────────────────────────────────────┤
│ 8. Gate Projection + TopK Router                                  │
│    Cijk_..._MT16x16x1024 (rocBLAS GEMM)                          │
│    [bs*seq, 2048] × [2048, 128] → [bs*seq, 128] (router logits)  │
│    ~7-8 us                                                        │
│                                                                   │
│ 9. TopK Gating Softmax                                            │
│    vllm::moe::topkGatingSoftmax<bf16, 16, 128, 8>                │
│    128 experts 中选 top-8, softmax 归一化权重                      │
│    ~8-9 us                                                        │
│                                                                   │
│ 10. Token Sorting (分发 token 到 expert)                          │
│    ck_tile::MoeSortingMultiPhaseKernel_P0_v2  (phase 0)          │
│    ck_tile::MoeSortingMultiPhaseKernel_P23    (phase 2+3)        │
│    prefill 时 token 数多, 用多阶段排序                             │
│    ~6+4 = 10 us                                                   │
│                                                                   │
│ 11. Expert GEMM Stage 1 (gate_up projection)                     │
│    ck::kernel_moe_gemm (CK 2-stage fused MoE)                    │
│    per-expert: [tokens_i, 2048] × [2048, 6144*2]                 │
│    包含 SiLU activation + gate*up fusion                          │
│    ~60-90 us (最大 kernel!)                                       │
│                                                                   │
│ 12. Expert GEMM Stage 2 (down projection)                        │
│    ck::kernel_moe_gemm (CK 2-stage fused MoE)                    │
│    per-expert: [tokens_i, 6144] × [6144, 2048]                   │
│    包含 topk 权重加权求和                                          │
│    ~30-48 us                                                      │
├──────────────────────────────────────────────────────────────────┤
│ 13. RMSNorm + Residual Add (post-MoE)                            │
│    aiter::add_rmsnorm_quant_kernel<..., 256, 8, true>            │
│    hidden = RMSNorm(moe_out + residual)                           │
│    ~4-5 us                                                        │
├──────────────────────────────────────────────────────────────────┤
│ 14. 下一层的 QKV Projection                                      │
│    Cijk_..._MT64x32x256 (rocBLAS GEMM)                           │
│    [bs*seq, 2048] → [bs*seq, Q_dim + 2*KV_dim]                   │
│    实际是下一层 attn 的输入 projection                             │
│    ~11-14 us                                                      │
│                                                                   │
│ 15. Elementwise (reshape/split QKV)                               │
│    at::native::elementwise_kernel                                 │
│    ~4-5 us                                                        │
└──────────────────────────────────────────────────────────────────┘
```

### Decode (逐 token 生成, bs=1) — 每层 13 个 kernel

```
hidden_states [1, 1, 2048]
    │
    ▼
┌──────────────────────────────────────────────────────────────────┐
│ 1. RMSNorm (pre-attention)                                       │
│    aiter::add_rmsnorm_quant_kernel<..., 64, 8, false>            │
│    ~3 us                                                          │
├──────────────────────────────────────────────────────────────────┤
│ 2. RoPE                                                          │
│    aiter::kn_entry_2c_sbhd_cached_indirect_inplace               │
│    ~6-7 us                                                        │
│                                                                   │
│ 3. KV Cache Store (FP8)                                          │
│    aiter::reshape_and_cache_with_per_token_quant_kernel           │
│    ~4-5 us                                                        │
│                                                                   │
│ 4. Paged Attention Decode ← 替代 Flash Attention                  │
│    aiter::pa_bf16_pertokenFp8_gqa8_2tg_4w                        │
│    从 FP8 KV cache 中读取所有历史 KV, 计算 attention               │
│    GQA group=8, 2 tile groups, 4 warps                            │
│    ~7-12 us                                                       │
│                                                                   │
│ 5. O Projection                                                   │
│    Cijk_..._MT64x16x128 (rocBLAS, skinny M)                      │
│    decode 时 M=1, 用 skinny GEMM tile                             │
│    ~12-18 us                                                      │
├──────────────────────────────────────────────────────────────────┤
│ 6. RMSNorm + Residual Add                                        │
│    ~3-4 us                                                        │
│                                                                   │
│ 7. Paged Attention Reduce ← decode 独有                           │
│    aiter::wv_splitk_small_fp16_bf16_kernel                        │
│    PA splitK 的 reduce 阶段, 合并分块结果                          │
│    ~3-4 us                                                        │
├──────────────────────────────────────────────────────────────────┤
│ 8. MoE Gate (TopK Softmax)                                       │
│    ~7-8 us                                                        │
│                                                                   │
│ 9. Token Sorting ← 单阶段 (decode 只有 1 个 token)                │
│    ck_tile::MoeSortingKernel (single phase)                       │
│    ~6-7 us                                                        │
│                                                                   │
│ 10. Expert GEMM Stage 1 (gate_up)                                │
│    ~23-24 us (比 prefill 小, M=1)                                 │
│                                                                   │
│ 11. Expert GEMM Stage 2 (down)                                   │
│    ~8 us                                                          │
├──────────────────────────────────────────────────────────────────┤
│ 12. RMSNorm + Residual Add                                       │
│    ~3-4 us                                                        │
│                                                                   │
│ 13. 下一层 QKV Projection                                        │
│    Cijk_..._MT32x16x256 (rocBLAS, skinny M)                      │
│    ~9-10 us                                                       │
└──────────────────────────────────────────────────────────────────┘
```

---

## 阶段 3: Final RMSNorm + LM Head → Logits

```
last_hidden_states [1, 1, 2048]     ← 最后一层 decoder 输出
    │
    ▼
┌──────────────────────────────────┐
│ RMSNorm (final, 无残差加)         │
│ aiter::add_rmsnorm_quant_kernel  │
│ <..., 256, 8, false, false>      │
│ ~3-4 us                          │
└──────────────────────────────────┘
    │
    ▼
┌──────────────────────────────────┐
│ LM Head (GEMM)                   │
│ Cijk_... (rocBLAS)               │
│ [1, 2048] × [2048, 151936]       │
│ → logits [1, 151936]             │
│ prefill: ~105 us (大矩阵!)       │
│ decode:  ~105 us                  │
└──────────────────────────────────┘
    │
    ▼
logits [1, 151936] bf16
```

**注意**: LM Head 的 GEMM 很大 — N=151936 (vocab size), 即使 M=1 也要 105 us, 是单个最耗时的 dense GEMM。

---

## 阶段 4: Sampling → 输出 token_id

```
logits [1, 151936]
    │
    ▼
┌──────────────────────────────────────┐
│ Sampling (Top-P / Top-K / Temp)      │
│ aiter::mix_sample_outer_exponential  │
│ softmax + multinomial sampling       │
│ ~40 us                               │
└──────────────────────────────────────┘
    │
    ▼
token_id (int)
    │
    ▼
┌──────────────────────────────────────┐
│ KV Indices Generate                  │
│ kv_indices_generate_kernel           │
│ 为下一步 decode 准备 KV cache 索引    │
│ ~4 us                                │
└──────────────────────────────────────┘
```

---

## Prefill vs Decode 关键差异

| 维度 | Prefill | Decode |
|------|---------|--------|
| **输入形状** | [1, 91, 2048] 多 token | [1, 1, 2048] 单 token |
| **Attention** | Flash Attention (fmha) | Paged Attention (PA) + wv_splitk reduce |
| **GEMM tile** | 大 tile (MT64x32x256) | skinny tile (MT32x16x256, MT64x16x128) |
| **MoE Sorting** | 多阶段 (P0 + P23) | 单阶段 (token 少) |
| **MoE GEMM** | 60-90 us (大 M) | 23-24 us (M=1) |
| **每层 kernel 数** | 15 | 13 |
| **瓶颈** | 计算密集 (MoE GEMM) | 访存密集 (PA 读 KV cache) |

---

## 全部 Kernel 汇总 (按功能分类)

### 1. Embedding (1 种)
| Kernel | 来源 | 说明 |
|--------|------|------|
| `triton_poi_fused_embedding_0` | Triton (torch.compile) | token_id → embedding 查表 |

### 2. RMSNorm (3 种变体)
| Kernel | 来源 | 说明 |
|--------|------|------|
| `add_rmsnorm_quant_kernel<..., 64, 8, false, false, true>` | aiter | Pre-attention norm, 不加残差 |
| `add_rmsnorm_quant_kernel<..., 256, 8, true, false, true>` | aiter | Post-attn/post-MoE norm, fused 残差加 |
| `add_rmsnorm_quant_kernel<..., 256, 8, false, false, true>` | aiter | Final norm (最后一层, 无残差) |

### 3. Attention (6 种)
| Kernel | 来源 | 阶段 | 说明 |
|--------|------|------|------|
| `kn_entry_2c_sbhd_cached_indirect_inplace` | aiter | 两者 | RoPE 旋转位置编码 |
| `reshape_and_cache_with_per_token_quant_kernel` | aiter | 两者 | KV → FP8 量化写入 cache |
| `fmha_fwd_hd128_bf16_causal_group` | aiter (ASM) | prefill | Flash Attention v3, causal, GQA |
| `pa_bf16_pertokenFp8_gqa8_2tg_4w` | aiter (ASM) | decode | Paged Attention, FP8 KV, GQA=8 |
| `wv_splitk_small_fp16_bf16_kernel` | aiter | decode | PA splitK reduce |
| `kv_indices_generate_kernel` | atom | decode | KV cache 页表索引生成 |

### 4. Dense GEMM (5 种 tile)
| Kernel | 来源 | 阶段 | 用途 |
|--------|------|------|------|
| `Cijk_..._MT64x32x256` | rocBLAS | prefill | QKV proj, O proj (large M) |
| `Cijk_..._MT32x32x512` | rocBLAS | prefill | 备选 tile |
| `Cijk_..._MT16x16x1024` | rocBLAS | prefill | Gate proj (小 N=128) |
| `Cijk_..._MT32x16x256` | rocBLAS | decode | QKV proj, LM Head (skinny M) |
| `Cijk_..._MT64x16x128` | rocBLAS | decode | O proj (skinny M) |

### 5. MoE (5 种)
| Kernel | 来源 | 阶段 | 说明 |
|--------|------|------|------|
| `topkGatingSoftmax<bf16, 16, 128, 8>` | vllm | 两者 | 128 experts 选 top-8 |
| `MoeSortingKernel` | CK (ck_tile) | decode | 单阶段 token→expert 排序 |
| `MoeSortingMultiPhaseKernel_P0_v2` | CK (ck_tile) | prefill | 多阶段排序 phase 0 |
| `MoeSortingMultiPhaseKernel_P23` | CK (ck_tile) | prefill | 多阶段排序 phase 2+3 |
| `kernel_moe_gemm` (×2) | CK | 两者 | 2-stage fused expert GEMM (gate_up + down) |

### 6. Sampling (1 种)
| Kernel | 来源 | 说明 |
|--------|------|------|
| `mix_sample_outer_exponential_kernel` | aiter | Top-p/Top-k sampling |

### 7. Utility (2 种)
| Kernel | 来源 | 说明 |
|--------|------|------|
| `elementwise_kernel_manual_unroll` | PyTorch | reshape/split 等 |
| `index_elementwise_kernel` | PyTorch | 初始化时的索引操作 |

---

## 耗时占比 (Prefill + Decode 合计)

```
MoE Expert GEMM (CK)       ████████████████████████████████  31.0%
Dense GEMM (rocBLAS)        ███████████████████████           22.7%
RMSNorm (aiter fused)       ████████████                      12.2%
Paged Attention + Reduce    ██████████                         9.9%
MoE Gate/TopK               ███████                            6.8%
RoPE + KV Cache Store       ██████████                         9.9%
MoE Token Sorting           ██████                             6.1%
Other (emb/sample/elem)     █                                  1.2%
```

---

## Kernel 来源统计

| 来源 | Kernel 种类 | 说明 |
|------|------------|------|
| **aiter** (AMD) | 9 | RMSNorm, RoPE, PA, Flash Attn, KV Cache, Sampling |
| **CK** (Composable Kernel) | 4 | MoE GEMM, MoE Sorting |
| **rocBLAS** | 5 | Dense GEMM (不同 tile 配置) |
| **vllm** | 1 | TopK Gating Softmax |
| **Triton** | 1 | Embedding lookup |
| **PyTorch native** | 2 | Elementwise ops |

---

## Trace 来源

- 文件: `traces/rank_0/Qwen3-30B-A3B_ts_20260410_191229_847.pt.trace.json.gz`
- 命令: `python -m atom.examples.profile_offline --model Qwen/Qwen3-30B-A3B --enforce-eager --torch-profiler-dir ./traces --kv_cache_dtype fp8 --tensor-parallel-size 1`
- Profiling 窗口: 1 次 prefill (91 tokens) + 32 次 decode
