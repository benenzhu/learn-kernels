#!/usr/bin/env python3
"""
Benchmark all-reduce latency: aiter vs vllm 1stage/2stage.
Two reduce patterns from MiniMax-M2.5:
  - f32: QK variance, shape (tokens, 2), float32
  - bf16: o_proj / MoE output, shape (tokens, 3072), bfloat16
Sweep tokens: 4, 8, 16, ..., 16384 (power of 2)

Uses CUDA Graph capture & replay for timing.

Usage:
    torchrun --nproc_per_node=8 bench_allreduce.py
"""

import time
import os

import torch
import torch.distributed as dist
from contextlib import nullcontext

HIDDEN_SIZE = 3072
GRAPH_CYCLES = 20
NUM_WARMUP = 10
NUM_TRIALS = 200


def format_bytes(b):
    if b < 1024:
        return f"{b}B"
    elif b < 1024 * 1024:
        return f"{b / 1024:.1f}K"
    return f"{b / 1024 / 1024:.1f}M"


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
    start = time.perf_counter()
    oneM = 1024 * 1024
    if tensor.numel() > oneM:
        global NUM_TRIALS
        NUM_TRIALS = 50
        if tensor.numel() > 2 * oneM: 
            NUM_TRIALS = 25
    for _ in range(NUM_TRIALS):
        graph.replay()
    torch.cuda.synchronize()
    return (time.perf_counter() - start) / NUM_TRIALS / GRAPH_CYCLES * 1e6


def main():
    if not dist.is_initialized():
        dist.init_process_group(backend="gloo")
    rank = dist.get_rank()
    world_size = dist.get_world_size()
    device = torch.device(f"cuda:{rank}")
    torch.cuda.set_device(device)
    cpu_group = dist.new_group(backend="gloo")

    # tokens: 4, 8, 16, ..., 16384
    token_counts = [1 << i for i in range(2, 15)]  # 4 .. 16384

    # two reduce patterns
    patterns = [
        ("f32",  lambda n: (n, 2),          torch.float32),
        ("bf16", lambda n: (n, HIDDEN_SIZE), torch.bfloat16),
        # ("f32_H", lambda n: (n, HIDDEN_SIZE // 2), torch.float32),
    ]

    # max buffer for communicator init
    max_bytes = max(token_counts) * HIDDEN_SIZE * 2
    max_size = max_bytes * 2 + 4096

    # init communicators
    aiter_comm = None
    try:
        from aiter.dist.device_communicators.custom_all_reduce import CustomAllreduce as AiterAR
        aiter_comm = AiterAR(group=cpu_group, device=device, max_size=max_size)
        if aiter_comm.disabled:
            aiter_comm = None
    except Exception as e:
        if rank == 0: print(f"  [aiter] init failed: {e}")

    vllm_comm = None
    try:
        from vllm.distributed.device_communicators.custom_all_reduce import CustomAllreduce as VllmAR
        vllm_comm = VllmAR(group=cpu_group, device=device, max_size=max_size)
        if vllm_comm.disabled:
            vllm_comm = None
    except Exception as e:
        if rank == 0: print(f"  [vllm] init failed: {e}")

    dev_comm = None
    try:
        import sys
        sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
        from custom_ar_dev import CustomAllreduce as DevAR
        dev_comm = DevAR(group=cpu_group, device=device, max_size=max_size)
        if dev_comm.disabled:
            dev_comm = None
    except Exception as e:
        if rank == 0: print(f"  [dev] init failed: {e}")

    if rank == 0:
        print(f"aiter: {'OK' if aiter_comm else 'DISABLED'}, "
              f"vllm: {'OK' if vllm_comm else 'DISABLED'}, "
              f"dev: {'OK' if dev_comm else 'DISABLED'}\n")

    # backend configs: (name, comm, fn, should_fn, env)
    backends = []
    if aiter_comm:
        c = aiter_comm
        backends.append(("aiter", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t), {}))
    if vllm_comm:
        c = vllm_comm
        backends.append(("vllm_1s", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t),
            {"VLLM_CUSTOM_ALLREDUCE_ALGO": "1stage"}))
        backends.append(("vllm_2s", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t),
            {"VLLM_CUSTOM_ALLREDUCE_ALGO": "2stage"}))
    if dev_comm:
        c = dev_comm
        backends.append(("dev", c,
            lambda t, c=c: c.custom_all_reduce(t),
            lambda t, c=c: c.should_custom_ar(t), {}))

    be_names = [n for n, *_ in backends]

    # --- correctness verification (multiple rounds to catch race conditions) ---
    VERIFY_ROUNDS = 50
    verify_sizes = [128, 4096, 512 * 1024]
    n_checks = 0
    if rank == 0:
        print(f"Verifying correctness ({VERIFY_ROUNDS} rounds × "
              f"{len(verify_sizes)} sizes × 2 dtypes)...")
    for round_i in range(VERIFY_ROUNDS):
        for sz in verify_sizes:
            for dtype in [torch.float32, torch.bfloat16]:
                inp = torch.randint(1, 16, (sz,), dtype=dtype, device=device)
                ref = inp.clone()
                dist.all_reduce(ref)
                for name, comm, fn, should_fn, env in backends:
                    saved = {k: os.environ.get(k) for k in env}
                    for k, v in env.items():
                        os.environ[k] = v
                    try:
                        test_inp = inp.clone()
                        if should_fn(test_inp):
                            out = fn(test_inp)
                            if out is not None:
                                try:
                                    torch.testing.assert_close(
                                        out, ref, rtol=0, atol=0)
                                except AssertionError as e:
                                    print(f"FAIL: {name} round={round_i} "
                                          f"sz={sz} dtype={dtype}\n{e}")
                                    raise
                                n_checks += 1
                    finally:
                        for k, orig in saved.items():
                            if orig is None: os.environ.pop(k, None)
                            else: os.environ[k] = orig
    if rank == 0:
        print(f"All verified OK ({n_checks} checks passed).\n")

    # --- benchmark ---

    for pat_name, shape_fn, dtype in patterns:
        if rank == 0:
            print(f"{'='*100}")
            print(f"Pattern: {pat_name} | dtype={dtype} | shape=(tokens, {shape_fn(1)[1]})")
            print(f"{'='*100}")
            header = f"{'tokens':>8} {'shape':>16} {'size':>8}"
            for n in be_names:
                header += f" {n+'/us':>10} {n+'/bw':>10} {'':>5}"
            print(header)
            print("-" * len(header))

        for ntok in token_counts:
            shape = shape_fn(ntok)
            tensor = torch.randn(shape, dtype=dtype, device=device)
            data_bytes = tensor.numel() * tensor.element_size()
            ar_data = 2.0 * (world_size - 1) / world_size * data_bytes

            results = {}  # name -> (lat, bw)
            USE_PROF = os.environ.get("ZZ_PERF", "")
            if USE_PROF and rank == 0:
                trace_dir = f"./GRAPH_CAP"
                profiler = torch.profiler.profile(
                            activities=[
                                torch.profiler.ProfilerActivity.CPU,
                                torch.profiler.ProfilerActivity.CUDA,
                            ],
                            record_shapes=True,
                            profile_memory=True,
                            with_stack=True,
                            on_trace_ready=torch.profiler.tensorboard_trace_handler(
                                trace_dir, worker_name=f"benchmark_{pat_name}_{dtype}_{ntok}", use_gzip=True
                            ),
                        )
            else:
                profiler = nullcontext()
            with profiler:
                for name, comm, fn, should_fn, env in backends:
                    saved = {k: os.environ.get(k) for k in env}
                    for k, v in env.items():
                        os.environ[k] = v
                    try:
                        lat = benchmark_single(fn, should_fn, comm, tensor)
                    finally:
                        for k, orig in saved.items():
                            if orig is None: os.environ.pop(k, None)
                            else: os.environ[k] = orig
                    if lat is not None:
                        bw = ar_data / (lat * 1e-6) / 1e9 if lat > 0 else 0
                        results[name] = (lat, bw)

            if rank == 0:
                # find best (lowest latency)
                best_name = min(results, key=lambda n: results[n][0]) if results else None
                best_lat = results[best_name][0] if best_name else 0

                row = f"{ntok:>8} {str(shape):>16} {format_bytes(data_bytes):>8}"
                for name, *_ in backends:
                    if name in results:
                        lat, bw = results[name]
                        pct = best_lat / lat * 100 if lat > 0 else 0
                        tag = "*" if name == best_name else f"{pct:.0f}%"
                        lat_s = f"{lat:.1f}u"
                        bw_s = f"{bw:.1f}G"
                        row += f" {lat_s:>10} {bw_s:>10} {tag:>5}"
                    else:
                        row += f" {'N/A':>10} {'N/A':>10} {'':>5}"
                print(row)

        if rank == 0:
            print()

    if aiter_comm: aiter_comm.close()
    if vllm_comm: vllm_comm.close()
    if dev_comm: dev_comm.close()
    dist.destroy_process_group()


if __name__ == "__main__":
    main()
