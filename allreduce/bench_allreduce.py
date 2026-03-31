#!/usr/bin/env python3
"""
Benchmark all-reduce latency: torch (NCCL) vs aiter vs vllm custom AR.

Model: MiniMax-M2.5, hidden_size=3072, bf16
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


# ---------------------------------------------------------------------------
# Timing helpers
# ---------------------------------------------------------------------------

def bench_eager(fn, warmup, trials):
    """Wall-clock timing. Returns avg latency in us."""
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()
    start = time.perf_counter()
    for _ in range(trials):
        fn()
    torch.cuda.synchronize()
    return (time.perf_counter() - start) / trials * 1e6


def bench_event(fn, warmup, trials):
    """CUDA event timing (pure GPU). Returns avg latency in us."""
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()
    starts = [torch.cuda.Event(enable_timing=True) for _ in range(trials)]
    ends = [torch.cuda.Event(enable_timing=True) for _ in range(trials)]
    for i in range(trials):
        starts[i].record()
        fn()
        ends[i].record()
    torch.cuda.synchronize()
    times = sorted(s.elapsed_time(e) * 1000 for s, e in zip(starts, ends))
    lo, hi = len(times) // 10, len(times) - len(times) // 10
    return sum(times[lo:hi]) / (hi - lo)


def format_bytes(b):
    if b < 1024:
        return f"{b}B"
    elif b < 1024 * 1024:
        return f"{b / 1024:.1f}KB"
    return f"{b / 1024 / 1024:.1f}MB"


# ---------------------------------------------------------------------------
# Init communicators
# ---------------------------------------------------------------------------

def init_aiter_custom_ar(gloo_group, device, max_size):
    """Init aiter CustomAllreduce. Returns (comm, name) or None."""
    try:
        from aiter.dist.device_communicators.custom_all_reduce import CustomAllreduce
        comm = CustomAllreduce(group=gloo_group, device=device, max_size=max_size)
        if comm.disabled:
            return None
        return comm
    except Exception as e:
        print(f"  [aiter] init failed: {e}")
        return None


def init_vllm_custom_ar(gloo_group, device, max_size):
    """Init vllm CustomAllreduce. Returns comm or None."""
    try:
        from vllm.distributed.device_communicators.custom_all_reduce import CustomAllreduce
        comm = CustomAllreduce(group=gloo_group, device=device, max_size=max_size)
        if comm.disabled:
            return None
        return comm
    except Exception as e:
        print(f"  [vllm] init failed: {e}")
        return None


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    dist.init_process_group(backend="nccl")
    rank = dist.get_rank()
    world_size = dist.get_world_size()
    torch.cuda.set_device(rank)
    device = torch.device(f"cuda:{rank}")

    # gloo group needed for custom AR IPC exchange
    gloo_group = dist.new_group(backend="gloo")

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

    # Compute max buffer size needed
    max_tokens = max(n for _, n in scenarios)
    max_bytes = max_tokens * HIDDEN_SIZE * 2  # bf16
    max_size = max_bytes * 2 + 4096  # 2x for 2-stage + margin

    # Init custom AR communicators
    if rank == 0:
        print("Initializing communicators...")
    aiter_comm = init_aiter_custom_ar(gloo_group, device, max_size)
    vllm_comm = init_vllm_custom_ar(gloo_group, device, max_size)

    if rank == 0:
        print(f"  torch/NCCL: OK")
        print(f"  aiter custom AR: {'OK' if aiter_comm else 'DISABLED'}")
        print(f"  vllm custom AR:  {'OK' if vllm_comm else 'DISABLED'}")
        print()

    # Build list of backends to test
    backends = []

    # 1) torch NCCL
    def make_nccl_fn(t):
        def fn():
            dist.all_reduce(t)
        return fn
    backends.append(("nccl", make_nccl_fn, None))

    # 2) aiter custom AR
    if aiter_comm:
        def make_aiter_fn(t, comm=aiter_comm):
            out = torch.empty_like(t)
            def fn():
                comm.all_reduce(t, out=out)
            return fn
        backends.append(("aiter", make_aiter_fn, aiter_comm))

    # 3) vllm custom AR
    if vllm_comm:
        def make_vllm_fn(t, comm=vllm_comm):
            def fn():
                comm.all_reduce(t)
            return fn
        backends.append(("vllm", make_vllm_fn, vllm_comm))

    # Print header
    if rank == 0:
        print(f"{'='*120}")
        print(f"MiniMax-M2.5 All-Reduce Benchmark | TP={world_size} | "
              f"hidden={HIDDEN_SIZE} | dtype={DTYPE}")
        print(f"warmup={WARMUP}, trials={TRIALS}")
        print(f"{'='*120}")

        be_names = [name for name, _, _ in backends]
        header = f"{'Scenario':<12} {'AR call':<14} {'Size':>8}"
        for name in be_names:
            header += f" {name+'/eager':>12} {name+'/event':>12}"
        print(header)
        print("-" * len(header))

    # Run benchmarks
    for scen_name, num_tokens in scenarios:
        totals_eager = {name: 0.0 for name, _, _ in backends}
        totals_event = {name: 0.0 for name, _, _ in backends}

        for ar_name, shape_fn, dtype in ar_configs:
            shape = shape_fn(num_tokens)
            tensor = torch.randn(shape, dtype=dtype, device=device)
            data_bytes = tensor.numel() * tensor.element_size()

            row = f"{scen_name:<12} {ar_name:<14} {format_bytes(data_bytes):>8}"

            for name, make_fn, comm in backends:
                # Check if custom AR supports this size
                skip = False
                if comm is not None:
                    if hasattr(comm, 'should_custom_ar') and not comm.should_custom_ar(tensor):
                        skip = True

                if skip:
                    row += f" {'N/A':>12} {'N/A':>12}"
                else:
                    fn = make_fn(tensor)
                    lat_eager = bench_eager(fn, WARMUP, TRIALS)
                    lat_event = bench_event(fn, WARMUP, TRIALS)
                    totals_eager[name] += lat_eager
                    totals_event[name] += lat_event
                    row += f" {lat_eager:>11.1f}u {lat_event:>11.1f}u"

            if rank == 0:
                print(row)

        # Print layer totals
        if rank == 0:
            row = f"{'':>12} {'LAYER TOTAL':<14} {'':>8}"
            for name, _, _ in backends:
                e, v = totals_eager[name], totals_event[name]
                if e > 0:
                    row += f" {e:>11.1f}u {v:>11.1f}u"
                else:
                    row += f" {'N/A':>12} {'N/A':>12}"
            print(row)
            print()

    # Cleanup
    if aiter_comm:
        aiter_comm.close()
    if vllm_comm:
        vllm_comm.close()
    dist.destroy_process_group()


if __name__ == "__main__":
    main()
