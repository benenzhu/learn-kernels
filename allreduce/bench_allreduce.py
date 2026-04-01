#!/usr/bin/env python3
"""
Benchmark all-reduce latency: aiter vs vllm custom AR (1stage/2stage).
Flow aligned with vllm/benchmarks/kernels/benchmark_device_communicators.py
Uses CUDA Graph capture & replay for timing.

Usage:
    torchrun --nproc_per_node=8 bench_allreduce.py
"""

import time
import os

import torch
import torch.distributed as dist

HIDDEN_SIZE = 3072
DTYPE = torch.bfloat16
CUDA_GRAPH_CAPTURE_CYCLES = 10
NUM_WARMUP = 5
NUM_TRIALS = 50


def format_bytes(b):
    if b < 1024:
        return f"{b}B"
    elif b < 1024 * 1024:
        return f"{b / 1024:.1f}KB"
    return f"{b / 1024 / 1024:.1f}MB"


def benchmark_single(allreduce_fn, should_use_fn, comm, tensor):
    """Benchmark one communicator with CUDA graph, matching vllm's flow."""
    if not should_use_fn(tensor):
        return None

    torch.cuda.synchronize()
    stream = torch.cuda.Stream()
    with torch.cuda.stream(stream):
        graph_input = tensor.clone()

        for _ in range(3):
            allreduce_fn(graph_input)

        with comm.capture():
            graph = torch.cuda.CUDAGraph()
            with torch.cuda.graph(graph, stream=stream):
                for _ in range(CUDA_GRAPH_CAPTURE_CYCLES):
                    allreduce_fn(graph_input)

    torch.cuda.synchronize()
    for _ in range(NUM_WARMUP):
        graph.replay()
    torch.cuda.synchronize()

    start = time.perf_counter()
    for _ in range(NUM_TRIALS):
        graph.replay()
    torch.cuda.synchronize()
    end = time.perf_counter()

    return (end - start) / NUM_TRIALS / CUDA_GRAPH_CAPTURE_CYCLES * 1e6


def main():
    if not dist.is_initialized():
        dist.init_process_group(backend="gloo")
    rank = dist.get_rank()
    world_size = dist.get_world_size()
    device = torch.device(f"cuda:{rank}")
    torch.cuda.set_device(device)

    cpu_group = dist.new_group(backend="gloo")

    scenarios = [
        ("conc4", 4),
        ("conc256", 256),
        ("conc16384", 16384),
    ]

    ar_configs = [
        ("AR#1_QK_var", lambda n: (n, 2), torch.float32),
        ("AR#2_o_proj", lambda n: (n, HIDDEN_SIZE), DTYPE),
        ("AR#3_MoE",    lambda n: (n, HIDDEN_SIZE), DTYPE),
    ]

    max_tokens = max(n for _, n in scenarios)
    max_bytes = max_tokens * HIDDEN_SIZE * 2
    max_size = max_bytes * 2 + 4096

    # --- init communicators ---
    aiter_comm = None
    try:
        from aiter.dist.device_communicators.custom_all_reduce import CustomAllreduce as AiterAR
        aiter_comm = AiterAR(group=cpu_group, device=device, max_size=max_size)
        if aiter_comm.disabled:
            aiter_comm = None
    except Exception as e:
        if rank == 0:
            print(f"  [aiter] init failed: {e}")

    vllm_comm = None
    try:
        from vllm.distributed.device_communicators.custom_all_reduce import CustomAllreduce as VllmAR
        vllm_comm = VllmAR(group=cpu_group, device=device, max_size=max_size)
        if vllm_comm.disabled:
            vllm_comm = None
    except Exception as e:
        if rank == 0:
            print(f"  [vllm] init failed: {e}")

    if rank == 0:
        print(f"  aiter: {'OK' if aiter_comm else 'DISABLED'}")
        print(f"  vllm:  {'OK' if vllm_comm else 'DISABLED'}")
        print()

    # --- communicator configs ---
    # (name, comm, allreduce_fn, should_use_fn, env_dict)
    configs = []
    if aiter_comm:
        c = aiter_comm
        configs.append((
            "aiter", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t),
            {},
        ))
    if vllm_comm:
        c = vllm_comm
        configs.append((
            "vllm_1stage", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t),
            {"VLLM_CUSTOM_ALLREDUCE_ALGO": "1stage"},
        ))
        configs.append((
            "vllm_2stage", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t),
            {"VLLM_CUSTOM_ALLREDUCE_ALGO": "2stage"},
        ))

    if rank == 0:
        print(f"{'='*110}")
        print(f"All-Reduce Benchmark (CUDA Graph) | TP={world_size} | "
              f"hidden={HIDDEN_SIZE} | graph_cycles={CUDA_GRAPH_CAPTURE_CYCLES}")
        print(f"{'='*110}")
        names = [name for name, *_ in configs]
        header = f"{'Scenario':<12} {'AR call':<14} {'Size':>8}"
        for n in names:
            header += f" {n:>14} {'busbw':>10}"
        print(header)
        print("-" * len(header))

    for scen_name, num_tokens in scenarios:
        totals = {name: 0.0 for name, *_ in configs}

        for ar_name, shape_fn, dtype in ar_configs:
            shape = shape_fn(num_tokens)
            tensor = torch.randn(shape, dtype=dtype, device=device)
            data_bytes = tensor.numel() * tensor.element_size()
            ar_data = 2.0 * (world_size - 1) / world_size * data_bytes

            row = f"{scen_name:<12} {ar_name:<14} {format_bytes(data_bytes):>8}"

            for name, comm, allreduce_fn, should_use_fn, env_dict in configs:
                saved = {k: os.environ.get(k) for k in env_dict}
                for k, v in env_dict.items():
                    os.environ[k] = v
                try:
                    lat = benchmark_single(allreduce_fn, should_use_fn, comm, tensor)
                finally:
                    for k, orig in saved.items():
                        if orig is None:
                            os.environ.pop(k, None)
                        else:
                            os.environ[k] = orig

                if lat is None:
                    row += f" {'N/A':>14} {'':>10}"
                else:
                    totals[name] += lat
                    bw = ar_data / (lat * 1e-6) / 1e9 if lat > 0 else 0
                    row += f" {lat:>13.1f}u {bw:>8.1f}G"

            if rank == 0:
                print(row)

        if rank == 0:
            row = f"{'':>12} {'LAYER TOTAL':<14} {'':>8}"
            for name, *_ in configs:
                v = totals[name]
                row += f" {v:>13.1f}u {'':>10}"
            print(row)
            print()

    if aiter_comm:
        aiter_comm.close()
    if vllm_comm:
        vllm_comm.close()
    dist.destroy_process_group()


if __name__ == "__main__":
    main()
