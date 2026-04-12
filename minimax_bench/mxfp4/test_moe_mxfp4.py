"""
MoE MXFP4 GEMM Benchmark for MiniMax-M2.5

Compare:
  1. fused_moe_mxfp4 (unfused, separate SiLU)
  2. fused_moe_mxfp4_silu (fused SiLU)
  3. FP8 CK kernel_moe_gemm (baseline from FP8 model)

MiniMax-M2.5 shapes (TP=4):
  stage1 (up+gate): A=[M, 3072] × W=[E, 3072, 1536*2], top-8 of 256 experts
  stage2 (down):    A=[M, 1536] × W=[E, 1536, 3072],    top-8 of 256 experts
"""

import sys
import torch
import triton

sys.path.insert(0, "/app/aiter-test")
from aiter.ops.triton.moe.moe_op_mxfp4 import fused_moe_mxfp4
from aiter.ops.triton.moe.moe_op_mxfp4_silu_fused import fused_moe_mxfp4_silu
from aiter.ops.triton.utils.types import torch_to_triton_dtype
from op_tests.triton_tests.moe.test_moe_mx import input_helper

# MiniMax-M2.5 config
HIDDEN = 3072
INTER = 1536
NUM_EXPERTS = 256
TOP_K = 8

# Shapes to test
CONFIGS = [
    # (label, M, N, K, E, top_k)
    # stage1: up+gate fused (N = intermediate * 2)
    ("stage1_bs1", 1, INTER * 2, HIDDEN, NUM_EXPERTS, TOP_K),
    ("stage1_bs4", 4, INTER * 2, HIDDEN, NUM_EXPERTS, TOP_K),
    ("stage1_bs8", 8, INTER * 2, HIDDEN, NUM_EXPERTS, TOP_K),
    ("stage1_bs16", 16, INTER * 2, HIDDEN, NUM_EXPERTS, TOP_K),
    ("stage1_bs32", 32, INTER * 2, HIDDEN, NUM_EXPERTS, TOP_K),
    # stage2: down_proj
    ("stage2_bs1", 1, HIDDEN, INTER, NUM_EXPERTS, TOP_K),
    ("stage2_bs4", 4, HIDDEN, INTER, NUM_EXPERTS, TOP_K),
    ("stage2_bs8", 8, HIDDEN, INTER, NUM_EXPERTS, TOP_K),
    ("stage2_bs16", 16, HIDDEN, INTER, NUM_EXPERTS, TOP_K),
    ("stage2_bs32", 32, HIDDEN, INTER, NUM_EXPERTS, TOP_K),
]

A_DTYPE = "mxfp4_e2m1"
B_DTYPE = "mxfp4_e2m1"


def bench_one(label, M, N, K, E, top_k, warmup=25, rep=100):
    (
        a_tri, b_tri, c_tri, c_tri_silu,
        a_scale, b_scale, a_mx_scales, b_mx_scales,
        topk_weights, topk_ids,
        sorted_token_ids, expert_ids, num_tokens_post_padded,
        top_k, config,
    ) = input_helper(M, N, K, top_k, E, A_DTYPE, B_DTYPE)

    c_dtype_triton = torch_to_triton_dtype[c_tri.dtype]
    routed_weight = False
    swizzle_mx = False

    # 1. Unfused MXFP4 MoE
    def fn_unfused():
        fused_moe_mxfp4(
            a_tri, b_tri, c_tri,
            a_scale, b_scale, a_mx_scales, b_mx_scales,
            topk_weights, topk_ids,
            sorted_token_ids, expert_ids, num_tokens_post_padded,
            routed_weight, top_k, swizzle_mx, swizzle_mx, config, c_dtype_triton,
        )

    ms_unfused = triton.testing.do_bench(fn_unfused, warmup=warmup, rep=rep)

    # 2. Fused MXFP4 MoE + SiLU (only for stage1 where N = intermediate * 2)
    ms_fused_silu = None
    if N == INTER * 2:
        c_silu = torch.zeros((M * top_k, N // 2), dtype=c_tri.dtype, device="cuda")

        def fn_fused_silu():
            fused_moe_mxfp4_silu(
                a_tri, b_tri, c_silu,
                a_scale, b_scale, a_mx_scales, b_mx_scales,
                topk_weights, topk_ids,
                sorted_token_ids, expert_ids, num_tokens_post_padded,
                routed_weight, top_k, swizzle_mx, swizzle_mx, config, c_dtype_triton,
            )

        ms_fused_silu = triton.testing.do_bench(fn_fused_silu, warmup=warmup, rep=rep)

    # Compute metrics
    flops = 2.0 * M * top_k * K * N
    tflops_unfused = flops / (ms_unfused * 1e-3) * 1e-12

    print(f"  {label:15s}  M={M:4d}  N={N:5d}  K={K:5d}  E={E:3d}  top_k={top_k}")
    print(f"    unfused:    {ms_unfused*1000:8.1f} us  ({tflops_unfused:.2f} TFLOPS)")
    if ms_fused_silu is not None:
        tflops_silu = flops / (ms_fused_silu * 1e-3) * 1e-12
        speedup = ms_unfused / ms_fused_silu
        print(f"    fused_silu: {ms_fused_silu*1000:8.1f} us  ({tflops_silu:.2f} TFLOPS)  speedup={speedup:.2f}x")
    print()


def main():
    print("=" * 80)
    print("MoE MXFP4 GEMM Benchmark — MiniMax-M2.5 Shapes")
    print("=" * 80)
    print()

    for label, M, N, K, E, top_k in CONFIGS:
        try:
            bench_one(label, M, N, K, E, top_k)
        except Exception as e:
            print(f"  {label}: FAILED — {e}")
            print()


if __name__ == "__main__":
    main()
