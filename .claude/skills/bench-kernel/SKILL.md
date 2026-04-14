---
name: bench-kernel
description: CUDA graph replay benchmark + source trace templates
user-invocable: true
---

# Bench Kernel Skill

Kernel 性能分析和源码追踪的详细模板与代码片段。

## CUDA Graph Replay Benchmark 模板

```python
import torch
import triton

NUM_INPUTS = 100
WARMUP = 25
REP = 100

def capture_graph(fn, num_inputs=NUM_INPUTS):
    """Capture CUDA graph over num_inputs calls."""
    # Warmup outside graph (trigger JIT / lazy init)
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
    """Benchmark graph replay, return per-iteration median time in us."""
    def replay():
        graph.replay()
    t_total = triton.testing.do_bench(replay, warmup=WARMUP, rep=REP, return_mode="median")
    return t_total / num_inputs * 1000  # ms -> us per iteration
```

## 普通 do_bench 模板

```python
t = triton.testing.do_bench(fn, warmup=25, rep=100, return_mode="median") * 1000  # us
```

## Profiler 采集模板

```python
with torch.profiler.profile(
    activities=[torch.profiler.ProfilerActivity.CPU, torch.profiler.ProfilerActivity.CUDA],
    record_shapes=True,
) as prof:
    fn()
    torch.cuda.synchronize()
print(prof.key_averages().table(sort_by="cuda_time_total", row_limit=20))
```

## 源码调用链 Markdown 模板

```markdown
# <Kernel Name> Source Trace

## 概述
一句话说明整体流程和关键 shape。

## Path 1: <子流程名>
- [函数名](aiter/ops/quant.py:258)                     # 注释
  - [子函数](aiter/ops/quant.py:413)                    # 注释
    - [更深层](aiter/jit/core.py:968)
      - HIP Kernel ↓

### HIP/CUDA Kernel: `kernel_name`
- 源码位置
- Kernel 参数（BlockSize, tile size 等）
- 核心流程（编号列表）

## Path 2: <另一个子流程>
...

## 完整端到端流程图
用 ASCII 流程图展示数据流转。
```

## CK/CUTLASS Kernel 参数解析

```
a8w8_blockscale_1x128x128_256x16x128x256_16x16_16x16_1x2_...
                │  │   │    │  │   │   │   │  │   │  │  └─ NXdlPerWave
                │  │   │    │  │   │   │   │  │   │  └──── MXdlPerWave
                │  │   │    │  │   │   │   │  │   └─────── NPerXDL
                │  │   │    │  │   │   │   │  └──────────── MPerXDL
                │  │   │    │  │   │   │   └───────────── KPerBlock
                │  │   │    │  │   │   └─────────────────── NPerBlock
                │  │   │    │  │   └───────────────────── MPerBlock
                │  │   │    │  └─────────────────────────── BlockSize
                │  │   │    └──────────────────────────────── Scale_Block_K
                │  │   └──────────────────────────────────── Scale_Block_N
                │  └──────────────────────────────────────── Scale_Block_M (1=per-token)
```
