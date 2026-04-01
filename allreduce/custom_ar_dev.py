"""
Standalone custom all-reduce module for development/optimization.
JIT-compiles the kernel from csrc/ and exposes the same CustomAllreduce
class API as vllm.

Usage:
    from custom_ar_dev import CustomAllreduce
    # same API as vllm's CustomAllreduce
"""

import os
import torch
import torch.distributed as dist
from contextlib import contextmanager
from torch.distributed import ProcessGroup
from torch.utils.cpp_extension import load

# ---------------------------------------------------------------------------
# JIT compile the C++ extension
# ---------------------------------------------------------------------------

_CSRC_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "csrc")

_extra_cflags = ["-O3"]
_extra_cuda_cflags = ["-O3", "-std=c++17"]

if torch.version.hip:
    _extra_cuda_cflags += ["-DUSE_ROCM", "-U__CUDA_NO_HALF_CONVERSIONS__"]

_ops = None

def get_ops():
    global _ops
    if _ops is None:
        _ops = load(
            name="custom_all_reduce_dev",
            sources=[os.path.join(_CSRC_DIR, "custom_all_reduce_pybind.cu")],
            extra_cflags=_extra_cflags,
            extra_cuda_cflags=_extra_cuda_cflags,
            extra_include_paths=[_CSRC_DIR],
            build_directory=os.path.join(_CSRC_DIR, "build"),
            verbose=True,
        )
    return _ops


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def is_weak_contiguous(inp: torch.Tensor):
    return inp.is_contiguous() or (
        inp.storage().nbytes() - inp.storage_offset() * inp.element_size()
        == inp.numel() * inp.element_size()
    )


# ---------------------------------------------------------------------------
# CustomAllreduce class (same API as vllm)
# ---------------------------------------------------------------------------

class CustomAllreduce:
    _SUPPORTED_WORLD_SIZES = [2, 4, 6, 8]

    def __init__(
        self,
        group: ProcessGroup,
        device: int | str | torch.device,
        max_size: int = 8192 * 1024,
    ) -> None:
        self._IS_CAPTURING = False
        self.disabled = True

        ops = get_ops()

        self.group = group
        assert dist.get_backend(group) != dist.Backend.NCCL, \
            "CustomAllreduce should be attached to a non-NCCL group."

        rank = dist.get_rank(group=self.group)
        world_size = dist.get_world_size(group=self.group)
        if world_size == 1:
            return
        if world_size not in self._SUPPORTED_WORLD_SIZES:
            print(f"[custom_ar_dev] unsupported world_size={world_size}")
            return

        if isinstance(device, int):
            device = torch.device(f"cuda:{device}")
        elif isinstance(device, str):
            device = torch.device(device)
        self.device = device

        fully_connected = True  # assume XGMI full mesh

        self.disabled = False
        self.meta_ptrs = self._create_shared_buffer(
            ops.meta_size() + max_size, group=group
        )
        self.buffer_ptrs = self._create_shared_buffer(max_size, group=group)
        self.rank_data = torch.empty(
            8 * 1024 * 1024, dtype=torch.uint8, device=self.device
        )
        self.max_size = max_size
        self.rank = rank
        self.world_size = world_size
        self.fully_connected = fully_connected
        self._ptr = ops.init_custom_ar(
            self.meta_ptrs, self.rank_data, rank, self.fully_connected
        )
        ops.register_buffer(self._ptr, self.buffer_ptrs)

    @contextmanager
    def capture(self):
        try:
            self._IS_CAPTURING = True
            yield
        finally:
            self._IS_CAPTURING = False
            if not self.disabled:
                self._register_graph_buffers()

    def _register_graph_buffers(self):
        ops = get_ops()
        handle, offset = ops.get_graph_buffer_ipc_meta(self._ptr)
        all_data = [[None, None] for _ in range(
            dist.get_world_size(group=self.group)
        )]
        all_data[self.rank] = [handle, offset]
        ranks = sorted(dist.get_process_group_ranks(group=self.group))
        for i, r in enumerate(ranks):
            dist.broadcast_object_list(
                all_data[i], src=r, group=self.group, device="cpu"
            )
        handles = [d[0] for d in all_data]
        offsets = [d[1] for d in all_data]
        ops.register_graph_buffers(self._ptr, handles, offsets)

    def should_custom_ar(self, inp: torch.Tensor) -> bool:
        if self.disabled:
            return False
        inp_size = inp.numel() * inp.element_size()
        if inp_size % 16 != 0:
            return False
        if not is_weak_contiguous(inp):
            return False
        if self.world_size == 2 or self.fully_connected:
            return inp_size < self.max_size
        return False

    def all_reduce(
        self, inp: torch.Tensor, *, out: torch.Tensor = None,
        registered: bool = False
    ):
        ops = get_ops()
        if out is None:
            out = torch.empty_like(inp)
        if registered:
            ops.all_reduce(self._ptr, inp, out, 0, 0)
        else:
            ops.all_reduce(
                self._ptr, inp, out,
                self.buffer_ptrs[self.rank], self.max_size
            )
        return out

    def custom_all_reduce(self, input: torch.Tensor):
        if self.disabled or not self.should_custom_ar(input):
            return None
        if self._IS_CAPTURING:
            if torch.cuda.is_current_stream_capturing():
                return self.all_reduce(input, registered=True)
            else:
                return torch.empty_like(input)
        else:
            return self.all_reduce(input, registered=False)

    def close(self):
        if not self.disabled and self._ptr:
            ops = get_ops()
            ops.dispose(self._ptr)
            self._ptr = 0
            self._free_shared_buffer(self.meta_ptrs, rank=self.rank)
            self._free_shared_buffer(self.buffer_ptrs, rank=self.rank)

    def __del__(self):
        self.close()

    @staticmethod
    def _create_shared_buffer(
        size_in_bytes: int, group: ProcessGroup = None
    ) -> list[int]:
        ops = get_ops()
        pointer, handle = ops.allocate_shared_buffer_and_handle(size_in_bytes)
        world_size = dist.get_world_size(group=group)
        rank = dist.get_rank(group=group)
        handles = [None] * world_size
        dist.all_gather_object(handles, handle, group=group)
        pointers = []
        for i, h in enumerate(handles):
            if i == rank:
                pointers.append(pointer)
            else:
                pointers.append(ops.open_mem_handle(h))
        return pointers

    @staticmethod
    def _free_shared_buffer(
        pointers: list[int], rank: int = None,
        group: ProcessGroup = None
    ) -> None:
        if rank is None:
            rank = dist.get_rank(group=group)
        ops = get_ops()
        ops.free_shared_buffer(pointers[rank])
