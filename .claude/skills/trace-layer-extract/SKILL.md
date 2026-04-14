---
name: trace-layer-extract
description: Extract per-layer kernel sequence from ATOM level=3 traces
user-invocable: true
---

# Trace Layer Extract Skill

从 ATOM level=3 (CUDA graph) 运行时 trace 中提取 per-decode-layer kernel 序列和统计数据。

## When to use

用户想看 decode 单层的 kernel 序列、对比不同 TP/量化配置下的 per-layer 耗时、做 kernel-level 优化分析。

## Script

`bench_serving/2_trace_layer.py` — reusable CLI tool.

```bash
# Basic usage — auto-detects decode bs, auto-saves conc{bs}_layer.csv
python bench_serving/2_trace_layer.py <trace.json.gz>

# With explicit CSV path — auto-prepends conc{bs}_ to filename
python bench_serving/2_trace_layer.py <trace.json.gz> --csv output.csv
# → saves as conc32_output.csv (if dominant bs=32)

# Custom PA pattern (e.g. for FlashAttn models)
python bench_serving/2_trace_layer.py <trace.json.gz> --pa-pattern fmha_fwd
```

## How It Works

1. Load all GPU kernel events from trace, sort by timestamp
2. Detect dominant decode batch size from `decode[bs=N]` annotations
3. Find PA kernel indices as layer boundaries (PA appears once per layer)
4. Determine dominant gap (kernels per layer) via `Counter.most_common`
5. Keep only layers matching dominant gap (filters out prefill, ramp-up/down)
6. Compute per-position avg/std/min/max across all matched layers
7. Auto-prefix CSV filename with `conc{dominant_bs}_`

## 方法: PA-to-PA 切分

Paged Attention kernel (`pa_bf16_pertokenFp8_gqa8`) 每层恰好出现一次，作为 layer boundary anchor。

## Example Output

```
Pos  Kernel                           Avg(us)     Std     Min       Max      %      N
-------------------------------------------------------------------------------------
  0  PA (paged_attn)                     14.6     0.8    10.9      18.2   3.5%   2501
  1  FP8_quant                            5.5     0.5     4.4       7.8   1.3%   2501
  2  GEMM_FP8 (CK dense)                 16.1     0.5    14.9      18.8   3.9%   2501
  ...
 10  MoE_GEMM (CK)                      180.4    16.3   117.8     231.2  43.9%   2501
 12  MoE_GEMM (CK)                       88.5     8.4     5.3     112.8  21.5%   2501
  ...
-------------------------------------------------------------------------------------
     TOTAL per layer                    411.0 us
     x62 layers                         25.48 ms
```

## 注意事项

- rocprofiler 需 ~2s warmup，前几秒 trace 里无 GPU kernel → 用 `--num-prompts-mul 5+` 确保足够 steady-state 数据
- Trace 里的 GPU kernel 和 CPU annotation 在不同 PID，不能直接用时间戳关联
- 前几层和最后几层可能有非标准 kernel 数 (首尾效应)，用 dominant_gap 自动过滤
- 通信 kernel 波动最大 (max/med ~1.7x)，计算 kernel 很稳定 (max/med ~1.1x)
