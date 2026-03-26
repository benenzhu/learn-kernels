"""
Single-run FP8 Block-Scale GEMM for profiling.
Usage:
  python profile_fp8_gemm.py                # PyTorch profiler
  rocprof python profile_fp8_gemm.py        # rocprof
"""

import torch
from test_fp8_gemm import quantize_activation_per_1x128, quantize_weight_per_128x128

N, K = 3072, 768
M = 4  # batch_size

device = "cuda"
from aiter import gemm_a8w8_blockscale

# Prepare data
input_bf16 = torch.randn(M, K, dtype=torch.bfloat16, device=device)
weight_bf16 = torch.randn(N, K, dtype=torch.bfloat16, device=device)
w_fp8, w_scale = quantize_weight_per_128x128(weight_bf16)

# Warmup
for _ in range(3):
    a_q, a_s = quantize_activation_per_1x128(input_bf16)
    out = gemm_a8w8_blockscale(a_q, w_fp8, a_s, w_scale, dtype=torch.bfloat16)
torch.cuda.synchronize()

# Profile
with torch.profiler.profile(
    activities=[torch.profiler.ProfilerActivity.CPU, torch.profiler.ProfilerActivity.CUDA],
    record_shapes=True,
) as prof:
    a_q, a_s = quantize_activation_per_1x128(input_bf16)
    out = gemm_a8w8_blockscale(a_q, w_fp8, a_s, w_scale, dtype=torch.bfloat16)
    torch.cuda.synchronize()

print(prof.key_averages().table(sort_by="cuda_time_total", row_limit=20))
