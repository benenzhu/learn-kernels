---
name: kernel-microbench
description: Single GPU kernel micro-benchmark with roofline analysis
user-invocable: true
---

# Kernel Micro-Benchmark Skill

针对单个 GPU kernel 写独立 benchmark，找出最优实现。

## When to use

用户想对比某个 kernel 的不同实现 (rocBLAS vs CK vs Triton)，或 tune 某个 kernel 的 tile config。

## aiter Kernel API 速查

### GEMM

```python
# BF16 GEMM (rocBLAS)
torch.mm(x, w)                    # [M,K] × [K,N] → [M,N]
torch.nn.functional.linear(x, w)  # [M,K] × [N,K]^T → [M,N]

# FP8 Block-Scale GEMM (CK)
from aiter import gemm_a8w8_blockscale
y = gemm_a8w8_blockscale(xq, wq, x_scale, w_scale, dtype=torch.bfloat16)

# FP8 Quant
from aiter import QuantType, get_hip_quant
quant_fn = get_hip_quant(QuantType.per_1x128)
xq, x_scale = quant_fn(x_bf16, quant_dtype=torch.float8_e4m3fn)

# Triton BF16 GEMM (with split-K)
from aiter.ops.triton.gemm.basic.gemm_a16w16 import gemm_a16w16
y = gemm_a16w16(x, w, dtype=torch.bfloat16, config={
    "BLOCK_SIZE_M": 16, "BLOCK_SIZE_N": 16, "BLOCK_SIZE_K": 256,
    "GROUP_SIZE_M": 1, "NUM_KSPLIT": 1, "SPLITK_BLOCK_SIZE": 3072,
    "num_warps": 4, "num_stages": 2, "cache_modifier": "",
})

# MXFP4 GEMM
from aiter.ops.triton.gemm.basic.gemm_afp4wfp4 import gemm_afp4wfp4
from op_tests.triton_tests.gemm.basic.test_gemm_afp4wfp4 import generate_gemm_afp4wfp4_inputs
```

### MoE

```python
# MXFP4 MoE
from aiter.ops.triton.moe.moe_op_mxfp4 import fused_moe_mxfp4
from aiter.ops.triton.moe.moe_op_mxfp4_silu_fused import fused_moe_mxfp4_silu
from op_tests.triton_tests.moe.test_moe_mx import input_helper

# 生成测试输入
(a, b, c, c_silu, a_scale, b_scale, a_mx, b_mx,
 topk_w, topk_ids, sorted_ids, expert_ids, ntp, top_k, config
) = input_helper(M, N, K, top_k, E, "mxfp4_e2m1", "mxfp4_e2m1")
```

### Quant

```python
# MXFP4 dynamic quant (参考实现)
from op_tests.triton_tests.moe.test_moe_mx import torch_dynamic_mxfp4_quant
x_fp4, x_scale = torch_dynamic_mxfp4_quant(x_bf16)
```

## Benchmark 模板

```python
import torch, triton
NUM_INPUTS = 100

def bench_graph(fn_factory):
    fn = fn_factory()
    for _ in range(3): fn()
    torch.cuda.synchronize()
    stream = torch.cuda.Stream()
    with torch.cuda.stream(stream):
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            for _ in range(NUM_INPUTS): fn()
    torch.cuda.synchronize()
    ms = triton.testing.do_bench(graph.replay, warmup=25, rep=100)
    return ms / NUM_INPUTS * 1000  # us

def bench_dobench(fn):
    return triton.testing.do_bench(fn, warmup=25, rep=100) * 1000  # us
```

## Roofline 分析模板

```python
total_bytes = M * K * 2 + K * N * 2 + M * N * 2  # BF16
flops = 2 * M * N * K
ai = flops / total_bytes  # Arithmetic Intensity

# MI355X peaks
HBM_BW = 8e12     # 8 TB/s
FP16_PEAK = 2.6e15 # 2.6 PFLOPS (FP8 更高)

roofline_mem = total_bytes / HBM_BW * 1e6   # us
roofline_compute = flops / FP16_PEAK * 1e6  # us
roofline = max(roofline_mem, roofline_compute)
```

## 常见 Shape 分析模式

| Shape 特点 | 瓶颈 | 优化方向 |
|-----------|------|---------|
| M=1, N 小 (如 256) | Launch-bound, 固定开销 ~6us | Fusion, 合并多个小 kernel |
| M=1, N 大 (如 3072) | Memory-bound | Split-K 无效, 优化 BW |
| M 大, N 大, K 大 | Compute-bound | Tile tuning, MFMA 利用率 |
| M=1, K 大, N 小 | K 方向并行度不够 | Split-K 可能有效 (但 N 太小时无效) |

## Split-K 何时有用

- **有用**: M 小, N 中等 (≥512), K 很大 — tile 数不够填满 GPU
- **无用**: N 很小 (如 256) — split-K 增加的 reduce 开销 > 并行收益
- **无用**: M 大 — M 方向已有足够 tile

## CK Tuned Config 检查

```python
# CK gemm 会查找 tuned config CSV
# 如果 log 显示 "not found tuned config"，说明该 shape 用了 default config
# 这通常意味着性能还有 20-50% 优化空间
# Config 文件: /app/aiter-test/aiter/configs/a8w8_blockscale_tuned_gemm.csv
```
