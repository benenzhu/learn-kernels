#!/usr/bin/env python3
"""
Benchmark all-reduce latency for MiniMax-M2.5 model scenarios.

Model: hidden_size=3072, bf16
Scenarios: conc4 (4 tokens), conc256 (256 tokens), conc16384 (16384 tokens)
Per-layer AR calls: #1 QK-var, #2 o_proj, #3 MoE output

Two modes:
  - eager:  wall-clock time (includes CPU launch overhead ~3-5us per op)
  - event:  CUDA event timing (pure GPU time, excludes CPU overhead)

Usage:
    torchrun --nproc_per_node=8 bench_allreduce.py
"""

import time

import torch
import torch.distributed as dist

HIDDEN_SIZE = 3072
DTYPE = torch.bfloat16
WARMUP = 50
TRIALS = 200


def bench_eager(tensor: torch.Tensor, warmup: int, trials: int) -> float:
    """Wall-clock timing (includes CPU launch overhead). Returns avg us."""
    for _ in range(warmup):
        dist.all_reduce(tensor)
    torch.cuda.synchronize()

    start = time.perf_counter()
    for _ in range(trials):
        dist.all_reduce(tensor)
    torch.cuda.synchronize()
    return (time.perf_counter() - start) / trials * 1e6


def bench_event(tensor: torch.Tensor, warmup: int, trials: int) -> float:
    """CUDA event timing (pure GPU time). Returns avg us."""
    for _ in range(warmup):
        dist.all_reduce(tensor)
    torch.cuda.synchronize()

    start_events = [torch.cuda.Event(enable_timing=True) for _ in range(trials)]
    end_events = [torch.cuda.Event(enable_timing=True) for _ in range(trials)]

    for i in range(trials):
        start_events[i].record()
        dist.all_reduce(tensor)
        end_events[i].record()
    torch.cuda.synchronize()

    times = [s.elapsed_time(e) * 1000 for s, e in zip(start_events, end_events)]  # ms -> us
    times.sort()
    # trim top/bottom 10% outliers, take median of the rest
    lo = len(times) // 10
    hi = len(times) - lo
    return sum(times[lo:hi]) / (hi - lo)


def format_bytes(b: int) -> str:
    if b < 1024:
        return f"{b}B"
    elif b < 1024 * 1024:
        return f"{b/1024:.1f}KB"
    else:
        return f"{b/1024/1024:.1f}MB"


def main():
    dist.init_process_group(backend="nccl")
    rank = dist.get_rank()
    world_size = dist.get_world_size()
    torch.cuda.set_device(rank)
    device = torch.device(f"cuda:{rank}")

    scenarios = [
        ("conc4", 4),
        ("conc256", 256),
        ("conc16384", 16384),
    ]

    # Per-layer AR calls for MiniMax-M2.5
    ar_configs = [
        ("AR#1_QK_var", lambda n: (n, 2), torch.float32),
        ("AR#2_o_proj", lambda n: (n, HIDDEN_SIZE), DTYPE),
        ("AR#3_MoE",    lambda n: (n, HIDDEN_SIZE), DTYPE),
    ]

    if rank == 0:
        print(f"{'='*110}")
        print(f"MiniMax-M2.5 All-Reduce Benchmark | TP={world_size} | "
              f"hidden={HIDDEN_SIZE} | dtype={DTYPE}")
        print(f"warmup={WARMUP}, trials={TRIALS}")
        print(f"{'='*110}")
        header = (f"{'Scenario':<12} {'AR call':<14} {'Shape':<18} {'Size':>8}"
                  f" {'Eager(us)':>10} {'Event(us)':>10} {'Diff':>8}"
                  f" {'EagerBW':>9} {'EventBW':>9}")
        print(header)
        print("-" * len(header))

    for scen_name, num_tokens in scenarios:
        eager_total = 0.0
        event_total = 0.0
        for ar_name, shape_fn, dtype in ar_configs:
            shape = shape_fn(num_tokens)
            tensor = torch.randn(shape, dtype=dtype, device=device)
            data_bytes = tensor.numel() * tensor.element_size()
            ar_data = 2.0 * (world_size - 1) / world_size * data_bytes

            lat_eager = bench_eager(tensor, WARMUP, TRIALS)
            lat_event = bench_event(tensor, WARMUP, TRIALS)
            eager_total += lat_eager
            event_total += lat_event

            bw_eager = ar_data / (lat_eager * 1e-6) / 1e9 if lat_eager > 0 else 0
            bw_event = ar_data / (lat_event * 1e-6) / 1e9 if lat_event > 0 else 0
            diff = lat_eager - lat_event

            if rank == 0:
                print(f"{scen_name:<12} {ar_name:<14} {str(shape):<18} "
                      f"{format_bytes(data_bytes):>8}"
                      f" {lat_eager:>10.1f} {lat_event:>10.1f} {diff:>7.1f}u"
                      f" {bw_eager:>8.1f} {bw_event:>8.1f}")

        if rank == 0:
            diff_total = eager_total - event_total
            print(f"{'':>12} {'LAYER TOTAL':<14} {'':18} {'':>8}"
                  f" {eager_total:>10.1f} {event_total:>10.1f} {diff_total:>7.1f}u")
            print()

    dist.destroy_process_group()


if __name__ == "__main__":
    main()
