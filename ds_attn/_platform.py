"""Platform detection helpers extracted from sglang.srt.utils."""
from functools import lru_cache

import torch


@lru_cache(maxsize=1)
def is_hip() -> bool:
    return torch.version.hip is not None


@lru_cache(maxsize=1)
def is_fp8_fnuz() -> bool:
    if is_hip():
        return "gfx94" in torch.cuda.get_device_properties(0).gcnArchName
    return False


@lru_cache(maxsize=1)
def is_gfx95_supported() -> bool:
    if is_hip():
        return "gfx95" in torch.cuda.get_device_properties(0).gcnArchName
    return False
