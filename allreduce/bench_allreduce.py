#!/usr/bin/env python3
"""
Benchmark all-reduce latency for MiniMax-M2.5 model scenarios.

Model: hidden_size=3072, bf16
Scenarios: conc4 (4 tokens), conc256 (256 tokens), conc16384 (16384 tokens)
Per-layer AR calls: #1 QK-var, #2 o_proj, #3 MoE output

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


def bench_allreduce(tensor: torch.Tensor, warmup: int, trials: int) -> float:
    """Returns average latency in microseconds."""
    # warmup
    for _ in range(warmup):
        dist.all_reduce(tensor)
    torch.cuda.synchronize()

    start = time.perf_counter()
    for _ in range(trials):
        dist.all_reduce(tensor)
    torch.cuda.synchronize()
    elapsed = time.perf_counter() - start
    return elapsed / trials * 1e6  # us


def main():
    dist.init_process_group(backend="nccl")
    rank = dist.get_rank()
    world_size = dist.get_world_size()
    torch.cuda.set_device(rank)
    device = torch.device(f"cuda:{rank}")

    # Scenarios: (name, num_tokens)
    scenarios = [
        ("conc4", 4),
        ("conc256", 256),
        ("conc16384", 16384),
    ]

    # Per-layer AR calls for MiniMax-M2.5:
    #   AR#1: QK variance sync - shape (tokens, 2) float32 (q_var + k_var cat'd)
    #   AR#2: o_proj output    - shape (tokens, 3072) bf16
    #   AR#3: MoE output       - shape (tokens, 3072) bf16
    ar_configs = [
        ("AR#1_QK_var", lambda n: (n, 2), torch.float32),
        ("AR#2_o_proj", lambda n: (n, HIDDEN_SIZE), DTYPE),
        ("AR#3_MoE",    lambda n: (n, HIDDEN_SIZE), DTYPE),
    ]

    if rank == 0:
        print(f"{'='*90}")
        print(f"MiniMax-M2.5 All-Reduce Benchmark | TP={world_size} | "
              f"hidden={HIDDEN_SIZE} | dtype={DTYPE}")
        print(f"warmup={WARMUP}, trials={TRIALS}")
        print(f"{'='*90}")
        header = (f"{'Scenario':<14} {'AR call':<14} {'Shape':<20} "
                  f"{'Size':>10} {'Latency(us)':>12} {'BW(GB/s)':>10}")
        print(header)
        print("-" * len(header))

    for scen_name, num_tokens in scenarios:
        layer_total_us = 0.0
        for ar_name, shape_fn, dtype in ar_configs:
            shape = shape_fn(num_tokens)
            tensor = torch.randn(shape, dtype=dtype, device=device)
            data_bytes = tensor.numel() * tensor.element_size()

            latency_us = bench_allreduce(tensor, WARMUP, TRIALS)
            layer_total_us += latency_us

            # Effective bandwidth: ring AR moves 2*(N-1)/N * data
            ar_data = 2.0 * (world_size - 1) / world_size * data_bytes
            bw_gbs = ar_data / (latency_us * 1e-6) / 1e9 if latency_us > 0 else 0

            if rank == 0:
                size_str = format_bytes(data_bytes)
                print(f"{scen_name:<14} {ar_name:<14} {str(shape):<20} "
                      f"{size_str:>10} {latency_us:>12.1f} {bw_gbs:>10.1f}")

        if rank == 0:
            print(f"{'':>14} {'LAYER TOTAL':<14} {'':20} "
                  f"{'':>10} {layer_total_us:>12.1f}")
            print()

    dist.destroy_process_group()


def format_bytes(b: int) -> str:
    if b < 1024:
        return f"{b}B"
    elif b < 1024 * 1024:
        return f"{b/1024:.1f}KB"
    else:
        return f"{b/1024/1024:.1f}MB"


if __name__ == "__main__":
    main()
