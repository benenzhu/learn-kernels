"""
Attention GEMM Benchmark for MiniMax-M2.5

Compare o_proj and qkv_proj GEMM using different backends:
  1. torch.mm (BF16 baseline, uses rocBLAS)
  2. CK gemm_a8w8_blockscale (FP8 per-128x128 block-scale)
  3. Triton gemm_afp4wfp4 (MXFP4)

MiniMax-M2.5 shapes (TP=4):
  o_proj:   [M, 3072] × [3072, 768]   (hidden → hidden/tp)
  qkv_proj: [M, 3072] × [3072, 1024]  (hidden → (q+k+v)/tp)

Key finding from profiling:
  - FP8 CK qkv_proj: 18.5 us (+ 5.6 us quant = 24.1 us total)
  - MXFP4 rocBLAS qkv_proj: 12.5 us (no quant needed, attn excluded from MXFP4)
  - rocBLAS BF16 is FASTER than CK FP8 for these small shapes!
"""

import sys
import torch
import triton

sys.path.insert(0, "/app/aiter-test")

# CUDA graph replay benchmark
NUM_INPUTS = 100
WARMUP = 25
REP = 100


def capture_graph(fn, num_inputs=NUM_INPUTS):
    for _ in range(3):
        fn()
    torch.cuda.synchronize()

    stream = torch.cuda.Stream()
    with torch.cuda.stream(stream):
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            for _ in range(num_inputs):
                fn()
    torch.cuda.synchronize()
    return graph


def bench_graph(graph, num_inputs=NUM_INPUTS):
    t_ms = triton.testing.do_bench(
        graph.replay, warmup=WARMUP, rep=REP, return_mode="median"
    )
    return t_ms / num_inputs * 1000  # us per iteration


# MiniMax-M2.5 shapes
SHAPES = [
    # (label, M, N, K)
    ("o_proj_tp2", 1, 1536, 3072),   # TP=2: N=3072/2
    ("o_proj_tp4", 1, 768, 3072),    # TP=4: N=3072/4
    ("qkv_proj_tp2", 1, 2048, 3072), # TP=2: (48+8+8)*64/2
    ("qkv_proj_tp4", 1, 1024, 3072), # TP=4: (48+8+8)*64/4
    # Larger batch sizes
    ("o_proj_tp4_bs4", 4, 768, 3072),
    ("qkv_proj_tp4_bs4", 4, 1024, 3072),
    ("o_proj_tp4_bs16", 16, 768, 3072),
    ("qkv_proj_tp4_bs16", 16, 1024, 3072),
]


def bench_bf16(M, N, K, num_inputs=NUM_INPUTS):
    """BF16 torch.mm (rocBLAS backend)"""
    xs = [torch.randn(M, K, dtype=torch.bfloat16, device="cuda") for _ in range(num_inputs)]
    w = torch.randn(K, N, dtype=torch.bfloat16, device="cuda")
    out = torch.empty(M, N, dtype=torch.bfloat16, device="cuda")
    idx = [0]

    def fn():
        torch.mm(xs[idx[0] % num_inputs], w, out=out)
        idx[0] += 1

    graph = capture_graph(fn, num_inputs)
    return bench_graph(graph, num_inputs)


def bench_fp8_ck(M, N, K, num_inputs=NUM_INPUTS):
    """FP8 CK gemm_a8w8_blockscale (quant + gemm)"""
    try:
        from aiter import gemm_a8w8_blockscale as ck_gemm
        from aiter import QuantType, get_hip_quant
    except ImportError:
        return None, None

    quant_fn = get_hip_quant(QuantType.per_1x128)
    w_bf16 = torch.randn(N, K, dtype=torch.bfloat16, device="cuda")
    wq, w_scale = quant_fn(w_bf16, quant_dtype=torch.float8_e4m3fn)

    xs = [torch.randn(M, K, dtype=torch.bfloat16, device="cuda") for _ in range(num_inputs)]
    idx = [0]

    # Bench gemm-only (pre-quantized)
    xq0, x_scale0 = quant_fn(xs[0], quant_dtype=torch.float8_e4m3fn)
    out = torch.empty(M, N, dtype=torch.bfloat16, device="cuda")

    def fn_gemm_only():
        ck_gemm(xq0, wq, x_scale0, w_scale, dtype=torch.bfloat16)

    try:
        graph_gemm = capture_graph(fn_gemm_only, num_inputs)
        t_gemm = bench_graph(graph_gemm, num_inputs)
    except Exception:
        t_gemm = None

    # Bench quant + gemm (end-to-end)
    def fn_e2e():
        x = xs[idx[0] % num_inputs]
        xq, xs_ = quant_fn(x, quant_dtype=torch.float8_e4m3fn)
        ck_gemm(xq, wq, xs_, w_scale, dtype=torch.bfloat16)
        idx[0] += 1

    try:
        graph_e2e = capture_graph(fn_e2e, num_inputs)
        t_e2e = bench_graph(graph_e2e, num_inputs)
    except Exception:
        t_e2e = None

    return t_gemm, t_e2e


def bench_fp4_triton(M, N, K, num_inputs=NUM_INPUTS):
    """MXFP4 Triton gemm_afp4wfp4"""
    try:
        from aiter.ops.triton.gemm.basic.gemm_afp4wfp4 import gemm_afp4wfp4
        from op_tests.triton_tests.gemm.basic.test_gemm_afp4wfp4 import generate_gemm_afp4wfp4_inputs
    except ImportError:
        return None

    x, _, w, _, _, x_scale, w_scale, _, y = generate_gemm_afp4wfp4_inputs(
        M, N, K, torch.bfloat16, layout="tn", output=True
    )

    def fn():
        gemm_afp4wfp4(x, w, x_scale, w_scale, torch.bfloat16, y)

    ms = triton.testing.do_bench(fn, warmup=WARMUP, rep=REP)
    return ms * 1000  # us


def main():
    print("=" * 90)
    print("Attention GEMM Benchmark — MiniMax-M2.5 Shapes")
    print("=" * 90)
    print()
    print(f"{'Shape':25s} {'M':>4s} {'N':>5s} {'K':>5s}  {'BF16(us)':>9s} {'FP8 gemm':>9s} {'FP8 e2e':>9s} {'FP4(us)':>9s}")
    print("-" * 90)

    for label, M, N, K in SHAPES:
        t_bf16 = bench_bf16(M, N, K)
        t_fp8_gemm, t_fp8_e2e = bench_fp8_ck(M, N, K)
        t_fp4 = bench_fp4_triton(M, N, K)

        bf16_str = f"{t_bf16:9.1f}"
        fp8g_str = f"{t_fp8_gemm:9.1f}" if t_fp8_gemm else "    N/A  "
        fp8e_str = f"{t_fp8_e2e:9.1f}" if t_fp8_e2e else "    N/A  "
        fp4_str = f"{t_fp4:9.1f}" if t_fp4 else "    N/A  "

        print(f"{label:25s} {M:4d} {N:5d} {K:5d}  {bf16_str} {fp8g_str} {fp8e_str} {fp4_str}")

    print()
    print("Notes:")
    print("  BF16: torch.mm (rocBLAS), CUDA graph replay ×100")
    print("  FP8 gemm: CK gemm_a8w8_blockscale (pre-quantized input)")
    print("  FP8 e2e: quant + CK gemm (end-to-end)")
    print("  FP4: Triton gemm_afp4wfp4 (do_bench, no graph)")


if __name__ == "__main__":
    main()
