---
name: atom-serving-bench
description: Launch ATOM server and run throughput benchmark
user-invocable: true
---

# ATOM Serving Benchmark Skill

启动 ATOM server 并跑吞吐 benchmark 的完整流程。

## When to use

用户想对某个模型做吞吐测试、对比不同 TP/EP/量化配置。

## 前置检查

```bash
# 1. 确认 GPU 空闲
rocm-smi | grep VRAM

# 2. 杀残留进程 (ATOM 子进程可能残留占 GPU)
pkill -9 -f "atom.entrypoints" 2>/dev/null
pkill -9 -f "ModelRunner" 2>/dev/null
# 验证: rocm-smi 显示 VRAM% = 0%

# 3. 找模型路径
ls /data/models/minimax/  # HF cache 格式
# 设置: export HF_HOME=/data/models/minimax
```

## 启动 Server

```bash
cd /app/ATOM && HF_HOME=/data/models/minimax AITER_LOG_LEVEL=WARNING \
  python -m atom.entrypoints.openai_server \
    --model <MODEL_NAME> \
    --kv_cache_dtype fp8 \
    -tp <TP_SIZE> \
    --trust-remote-code \
    --max-model-len 16384 \
    --server-port 8002 \        # 注意: 不是 --port (那是内部通信端口)
    [--enable-expert-parallel]   # MoE EP 模式
```

### 关键参数

| 参数 | 说明 |
|------|------|
| `--server-port` | HTTP 服务端口 (默认 8000, 常被占用) |
| `--port` | 内部引擎通信端口 (不是 serving 端口!) |
| `-tp N` | Tensor Parallelism |
| `--enable-expert-parallel` | Expert Parallelism (MoE 用) |
| `--level 0/1/2/3` | 编译级别, 3=CUDA graph (默认) |
| `--max-model-len` | 最大序列长度 |
| `--mark-trace` | profiling 标记 (可能导致 OOM) |

### EP vs 纯 TP

- 纯 TP: 切分每个 expert 的权重 → 可能因 FP8 block 维度不整除而失败
- EP: 分发 experts 到不同 GPU → 没有 all-to-all (只在 DP attention 模式下有)
- EP 下每 GPU 持有 num_experts/tp_size 个完整 expert
- EP routing: `expert_map` 标记本地 expert, 非本地 token 直接 drop

## 跑 Benchmark

```bash
python -m atom.benchmarks.benchmark_serving \
  --model=<MODEL_NAME> --backend=vllm \
  --base-url=http://localhost:8002 \
  --dataset-name=random \
  --random-input-len=8192 --random-output-len=512 \
  --random-range-ratio=0.8 \
  --num-prompts=$((CONC * 10)) \
  --max-concurrency=$CONC \
  --request-rate=inf --ignore-eos \
  --save-result --result-dir=./results \
  --percentile-metrics="ttft,tpot,itl,e2el"
```

## Profiling

```bash
# 方式 1: 启动时指定 profiler dir (可能 OOM for 大模型)
--torch-profiler-dir ./trace --mark-trace

# 方式 2: benchmark 时用 --profile (推荐, 自动 curl start/stop)
--profile --num-prompts=5 --max-concurrency=1

# 方式 3: 手动 curl 控制
curl -X POST http://localhost:8002/start_profile
# 发请求...
curl -X POST http://localhost:8002/stop_profile
```

## Trace 分析

```bash
cd /app/ATOM
python tools/analyze_trace_summary.py ./trace/rank_0/*.json.gz    # 概览
python tools/parse_trace.py ./trace/rank_0/*.json.gz --layer 3    # 按层分析
```

## 常见问题

| 问题 | 解决 |
|------|------|
| 端口被占 | 用 `--server-port 8002` |
| OOM | 减小 `--max-model-len`, 或用更多 TP |
| TP=8 维度不兼容 | 加 `--enable-expert-parallel` |
| mark-trace OOM | 不加 `--mark-trace`, 用 `--profile` 替代 |
| Server 看似启动但 curl 失败 | 检查 log: 可能 warmup 很长 (~2.5 min for MXFP4) |
| GPU 残留进程 | `pkill -9 -f ModelRunner; sleep 5` |

## 结果指标

| 指标 | 说明 |
|------|------|
| Output tok/s | 生成 token 吞吐 |
| Total tok/s | 输入+输出 token 吞吐 |
| tok/s/GPU | 单卡效率 (= total / tp_size) |
| TTFT p50/p99 | 首 token 延迟 |
| TPOT p50/p99 | 每 token 生成延迟 |
| E2EL p50/p99 | 端到端请求延迟 |
