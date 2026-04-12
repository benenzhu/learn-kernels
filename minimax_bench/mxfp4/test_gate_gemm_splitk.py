"""Gate GEMM split-K benchmark: [M, 3072] × [3072, 256] BF16"""
import sys
import torch
import triton

sys.path.insert(0, "/app/aiter-test")
from aiter.ops.triton.gemm.basic.gemm_a16w16 import gemm_a16w16

HIDDEN = 3072
NUM_EXPERTS = 256
NUM_INPUTS = 100


def bench_graph(M, fn_factory):
    """CUDA graph replay benchmark"""
    fn = fn_factory()
    for _ in range(3):
        fn()
    torch.cuda.synchronize()

    stream = torch.cuda.Stream()
    with torch.cuda.stream(stream):
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            for _ in range(NUM_INPUTS):
                fn()
    torch.cuda.synchronize()

    ms = triton.testing.do_bench(graph.replay, warmup=25, rep=100)
    return ms / NUM_INPUTS * 1000  # us


def main():
    print(f"Gate GEMM [M, 3072] × [256, 3072]^T BF16 — Split-K sweep (CUDA graph)")
    print()

    w = torch.randn(NUM_EXPERTS, HIDDEN, dtype=torch.bfloat16, device="cuda")

    for M in [1, 4, 16, 32, 64, 128]:
        print(f"M={M}:")
        xs = [torch.randn(M, HIDDEN, dtype=torch.bfloat16, device="cuda") for _ in range(NUM_INPUTS)]

        # Baseline: torch.mm (rocBLAS)
        idx = [0]
        out_mm = torch.empty(M, NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
        def make_mm():
            idx[0] = 0
            def fn():
                torch.mm(xs[idx[0] % NUM_INPUTS], w.t(), out=out_mm)
                idx[0] += 1
            return fn
        us_mm = bench_graph(M, make_mm)
        print(f"  rocBLAS torch.mm:           {us_mm:7.1f} us")

        # Triton gemm_a16w16 with different split-K configs
        for ksplit in [1, 2, 4, 6, 8, 12, 16, 24]:
            for bm in [16, 32]:
                for bn in [16, 32, 64]:
                    if bn > NUM_EXPERTS:
                        continue
                    for bk in [128, 256]:
                        sk_block = HIDDEN // ksplit
                        if sk_block < bk or sk_block % bk != 0:
                            continue
                        config = {
                            "BLOCK_SIZE_M": bm,
                            "BLOCK_SIZE_N": bn,
                            "BLOCK_SIZE_K": bk,
                            "GROUP_SIZE_M": 1,
                            "NUM_KSPLIT": ksplit,
                            "SPLITK_BLOCK_SIZE": sk_block,
                            "num_warps": 4,
                            "num_stages": 2,
                        }
                        num_tiles = ((M + bm - 1) // bm) * ((NUM_EXPERTS + bn - 1) // bn) * ksplit
                        try:
                            out_tri = torch.empty(M, NUM_EXPERTS, dtype=torch.bfloat16, device="cuda")
                            # Quick test
                            gemm_a16w16(xs[0], w, dtype=torch.bfloat16, y=out_tri, config=config)
                            torch.cuda.synchronize()

                            ms = triton.testing.do_bench(
                                lambda: gemm_a16w16(xs[0], w, dtype=torch.bfloat16, y=out_tri, config=config),
                                warmup=25, rep=100
                            )
                            us = ms * 1000
                            if us < us_mm * 1.5:  # only show competitive results
                                print(f"  Triton ksplit={ksplit:2d} {bm}x{bn}x{bk}: {us:7.1f} us  tiles={num_tiles:5d}  {'*** FASTER' if us < us_mm else ''}")
                        except Exception as e:
                            pass
        print()


if __name__ == "__main__":
    main()
