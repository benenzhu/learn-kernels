#!/usr/bin/env python3
"""
Build and test custom CK FP8 block-scale GEMM kernel.

Usage:
    HIP_FORCE_DEV_KERNARG=1 python custom_ck/test_custom_ck.py
"""

import os
import torch
from torch.utils.cpp_extension import load

# ---- Build paths ----
AITER_META = "/usr/local/lib/python3.12/dist-packages/aiter_meta"
CK_ROOT = f"{AITER_META}/3rdparty/composable_kernel"

SRC_DIR = os.path.dirname(os.path.abspath(__file__))

# ---- JIT compile ----
print("JIT compiling custom CK kernel...")
custom_ck = load(
    name="custom_ck_gemm",
    sources=[f"{SRC_DIR}/custom_gemm.hip"],
    extra_include_paths=[
        f"{CK_ROOT}/include",
        f"{CK_ROOT}/library/include",
        f"{AITER_META}/3rdparty/ck_helper",
    ],
    extra_cflags=["-std=c++20", "-O3", "-DUSE_ROCM=1"],
    extra_cuda_cflags=[
        "-std=c++20", "-O3",
        "-DUSE_ROCM=1",
        "-D__HIP_PLATFORM_AMD__=1",
        "-DCUDA_HAS_FP16=1",
        "-U__HIP_NO_HALF_CONVERSIONS__",
        "-U__HIP_NO_HALF_OPERATORS__",
        "-mcmodel=large",
        "-fno-gpu-rdc",
        "--offload-arch=native",
        "-fgpu-flush-denormals-to-zero",
        "-mllvm", "--amdgpu-early-inline-all=true",
        "-mllvm", "-amdgpu-function-calls=false",
    ],
    extra_ldflags=["-mcmodel=large", "-L/opt/rocm/lib", "-lamdhip64"],
    verbose=True,
)
print("Build OK!")

# ---- Quantize helpers ----
N, K = 3072, 768
fp8_dtype = torch.float8_e4m3fn
fp8_max = torch.finfo(fp8_dtype).max
device = "cuda"


def quantize_weight(w):
    n, k = w.shape
    wb = w.reshape(n // 128, 128, k // 128, 128).permute(0, 2, 1, 3)
    amax = wb.abs().amax(dim=(-2, -1)).clamp(min=1e-12)
    sc = amax / fp8_max
    wq = (wb / sc[:, :, None, None]).clamp(-fp8_max, fp8_max).to(fp8_dtype)
    return wq.permute(0, 2, 1, 3).reshape(n, k), (1.0 / sc).float()


def quantize_activation(x):
    from aiter import QuantType, get_hip_quant
    return get_hip_quant(QuantType.per_1x128)(x.contiguous(), quant_dtype=fp8_dtype)


# ---- Test correctness ----
print("\n=== Correctness Test ===")
M = 32
w = torch.randn(N, K, dtype=torch.bfloat16, device=device)
wq, ws = quantize_weight(w)
x = torch.randn(M, K, dtype=torch.bfloat16, device=device)
xq, xs = quantize_activation(x)
out = torch.empty(M, N, dtype=torch.bfloat16, device=device)

# Custom CK (KBatch=1)
custom_ck.gemm_a8w8_blockscale(xq, wq, xs, ws, out, 1)
torch.cuda.synchronize()
print(f"Custom CK (KBatch=1): {out[0, :4]}")

# Reference: aiter CK
from aiter import gemm_a8w8_blockscale
ref = gemm_a8w8_blockscale(xq, wq, xs, ws, dtype=torch.bfloat16)
print(f"aiter CK:             {ref[0, :4]}")
print(f"Match: {torch.allclose(out, ref, rtol=0.01, atol=1.0)}")

# Custom CK (KBatch=2, split-K) — KPerBlock=256, max KBatch for K=768 is 2
out2 = torch.empty(M, N, dtype=torch.bfloat16, device=device)
custom_ck.gemm_a8w8_blockscale(xq, wq, xs, ws, out2, 2)
torch.cuda.synchronize()
print(f"Custom CK (KBatch=2): {out2[0, :4]}")
print(f"SplitK match: {torch.allclose(out2, ref, rtol=0.05, atol=10.0)}")

# ---- Benchmark ----
print("\n=== Benchmark (do_bench) ===")
import triton

print(f"Shape: M={M}, N={N}, K={K}")
for kb in [1, 2]:  # KPerBlock=256 → max KBatch=2 for K=768
    out_b = torch.empty(M, N, dtype=torch.bfloat16, device=device)

    def fn(kb=kb, out_b=out_b):
        custom_ck.gemm_a8w8_blockscale(xq, wq, xs, ws, out_b, kb)

    t = triton.testing.do_bench(fn, warmup=25, rep=100, return_mode="median") * 1000
    tile_m, tile_n = 16, 128
    import math
    tiles = math.ceil(M / tile_m) * math.ceil(N / tile_n)
    wgs = tiles * kb
    print(f"  KBatch={kb}: {t:.1f} us  (WGs={wgs})")

# aiter baseline
def fn_aiter():
    gemm_a8w8_blockscale(xq, wq, xs, ws, dtype=torch.bfloat16)

t_ref = triton.testing.do_bench(fn_aiter, warmup=25, rep=100, return_mode="median") * 1000
print(f"  aiter CK:  {t_ref:.1f} us  (baseline)")
