---
name: llm-kernel-map
description: Map complete kernel pipeline for LLM inference (prefill vs decode)
user-invocable: true
---

# LLM Kernel Map Skill

Maps out the complete kernel pipeline for LLM inference, identifying prefill vs decode differences.

## When to use

User asks about what kernels an LLM uses, how inference works end-to-end,
or wants to compare different model architectures at the kernel level.

## Standard Transformer Inference Pipeline

```
tokens → Embedding → [Decoder Layer × N] → Final Norm → LM Head → Sampling → token_id
```

### Decoder Layer (Dense Model, e.g., Llama, Qwen3-dense)

```
Prefill (multi-token):                    Decode (single-token):
  RMSNorm (pre-attn)                        RMSNorm (pre-attn)
  QKV GEMM (large M)                        QKV GEMM (skinny M)
  RoPE                                      RoPE
  KV Cache Store                             KV Cache Store
  Flash Attention (fmha)                     Paged Attention (PA) + Reduce
  O GEMM (large M)                           O GEMM (skinny M)
  RMSNorm + Residual Add                     RMSNorm + Residual Add
  Gate+Up GEMM (large M)                     Gate+Up GEMM (skinny M)
  SiLU activation                            SiLU activation
  Down GEMM (large M)                        Down GEMM (skinny M)
  RMSNorm + Residual Add                     RMSNorm + Residual Add
```

### Decoder Layer (MoE Model, e.g., Qwen3-MoE, DeepSeek)

```
Same as above but MLP replaced by:
  Gate GEMM → TopK Softmax → Token Sort → Expert GEMM (2-stage) → Accumulate
```

### Decoder Layer (MLA Model, e.g., DeepSeek-V3)

```
Same as above but Attention replaced by:
  Down-proj Q/KV → Latent attention → Up-proj → (no explicit KV cache separation)
```

## Key Prefill vs Decode Differences

| Dimension | Prefill | Decode |
|-----------|---------|--------|
| GEMM shape | M=seq_len (large) | M=1 (skinny) |
| GEMM kernel | Large tile (MT64x32x256) | Skinny tile (MT32x16x256) |
| Attention | Flash Attention (O(N^2d)) | Paged Attention (O(Nd)) |
| MoE Sort | Multi-phase (many tokens) | Single-phase (1 token) |
| Bottleneck | Compute (GEMM, MoE) | Memory BW (PA reads KV cache) |
| Latency | Higher total, amortized per token | Lower per token |

## Kernel Provider Mapping (AMD/ROCm)

| Function | Provider | Note |
|----------|----------|------|
| Embedding | PyTorch native / Triton | `aten::index_select` or `triton_poi_fused_embedding` |
| RMSNorm | aiter | Fused add+norm+quant, HIP C++ |
| RoPE | aiter | 2-channel inplace, HIP C++ |
| KV Cache | aiter | Per-token FP8 quant, HIP C++ |
| Flash Attention | aiter | Hand-written ASM (.co binary) |
| Paged Attention | aiter | Hand-written ASM (.co binary) |
| Dense GEMM | rocBLAS | Cijk_* kernels, auto-tuned tiles |
| MoE Gate | vllm | topkGatingSoftmax CUDA kernel |
| MoE Sort | CK (ck_tile) | MoeSortingKernel |
| MoE Expert GEMM | CK | kernel_moe_gemm (2-stage fused) |
| Sampling | aiter | Gumbel-max trick, HIP C++ |

## Performance Profile Template

```
Category                Time%   Bound-by
MoE Expert GEMM         31%    Compute (prefill) / Memory (decode)
Dense GEMM (QKV/O)      23%    Compute (prefill) / Memory (decode)
RMSNorm                 12%    Launch overhead (small n)
Paged Attention          10%    Memory BW (reads KV cache)
MoE Gate+Sort            13%    Launch overhead
RoPE + KV Cache          10%    Launch overhead
Other                     1%    -
```

## Architecture Params Quick Reference

| Model | hidden | layers | heads | KV heads | head_dim | experts | topk |
|-------|--------|--------|-------|----------|----------|---------|------|
| Qwen3-30B-A3B | 2048 | 48 | 32 | 4 | 128 | 128 | 8 |
| Qwen3-235B-A22B | 4096 | 94 | 64 | 4 | 128 | 128 | 8 |
| DeepSeek-V3 | 7168 | 61 | 128 | 128(MLA) | 128 | 256 | 8 |
| Llama-3-70B | 8192 | 80 | 64 | 8 | 128 | - | - |
