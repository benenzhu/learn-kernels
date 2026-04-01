#!/usr/bin/env python3
"""
Sweep block count for custom all-reduce to find optimal config.

Usage:
    torchrun --nproc_per_node=8 sweep_blocks.py [--tokens 256] [--dim 3072] [--dtype bf16]

Sweeps VLLM_CUSTOM_AR_BLOCKS over powers of 2 and some intermediate values.
Tests both 1-stage and 2-stage algorithms for each block count.
"""

import argparse
import os
import time

import torch
import torch.distributed as dist

GRAPH_CYCLES = 20
NUM_WARMUP = 10
NUM_TRIALS = 200


def benchmark_single(allreduce_fn, should_use_fn, comm, tensor):
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
                for _ in range(GRAPH_CYCLES):
                    allreduce_fn(graph_input)
    torch.cuda.synchronize()
    for _ in range(NUM_WARMUP):
        graph.replay()
    torch.cuda.synchronize()

    trials = NUM_TRIALS
    nbytes = tensor.numel() * tensor.element_size()
    if nbytes > 2 * 1024 * 1024:
        trials = 25
    elif nbytes > 1024 * 1024:
        trials = 50

    start = time.perf_counter()
    for _ in range(trials):
        graph.replay()
    torch.cuda.synchronize()
    return (time.perf_counter() - start) / trials / GRAPH_CYCLES * 1e6


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tokens", type=int, nargs="+",
                        default=[256])
    parser.add_argument("--dim", type=int, default=3072)
    parser.add_argument("--dtype", type=str, default="bf16",
                        choices=["f32", "bf16", "f16"])
    parser.add_argument("--blocks", type=int, nargs="+",
                        default=[1, 2, 4, 8, 12, 16, 24, 32, 48, 64, 96, 128])
    parser.add_argument("--algo", type=str, nargs="+",
                        default=["auto", "1stage", "2stage"],
                        choices=["auto", "1stage", "2stage"])
    args = parser.parse_args()

    dtype_map = {"f32": torch.float32, "bf16": torch.bfloat16, "f16": torch.float16}
    dtype = dtype_map[args.dtype]

    if not dist.is_initialized():
        dist.init_process_group(backend="gloo")
    rank = dist.get_rank()
    world_size = dist.get_world_size()
    device = torch.device(f"cuda:{rank}")
    torch.cuda.set_device(device)
    cpu_group = dist.new_group(backend="gloo")

    max_bytes = max(args.tokens) * args.dim * 4  # f32 worst case
    max_size = max_bytes * 2 + 4096

    # init dev communicator
    import sys
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from custom_ar_dev import CustomAllreduce
    comm = CustomAllreduce(group=cpu_group, device=device, max_size=max_size)
    if comm.disabled:
        if rank == 0:
            print("ERROR: dev communicator disabled")
        return

    for ntok in args.tokens:
        shape = (ntok, args.dim)
        tensor = torch.randn(shape, dtype=dtype, device=device)
        data_bytes = tensor.numel() * tensor.element_size()
        ar_data = 2.0 * (world_size - 1) / world_size * data_bytes

        def fmt_bytes(b):
            if b < 1024: return f"{b}B"
            if b < 1024*1024: return f"{b/1024:.1f}K"
            return f"{b/1024/1024:.1f}M"

        if rank == 0:
            print(f"\n{'='*90}")
            print(f"Shape: {shape} | dtype: {args.dtype} | size: {fmt_bytes(data_bytes)} | TP={world_size}")
            print(f"{'='*90}")
            header = f"{'blocks':>8}"
            for algo in args.algo:
                header += f" {algo+'/us':>12} {algo+'/bw':>10}"
            header += f" {'best':>8}"
            print(header)
            print("-" * len(header))

        for nblocks in args.blocks:
            os.environ["VLLM_CUSTOM_AR_BLOCKS"] = str(nblocks)

            results = {}
            for algo in args.algo:
                if algo == "auto":
                    os.environ.pop("VLLM_CUSTOM_ALLREDUCE_ALGO", None)
                else:
                    os.environ["VLLM_CUSTOM_ALLREDUCE_ALGO"] = algo

                fn = lambda t, c=comm: c.custom_all_reduce(t)
                should_fn = lambda t, c=comm: c.should_custom_ar(t)
                lat = benchmark_single(fn, should_fn, comm, tensor)
                if lat is not None:
                    bw = ar_data / (lat * 1e-6) / 1e9
                    results[algo] = (lat, bw)

            if rank == 0:
                best_algo = min(results, key=lambda a: results[a][0]) if results else ""
                row = f"{nblocks:>8}"
                for algo in args.algo:
                    if algo in results:
                        lat, bw = results[algo]
                        lat_s = f"{lat:.1f}u"
                        bw_s = f"{bw:.1f}G"
                        row += f" {lat_s:>12} {bw_s:>10}"
                    else:
                        row += f" {'N/A':>12} {'':>10}"
                row += f" {'<- '+best_algo:>8}" if best_algo else ""
                print(row)

        # cleanup env
        os.environ.pop("VLLM_CUSTOM_AR_BLOCKS", None)
        os.environ.pop("VLLM_CUSTOM_ALLREDUCE_ALGO", None)

    comm.close()
    dist.destroy_process_group()


if __name__ == "__main__":
    main()
