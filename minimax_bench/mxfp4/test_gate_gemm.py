"""Gate GEMM benchmark: [M, 3072] × [3072, 256] — find optimal implementation"""
import sys
import torch
import triton
import triton.language as tl

sys.path.insert(0, "/app/aiter-test")

HIDDEN = 3072
NUM_EXPERTS = 256


@triton.jit
def _gemv_tiled_kernel(
    x_ptr, w_ptr, out_ptr,
    K: tl.constexpr, N: tl.constexpr,
    BLOCK_N: tl.constexpr, BLOCK_K: tl.constexpr,
):
    pid = tl.program_id(0)
    n_offs = pid * BLOCK_N + tl.arange(0, BLOCK_N)
    acc = tl.zeros([BLOCK_N], dtype=tl.float32)
    for k_start in range(0, K, BLOCK_K):
        k_offs = k_start + tl.arange(0, BLOCK_K)
        x_val = tl.load(x_ptr + k_offs).to(tl.float32)
        w_ptrs = w_ptr + n_offs[:, None] * K + k_offs[None, :]
        w_val = tl.load(w_ptrs).to(tl.float32)
        acc += tl.sum(w_val * x_val[None, :], axis=1)
    tl.store(out_ptr + n_offs, acc.to(tl.bfloat16))


def main():
    weight_bytes = HIDDEN * NUM_EXPERTS * 2
    print(f"Gate GEMM: [M, 3072] × [3072, 256] BF16")
    print(f"Weight: {weight_bytes/1024:.1f} KB")
    print(f"Roofline @ 8 TB/s: {weight_bytes / 8e12 * 1e6:.2f} us")
    print(f"Roofline @ 5 TB/s: {weight_bytes / 5e12 * 1e6:.2f} us")
    print()

    x = torch.randn(1, HIDDEN, dtype=torch.bfloat16, device="cuda")
    w_nn = torch.randn(HIDDEN, NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
    w_tn = torch.randn(NUM_EXPERTS, HIDDEN, dtype=torch.bfloat16, device="cuda")

    results = {}

    # 1. torch.mm
    ms = triton.testing.do_bench(lambda: torch.mm(x, w_nn), warmup=50, rep=200)
    results["torch.mm NN"] = ms * 1000

    # 2. F.linear
    ms = triton.testing.do_bench(lambda: torch.nn.functional.linear(x, w_tn), warmup=50, rep=200)
    results["F.linear TN"] = ms * 1000

    # 3. torch.mv
    x_1d = x.squeeze(0)
    ms = triton.testing.do_bench(lambda: torch.mv(w_tn, x_1d), warmup=50, rep=200)
    results["torch.mv"] = ms * 1000

    # 4. torch.addmm
    bias = torch.zeros(NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
    ms = triton.testing.do_bench(lambda: torch.addmm(bias, x, w_nn), warmup=50, rep=200)
    results["torch.addmm"] = ms * 1000

    # 5. Triton tiled GEMV
    out_tri = torch.empty(NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
    for BLOCK_N in [16, 32, 64, 128, 256]:
        grid = (NUM_EXPERTS // BLOCK_N,)
        def fn(bn=BLOCK_N):
            _gemv_tiled_kernel[grid](x_1d, w_tn, out_tri,
                                     K=HIDDEN, N=NUM_EXPERTS,
                                     BLOCK_N=bn, BLOCK_K=256)
        ms = triton.testing.do_bench(fn, warmup=50, rep=200)
        results[f"Triton GEMV BN={BLOCK_N}"] = ms * 1000

    # 6. Try aiter gemm if available
    try:
        from aiter.ops.triton.gemm.basic.gemm_a16w16 import gemm_a16w16
        out_a16 = torch.empty(1, NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
        ms = triton.testing.do_bench(
            lambda: gemm_a16w16(x, w_tn, torch.bfloat16, out_a16), warmup=50, rep=200)
        results["aiter gemm_a16w16"] = ms * 1000
    except Exception as e:
        results["aiter gemm_a16w16"] = f"FAIL: {e}"

    # 7. Try hipBLASLt via torch._C._blas
    try:
        out_hipblas = torch.empty(1, NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
        ms = triton.testing.do_bench(
            lambda: torch._C._blas.gemm(x, w_nn, out_hipblas), warmup=50, rep=200)
        results["hipBLASLt gemm"] = ms * 1000
    except Exception:
        pass

    # 8. Batch size sweep with best method
    print(f"{'Method':35s}  {'Time (us)':>10s}")
    print("-" * 50)
    for name, t in sorted(results.items(), key=lambda x: x[1] if isinstance(x[1], float) else 999):
        if isinstance(t, float):
            print(f"{name:35s}  {t:10.1f}")
        else:
            print(f"{name:35s}  {t}")

    best_us = min(v for v in results.values() if isinstance(v, float))
    bw = weight_bytes / (best_us / 1e6) / 1e9
    print(f"\nBest: {best_us:.1f} us → {bw:.1f} GB/s ({bw/8000*100:.1f}% of 8 TB/s peak)")

    # 9. Batch size sweep
    print(f"\n{'M':>4s}  {'torch.mm':>10s}  {'F.linear':>10s}  {'Triton BN=64':>12s}")
    print("-" * 42)
    for M in [1, 2, 4, 8, 16, 32, 64, 128]:
        xm = torch.randn(M, HIDDEN, dtype=torch.bfloat16, device="cuda")
        ms_mm = triton.testing.do_bench(lambda: torch.mm(xm, w_nn), warmup=50, rep=200) * 1000
        ms_fl = triton.testing.do_bench(lambda: torch.nn.functional.linear(xm, w_tn), warmup=50, rep=200) * 1000
        # Triton doesn't easily handle M>1 with this GEMV kernel, skip
        print(f"{M:4d}  {ms_mm:10.1f}  {ms_fl:10.1f}")


if __name__ == "__main__":
    main()
