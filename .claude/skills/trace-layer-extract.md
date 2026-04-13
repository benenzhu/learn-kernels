# Trace Layer Extract Skill

从 ATOM level=3 (CUDA graph) 运行时 trace 中提取 per-decode-layer kernel 序列和统计数据。

## When to use

用户想看 decode 单层的 kernel 序列、对比不同 TP/量化配置下的 per-layer 耗时、做 kernel-level 优化分析。

## 方法: PA-to-PA 切分

Paged Attention kernel (`pa_bf16_pertokenFp8_gqa8`) 每层恰好出现一次，作为 layer boundary anchor。

## 提取脚本

```python
import json, gzip, statistics
from collections import defaultdict, Counter

def extract_layer_kernels(trace_path):
    with gzip.open(trace_path, 'rt') as f:
        data = json.load(f)

    gpu_kernels = [(ev['ts'], ev['dur'], ev['name'])
                   for ev in data['traceEvents'] if ev.get('cat') == 'kernel']
    gpu_kernels.sort()
    names = [n for _,_,n in gpu_kernels]

    # Find PA positions
    pa_idx = [i for i, n in enumerate(names) if 'pa_bf16' in n]

    # Dominant gap = kernels per layer
    gaps = [pa_idx[i+1]-pa_idx[i] for i in range(len(pa_idx)-1)]
    dominant_gap = Counter(gaps).most_common(1)[0][0]

    # Extract standard layers (matching dominant gap)
    layers = []
    for i in range(len(pa_idx)-1):
        s, e = pa_idx[i], pa_idx[i+1]
        if e - s == dominant_gap:
            layers.append([(dur, name) for _, dur, name in gpu_kernels[s:e]])

    # Compute stats per kernel position
    results = []
    for pos in range(dominant_gap):
        durs = [l[pos][0] for l in layers]
        name = layers[0][pos][1]
        results.append({
            'pos': pos, 'name': name,
            'min': min(durs), 'median': statistics.median(durs),
            'mean': statistics.mean(durs), 'max': max(durs),
        })

    return results, len(layers), dominant_gap
```

## 输出格式

```
Pos     Min     Med    Mean     Max  Kernel
[0]    38.2    40.5    40.7    44.0  pa_bf16_pertokenFp8_gqa8_2tg_4w
[1]     4.2     5.0     5.2     7.4  dynamic_per_group_scaled_quant
...
                       226.3  TOTAL per layer
                       14.03  × 62 layers (ms)
```

## 适用场景

- level=3 CUDA graph 的运行时 trace (不是 capture_graph trace)
- Decode 阶段 (prefill 不是固定模式)
- 需要运行 profiling benchmark 先:
  ```bash
  python -m atom.benchmarks.benchmark_serving \
    --num-prompts=5 --max-concurrency=1 --profile
  ```

## 注意事项

- Trace 里的 GPU kernel 和 CPU annotation 在不同 PID，不能直接用时间戳关联
- 前几层和最后几层可能有非标准 kernel 数 (首尾效应)，用 dominant_gap 过滤
- 通信 kernel 波动最大 (max/med ~1.7x)，计算 kernel 很稳定 (max/med ~1.1x)
