# Qwen3-30B-A3B 源码调用链

> 从 model_runner 到 GPU kernel 的完整调用路径

## 顶层入口

```
model_runner.py:1535  run_model()
  → model_runner.py:1691  forward()
    → Qwen3MoeForCausalLM.forward()       # qwen3_moe.py:490
```

## 1. Embedding

```
Qwen3MoeForCausalLM.forward()              # qwen3_moe.py:490
  → Qwen3MoeModel.forward()                # qwen3_moe.py:401
    → get_input_embeddings()                # qwen3_moe.py:398
      → VocabParallelEmbedding.forward()    # embed_head.py:131
        → F.embedding()                     # torch/nn/functional.py:2428
          ⇒ GPU: indexSelectSmallIndex / vectorized_gather_kernel
```

## 2. Decoder Layer (× 48)

```
Qwen3MoeModel.forward()                    # qwen3_moe.py:401
  → for layer in self.layers:
      → Qwen3MoeDecoderLayer.forward()      # qwen3_moe.py:234
```

### 2.1 Pre-Attention RMSNorm

```
Qwen3MoeDecoderLayer.forward()              # qwen3_moe.py:234
  → RMSNorm.forward()                       # decorators.py:127 wrapped
    → layernorm.py:210  forward()
      → layernorm.py:59  rmsnorm2d_fwd_()
        → aiter/ops/rmsnorm.py:62  rmsnorm2d_fwd()
          ⇒ GPU: aiter::rmsnorm → add_rmsnorm_quant_kernel<64, false>
```

### 2.2 QKV Projection

```
Qwen3MoeDecoderLayer.forward()
  → Qwen3MoeAttention.forward()
    → QKVParallelLinear.forward()           # decorators.py:127 wrapped
      → linear.py:398  forward()
        → aiter/tuned_gemm.py:447  mm()
          → tuned_gemm.py:213  gemm_a16w16()
            → tuned_gemm.py:340  torch_gemm()    # prefill
            → tuned_gemm.py:284  skinny_gemm()   # decode
              ⇒ GPU: Cijk_... (rocBLAS) / wv_splitk_small
```

### 2.3 RoPE + KV Cache Store

```
Qwen3MoeAttention.forward()
  → PagedAttention.forward()                # paged_attention.py:201
    → unified_attention_with_output_base()  # base_attention.py:232
      → MHAAttention.forward()              # attention_mha.py:549
        → forward_impl_server_mode()        # attention_mha.py:85
          → rope_cache()                    # attention_mha.py:120
            │
            ├─ RotaryEmbedding.forward()     # aiter/rotary_embedding.py:142
            │    → forward_hip()             # rotary_embedding.py:256
            │      → rope_cached_positions_2c_fwd_inplace()  # ops/rope.py:833
            │        ⇒ GPU: kn_entry_2c_sbhd_cached_indirect_inplace
            │
            └─ reshape_and_cache_with_pertoken_quant()
                 ⇒ GPU: reshape_and_cache_with_per_token_quant_kernel
```

### 2.4 Attention

```
(续 forward_impl_server_mode)
          │
          ├─ [Prefill] prefill_attention()     # attention_mha.py:453
          │    → flash_attn_varlen_func()       # aiter/ops/mha.py:2543
          │      → _flash_attn_varlen_forward() # ops/mha.py:1980
          │        ⇒ GPU: fmha_fwd_hd128_bf16_causal_group (ASM)
          │
          └─ [Decode] paged_attention_asm()    # attention_mha.py:400
               → pa_fwd_asm()                  # aiter/ops/attention.py:129
                 ⇒ GPU: pa_bf16_pertokenFp8_gqa8_2tg_4w (ASM)
```

### 2.5 O Projection

```
Qwen3MoeAttention.forward()
  → RowParallelLinear.forward()             # decorators.py:127 wrapped
    → linear.py:398  forward()
      → aiter/tuned_gemm.py:447  mm()
        ⇒ GPU: Cijk_... (rocBLAS)
```

### 2.6 Post-Attention RMSNorm + Residual

```
Qwen3MoeDecoderLayer.forward()
  → RMSNorm.forward()                       # decorators.py:127 wrapped
    → layernorm.py:210  forward()
      → layernorm.py:68  rmsnorm2d_fwd_with_add_()
        → aiter/ops/rmsnorm.py:76  rmsnorm2d_fwd_with_add()
          ⇒ GPU: add_rmsnorm_quant_kernel<256, true>  (fused residual add)
```

### 2.7 MoE MLP

```
Qwen3MoeDecoderLayer.forward()
  → Qwen3MoeSparseMoeBlock.forward()
    → FusedMoE.forward()                    # moe.py:2540
      → moe_forward()                       # moe.py:1829
        → forward_impl()                    # moe.py:2600
          → apply()                         # moe.py:453
            │
            ├─ select_experts()              # moe.py:2471
            │    → Gate GEMM: ReplicatedLinear.forward()
            │        ⇒ GPU: Cijk_... (rocBLAS)
            │    → rocm_aiter_topk_softmax() # topK.py:363
            │        ⇒ GPU: topkGatingSoftmax
            │
            └─ fused_moe()                  # aiter/fused_moe.py:119
                 → fused_moe_()             # fused_moe.py:206
                   │
                   ├─ moe_sorting()          # fused_moe.py:71
                   │    → _moe_sorting_impl() # fused_moe.py:28
                   │      ⇒ GPU: MoeSortingKernel / MoeSortingMultiPhase
                   │
                   └─ fused_moe_2stages()   # fused_moe.py:1102
                        ├─ ck_moe_stage1()   # fused_moe.py:1688
                        │    → moe_op.py:532
                        │      ⇒ GPU: kernel_moe_gemm (gate_up + SiLU)
                        └─ ck_moe_stage2()
                             → moe_op.py:576
                               ⇒ GPU: kernel_moe_gemm (down + accumulate)
```

### 2.8 Post-MoE RMSNorm + Residual

```
(同 2.6, add_rmsnorm_quant_kernel<256, true>)
```

## 3. LM Head

```
Qwen3MoeForCausalLM.forward()              # qwen3_moe.py:490
  → compute_logits()                        # qwen3_moe.py:507
    → RMSNorm (final)
        ⇒ GPU: add_rmsnorm_quant_kernel<256, false>
    → ParallelLMHead.forward()              # embed_head.py:168
        ⇒ GPU: aten::sub, aten::copy_
        ⇒ GPU: Cijk_... (rocBLAS, N=151936)
```

## 4. Sampling

```
model_runner.py:1586  postprocess()
  → Sampler.forward()                       # sampler.py:51
    → _temperature_sample()                  # sampler.py:91
      ⇒ GPU: mix_sample_outer_exponential_kernel
```

## 关键文件索引

| 文件 | 说明 |
|------|------|
| `atom/models/qwen3_moe.py` | 模型定义 (层结构, forward) |
| `atom/model_ops/layernorm.py` | RMSNorm 封装 |
| `atom/model_ops/linear.py` | 所有 Linear 层 |
| `atom/model_ops/attention_mha.py` | MHA Attention (RoPE, prefill, decode) |
| `atom/model_ops/paged_attention.py` | Paged Attention 封装 |
| `atom/model_ops/moe.py` | FusedMoE 封装 |
| `atom/model_ops/topK.py` | TopK Gating 路由 |
| `atom/model_ops/embed_head.py` | Embedding + LM Head |
| `atom/model_ops/sampler.py` | Sampling |
| `aiter/ops/rmsnorm.py` | aiter RMSNorm 入口 |
| `aiter/ops/rope.py` | aiter RoPE 入口 |
| `aiter/ops/mha.py` | aiter Flash Attention 入口 |
| `aiter/ops/attention.py` | aiter Paged Attention 入口 |
| `aiter/ops/moe_op.py` | aiter CK MoE GEMM 入口 |
| `aiter/fused_moe.py` | MoE 完整流水线 (sort + 2stage GEMM) |
| `aiter/tuned_gemm.py` | GEMM 路由 (rocBLAS / skinny / tuned) |
| `aiter/rotary_embedding.py` | RoPE 实现 |
