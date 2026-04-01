#!/usr/bin/env python3
"""
Benchmark gfx950 FP8 block-scale ASM kernel vs CK vs BF16.

Directly loads the .co kernel via HIP runtime (ctypes) to bypass
aiter's JIT build (which fails for module_gemm_gfx950_a8w8_blockscale_asm).

Split-K status: kernel ISA supports split-K (global_atomic_add_f32 path),
but splitk>0 uses atomic_add_f32 which writes FP32 (4B per element)
while output buffer is BF16 (2B) — causes out-of-bounds write.
Enabling split-K requires FP32 output buffer + post-reduce BF16 convert.
Currently benchmarking splitk=0 only.

Shape: o_proj TP=8, N=3072, K=768
"""

import ctypes
import os
import struct

import torch
import triton

# ---- Constants ----
N, K = 3072, 768
BLOCK_SIZE = (128, 128)
BATCH_SIZES = [32, 64, 128, 256]
NUM_INPUTS = 100
WARMUP = 25
REP = 100

assert os.environ.get("HIP_FORCE_DEV_KERNARG") == "1", \
    "Set HIP_FORCE_DEV_KERNARG=1"

CO_DIR = "/usr/local/lib/python3.12/dist-packages/aiter_meta/hsa/gfx950"

# ---- HIP runtime ----
_hip = ctypes.CDLL("libamdhip64.so")
_hip.hipModuleLoad.restype = ctypes.c_int
_hip.hipModuleLoad.argtypes = [ctypes.POINTER(ctypes.c_void_p), ctypes.c_char_p]
_hip.hipModuleGetFunction.restype = ctypes.c_int
_hip.hipModuleGetFunction.argtypes = [ctypes.POINTER(ctypes.c_void_p), ctypes.c_void_p, ctypes.c_char_p]
_hip.hipModuleLaunchKernel.restype = ctypes.c_int
_hip.hipModuleLaunchKernel.argtypes = [
    ctypes.c_void_p, ctypes.c_uint, ctypes.c_uint, ctypes.c_uint,
    ctypes.c_uint, ctypes.c_uint, ctypes.c_uint, ctypes.c_uint,
    ctypes.c_void_p, ctypes.c_void_p, ctypes.c_void_p,
]


def _load_kernel(co_file, kernel_name):
    mod = ctypes.c_void_p()
    func = ctypes.c_void_p()
    path = f"{CO_DIR}/{co_file}"
    assert _hip.hipModuleLoad(ctypes.byref(mod), path.encode()) == 0, f"Failed: {path}"
    assert _hip.hipModuleGetFunction(ctypes.byref(func), mod, kernel_name.encode()) == 0
    return mod, func  # keep mod alive


# ---- KernelArgs (368 bytes) ----
_P = lambda p: struct.pack("<Q8x", p)  # ptr(8) + pad(8) = 16
_U = lambda v: struct.pack("<I12x", v)  # uint(4) + pad(12) = 16


def _pack_args(out, xq, wsh, xst, wst, M, splitk=0):
    return (
        _P(out.data_ptr()) + _P(xq.data_ptr()) + _P(wsh.data_ptr()) + _P(0) +
        _P(xst.data_ptr()) + _P(wst.data_ptr()) + _P(0) + _P(0) + _P(0) +
        _U(K) + _U(N) + _U(M) + _U(1) +
        _U(K) + _U(K) + _U(N * 2) +
        _U(0) + _U(0) + _U(0) + _U(0) +
        _U(splitk) + _U(0) + _P(0)
    )


# ---- Quantization ----
def quantize_weight(w):
    fp8 = torch.float8_e4m3fn
    fp8_max = torch.finfo(fp8).max
    n, k = w.shape
    wb = w.reshape(n // 128, 128, k // 128, 128).permute(0, 2, 1, 3)
    amax = wb.abs().amax(dim=(-2, -1)).clamp(min=1e-12)
    sc = amax / fp8_max
    wq = (wb / sc[:, :, None, None]).clamp(-fp8_max, fp8_max).to(fp8)
    return wq.permute(0, 2, 1, 3).reshape(n, k), (1.0 / sc).float()


def quantize_activation(x):
    from aiter import QuantType, get_hip_quant
    return get_hip_quant(QuantType.per_1x128)(x.contiguous(), quant_dtype=torch.float8_e4m3fn)


def preshuffle(w_fp8):
    from aiter.ops.shuffle import shuffle_weight
    return shuffle_weight(w_fp8, layout=(16, 16))


# ---- Benchmark ----
def bench():
    from aiter import gemm_a8w8_blockscale

    device = "cuda"

    # Load kernels (keep module refs alive)
    mod32, func32 = _load_kernel("f8_block_scale_mi350_x32.co", "f8_block_scale_mi350_x32")
    mod128, func128 = _load_kernel("f8_block_scale_mi350_x128.co", "f8_block_scale_mi350_x128")

    # Prepare weight (shared across batches)
    w_bf16 = torch.randn(N, K, dtype=torch.bfloat16, device=device)
    w_fp8, w_scale = quantize_weight(w_bf16)
    w_shuf = preshuffle(w_fp8)
    w_scale_t = w_scale.t().contiguous()  # ASM expects [K/128, N/128]

    print(f"o_proj TP=8: weight [{N}, {K}], do_bench median (includes CPU launch overhead)")
    print(f"{'M':>6} | {'CK(us)':>8} | {'ASM(us)':>8} | {'BF16(us)':>8} | {'ASM/CK':>7} | WGs")
    print("-" * 60)

    for M in BATCH_SIZES:
        x = torch.randn(M, K, dtype=torch.bfloat16, device=device)
        xq, xs = quantize_activation(x)
        xst = xs.t().contiguous()  # ASM expects [K/128, M]
        out = torch.zeros(M, N, dtype=torch.bfloat16, device=device)

        func = func32 if M <= 32 else func128
        TileM = 32 if M <= 32 else 128
        gdx = (N + 255) // 256
        gdy = (M + TileM - 1) // TileM

        # Build persistent launcher
        args_buf = _pack_args(out, xq, w_shuf, xst, w_scale_t, M)
        AB = (ctypes.c_char * 368).from_buffer_copy(args_buf)
        ASZ = ctypes.c_size_t(368)
        EX = (ctypes.c_void_p * 5)(
            ctypes.c_void_p(1), ctypes.cast(AB, ctypes.c_void_p),
            ctypes.c_void_p(2), ctypes.cast(ctypes.pointer(ASZ), ctypes.c_void_p),
            ctypes.c_void_p(3),
        )
        EXP = ctypes.cast(EX, ctypes.c_void_p)

        def fn_asm(func=func, gdx=gdx, gdy=gdy, EXP=EXP):
            s = ctypes.c_void_p(torch.cuda.current_stream().cuda_stream)
            _hip.hipModuleLaunchKernel(func, gdx, gdy, 1, 256, 1, 1, 0, s, None, EXP)

        def fn_ck():
            gemm_a8w8_blockscale(xq, w_fp8, xs, w_scale, dtype=torch.bfloat16)

        def fn_bf16():
            torch.mm(x, w_bf16.T)

        t_ck = triton.testing.do_bench(fn_ck, warmup=WARMUP, rep=REP, return_mode="median") * 1000
        t_asm = triton.testing.do_bench(fn_asm, warmup=WARMUP, rep=REP, return_mode="median") * 1000
        t_bf16 = triton.testing.do_bench(fn_bf16, warmup=WARMUP, rep=REP, return_mode="median") * 1000

        ratio = t_asm / t_ck
        print(f"{M:>6} | {t_ck:>7.1f}  | {t_asm:>7.1f}  | {t_bf16:>7.1f}  | {ratio:>6.2f}x | {gdx * gdy}")


if __name__ == "__main__":
    bench()
