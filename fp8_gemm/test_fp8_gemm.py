"""
FP8 Block-Scale GEMM Benchmark for MiniMax-M2.5 o_proj (RowParallelLinear)

o_proj: Linear(num_heads * head_dim, hidden_size) = Linear(6144, 3072)
TP=8 => weight [3072, 768], i.e. N=3072, K=768

Quantization:
  - Activation: per-1x128 (FP8 E4M3)
  - Weight:     per-128x128 block-scale (FP8 E4M3)

Benchmark batch_size from 4 to 256 (powers of 2).
"""

import os
from contextlib import nullcontext

import torch
import triton

# ---- Constants ----
N, K = 3072, 768  # o_proj TP=8
N, K = 3072, 3072  # o_proj TP=8
GROUP_SIZE = 128
BLOCK_SIZE = (128, 128)
BATCH_SIZES = [4, 8, 16, 32, 64, 128, 256]
WARMUP = 25
REP = 100

# Set FP8_GEMM_PROFILE=1 to dump CUDA-only profiler trace for ck_e2e / ck_gemm bench replay (first batch only, GRAPH_CAP/).
ENABLE_PROFILER = os.environ.get("FP8_GEMM_PROFILE", "") == "1"

assert os.environ["HIP_FORCE_DEV_KERNARG"] == "1"

def _graph_bench_profiler(first_batch: bool, worker_tag: str):
    """CUDA-only profiler around graph replay bench; only when ENABLE_PROFILER and first batch."""
    if not first_batch or not ENABLE_PROFILER:
        return nullcontext()
    local_rank = int(os.environ.get("LOCAL_RANK", "0"))
    os.makedirs("GRAPH_CAP", exist_ok=True)
    trace_dir = "./GRAPH_CAP"
    print(f"FP8 GEMM profiler: {worker_tag} bench replay -> {trace_dir}")
    return torch.profiler.profile(
        activities=[torch.profiler.ProfilerActivity.CUDA],
        record_shapes=False,
        profile_memory=False,
        with_stack=False,
        on_trace_ready=torch.profiler.tensorboard_trace_handler(
            trace_dir,
            worker_name=f"{worker_tag}_rank_{local_rank}",
            use_gzip=True,
        ),
    )


def quantize_activation_per_1x128(x: torch.Tensor) -> tuple[torch.Tensor, torch.Tensor]:
    """Per-1x128 activation quantization using aiter."""
    from aiter import QuantType, get_hip_quant
    fp8_dtype = torch.float8_e4m3fn
    quant_fn = get_hip_quant(QuantType.per_1x128)
    return quant_fn(x.contiguous(), quant_dtype=fp8_dtype)


def quantize_weight_per_128x128(w: torch.Tensor) -> tuple[torch.Tensor, torch.Tensor]:
    """Per-128x128 block-scale weight quantization.

    w: [N, K] in BF16
    Returns: (w_fp8 [N, K], w_scale [N/128, K/128] in float32)
    """
    fp8_dtype = torch.float8_e4m3fn
    fp8_max = torch.finfo(fp8_dtype).max

    n, k = w.shape
    bn, bk = BLOCK_SIZE
    assert n % bn == 0 and k % bk == 0

    # Reshape into blocks
    w_blocks = w.reshape(n // bn, bn, k // bk, bk)  # [n/128, 128, k/128, 128]
    w_blocks = w_blocks.permute(0, 2, 1, 3)          # [n/128, k/128, 128, 128]

    # Compute per-block scale
    amax = w_blocks.abs().amax(dim=(-2, -1))  # [n/128, k/128]
    scale = amax / fp8_max
    scale = scale.clamp(min=1e-12)

    # Quantize
    w_scaled = w_blocks / scale[:, :, None, None]
    w_fp8_blocks = w_scaled.clamp(-fp8_max, fp8_max).to(fp8_dtype)

    # Reshape back to [N, K]
    w_fp8 = w_fp8_blocks.permute(0, 2, 1, 3).reshape(n, k)

    # scale_inv = 1/scale for dequant (match vllm convention)
    scale_inv = (1.0 / scale).to(torch.float32)

    return w_fp8, scale_inv


NUM_INPUTS = 100  # number of different inputs captured in CUDA graph


def capture_graph(fn, num_inputs=NUM_INPUTS):
    """Capture a CUDA graph that replays fn() over num_inputs different calls.
    Returns a callable that replays the graph once (covering all num_inputs iterations).
    """
    # Warmup (outside graph capture, to trigger lazy init / JIT)
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
    """Benchmark a captured CUDA graph, return per-iteration median time in us."""
    def replay():
        graph.replay()
    t_total = triton.testing.do_bench(replay, warmup=WARMUP, rep=REP, return_mode="median")
    return t_total / num_inputs * 1000  # ms -> us, per iteration


def bench_fp8_gemm():
    """Benchmark FP8 block-scale GEMM vs BF16 GEMM using CUDA graph replay."""
    from aiter import gemm_a8w8_blockscale
    from aiter.ops.triton.gemm.basic.gemm_a16w8_blockscale import gemm_a16w8_blockscale

    device = "cuda"

    # Pre-generate NUM_INPUTS different weights (avoid cache hits)
    weights_fp32 = [torch.randn(N, K, dtype=torch.float32, device=device) for _ in range(NUM_INPUTS)]
    weights_bf16 = [w.to(torch.bfloat16) for w in weights_fp32]
    weights_fp8, weights_scale = [], []
    for w in weights_bf16:
        wq, ws = quantize_weight_per_128x128(w)
        weights_fp8.append(wq)
        weights_scale.append(ws)

    print(f"o_proj TP=8: weight [{N}, {K}], CUDA graph replay x{NUM_INPUTS}")
    print(f"{'batch':>6} | {'CK q+g(us)':>11} | {'CK gemm(us)':>12} | {'fused(us)':>10} | {'BF16(us)':>9} | {'FP32(us)':>9} | {'fused/CK':>8}")
    print("-" * 85)

    for i, M in enumerate(BATCH_SIZES):
        # Pre-generate NUM_INPUTS different inputs
        inputs_fp32 = [torch.randn(M, K, dtype=torch.float32, device=device) for _ in range(NUM_INPUTS)]
        inputs_bf16 = [x.to(torch.bfloat16) for x in inputs_fp32]
        # Pre-quantized inputs for CK gemm-only path
        inputs_fp8 = []
        for x in inputs_bf16:
            a_q, a_s = quantize_activation_per_1x128(x)
            inputs_fp8.append((a_q, a_s))

        # --- CK path: quant + gemm (end-to-end) ---
        idx = [0]
        def fn_ck_e2e():
            i = idx[0] % NUM_INPUTS
            a_q, a_s = quantize_activation_per_1x128(inputs_bf16[i])
            gemm_a8w8_blockscale(a_q, weights_fp8[i], a_s, weights_scale[i], dtype=torch.bfloat16)
            idx[0] += 1

        g_ck_e2e = capture_graph(fn_ck_e2e)
        # with _graph_bench_profiler(i == 0, "ck_e2e"):

        # --- CK path: gemm only (pre-quantized) ---
        idx[0] = 0
        def fn_ck_gemm():
            i = idx[0] % NUM_INPUTS
            gemm_a8w8_blockscale(inputs_fp8[i][0], weights_fp8[i], inputs_fp8[i][1], weights_scale[i], dtype=torch.bfloat16)
            idx[0] += 1

        g_ck_gemm = capture_graph(fn_ck_gemm)
        with _graph_bench_profiler(i == 0, "ck_gemm"):
            t_ck_e2e = bench_graph(g_ck_e2e)
            t_ck_gemm = bench_graph(g_ck_gemm)

        # --- Fused triton: a16w8 with PREQUANT ---
        idx[0] = 0
        def fn_fused():
            i = idx[0] % NUM_INPUTS
            gemm_a16w8_blockscale(inputs_bf16[i], weights_fp8[i], weights_scale[i], dtype=torch.bfloat16, prequant=True)
            idx[0] += 1

        g_fused = capture_graph(fn_fused)
        t_fused = bench_graph(g_fused)

        # --- BF16 baseline ---
        idx[0] = 0
        def fn_bf16():
            i = idx[0] % NUM_INPUTS
            torch.mm(inputs_bf16[i], weights_bf16[i].T)
            idx[0] += 1

        g_bf16 = capture_graph(fn_bf16)
        t_bf16 = bench_graph(g_bf16)

        # --- FP32 baseline ---
        idx[0] = 0
        def fn_fp32():
            i = idx[0] % NUM_INPUTS
            torch.mm(inputs_fp32[i], weights_fp32[i].T)
            idx[0] += 1

        g_fp32 = capture_graph(fn_fp32)
        t_fp32 = bench_graph(g_fp32)

        ratio = t_ck_e2e / t_fused
        print(f"{M:>6} | {t_ck_e2e:>11.1f} | {t_ck_gemm:>12.1f} | {t_fused:>10.1f} | {t_bf16:>9.1f} | {t_fp32:>9.1f} | {ratio:>7.2f}x")

        # Free graphs
        del g_ck_e2e, g_ck_gemm, g_fused, g_bf16, g_fp32


if __name__ == "__main__":
    bench_fp8_gemm()
