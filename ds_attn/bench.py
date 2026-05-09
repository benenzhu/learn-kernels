"""
Standalone microbenchmark for `dpsk_v4_fp8_attention_fwd` on DSV4-Pro under
DP-attention (num_heads=128 per rank). No sglang dependency — only torch +
tilelang are required.

Sweeps:
  - prefill: chunk = 1024 q-tokens; context seqlen ∈ {1024, 2048, 4096, 8192}
  - decode : conc ∈ {2, 4, 8, 16, 32}; context seqlen = 8192 + 1024
  - both swept across compress = {c4, c128}

Reference (C4 prefill@8192) [dsv4_attn_plan]:
    q_shape=(8192, 1, 128, 512)   has_extra=True
    seq=16384  block_I=64  threads=512
    topk1=128  ni_1=2  inner_iter_1=2
    topk2=512  ni_2=8  inner_iter_2=8
    n_groups=2  bs_kv_1=128  bs_kv_2=64

Run as:
    python bench.py            # full sweep
    python bench.py c          # purge tilelang JIT cache first
    pytest -s bench.py         # smoke + parametrized perf
"""

from __future__ import annotations

import os
import sys
from dataclasses import dataclass
from typing import Any, Dict, Literal

# Make sibling files importable when launched from anywhere.
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

if "c" in sys.argv:
    os.system("rm -rf ~/.tilelang")
    os.system("rm tmp*")

import pytest
import torch

import flashmla_quant
from tilelang_kernel import dpsk_v4_fp8_attention_fwd

# ---------------------------------------------------------------------------
# Model / backend constants (DSV4-Pro, compressed backend, gfx950)
# ---------------------------------------------------------------------------
NUM_HEADS = 128                  # DP-attention → full heads per rank
DIM = 448
TAIL_DIM = 64
HEAD_DIM = DIM + TAIL_DIM        # 512

PAGE_SIZE = 256                  # backend forces page_size=256
SWA_BLOCK_SIZE = 128             # = config.sliding_window
SWA_TOPK = 128                   # window fully covered → topk1 = window
C4_SPARSE_TOPK = 512             # fixed by C4_TOPK in deepseek_v4_backend.py
ALIGN = 64                       # gfx950 block_I = PAGE_INDEX_ALIGNED_SIZE

C4_BLOCK_SIZE = PAGE_SIZE // 4   # 64 entries per block, 4 src-tokens/entry
C128_BLOCK_SIZE = PAGE_SIZE // 128  # 2 entries per block, 128 src-tokens/entry

# ---------------------------------------------------------------------------
# Sweep configurations
# ---------------------------------------------------------------------------
PREFILL_CHUNK = 1024
PREFILL_SEQLENS = [1024, 2048, 4096, 8192]
DECODE_CONCS = [2, 4, 8, 16, 32]
DECODE_SEQLEN = 8192 + 1024
# c128 decode capture pads indices so that 128 entries × 128 src/entry = 16384
DECODE_C128_TOPK_PAD = 128

FP8_LAYOUT = flashmla_quant.FP8KVCacheLayout.MODEL1_FP8Sparse


def _round_up(x: int, m: int) -> int:
    return ((x + m - 1) // m) * m


@dataclass(frozen=True)
class AttnCfg:
    compress: Literal["c4", "c128"]
    seqlen: int                  # context length (KV side)
    q_tokens: int                # # of q tokens fed to the kernel
    is_decode: bool = False      # affects c128 padding (capture-time worst case)

    @property
    def extra_block_size(self) -> int:
        return C4_BLOCK_SIZE if self.compress == "c4" else C128_BLOCK_SIZE

    @property
    def src_per_entry(self) -> int:
        return 4 if self.compress == "c4" else 128

    @property
    def actual_topk2(self) -> int:
        """Real number of valid entries the kernel will read (per token)."""
        if self.compress == "c4":
            avail = self.seqlen // 4
            return min(avail, C4_SPARSE_TOPK)
        return max(1, (self.seqlen + 127) // 128)

    @property
    def topk2(self) -> int:
        """Padded indices length (kernel shape). Trailing slots filled with -1."""
        if self.compress == "c4":
            return C4_SPARSE_TOPK
        padded = _round_up(self.actual_topk2, ALIGN)
        if self.is_decode:
            padded = max(padded, DECODE_C128_TOPK_PAD)
        return padded

    @property
    def swa_blocks(self) -> int:
        return max(1, _round_up(self.seqlen, SWA_BLOCK_SIZE) // SWA_BLOCK_SIZE)

    @property
    def extra_blocks(self) -> int:
        n_entries = max(1, self.seqlen // self.src_per_entry)
        return max(1, (n_entries + self.extra_block_size - 1) // self.extra_block_size)


# ---------------------------------------------------------------------------
# Input construction
# ---------------------------------------------------------------------------
def _build_quantized_cache(
    num_blocks: int,
    block_size: int,
    *,
    device: str,
    generator: torch.Generator,
) -> torch.Tensor:
    bf16_k = (
        torch.randn(
            (num_blocks, block_size, 1, HEAD_DIM),
            dtype=torch.bfloat16,
            device=device,
            generator=generator,
        )
        / 10.0
    )
    bf16_k.clamp_(min=-1.0, max=1.0)
    quantized = flashmla_quant.quantize_k_cache(bf16_k, FP8_LAYOUT)
    return quantized.view(torch.uint8)


def _build_inputs(cfg: AttnCfg, *, device: str = "cuda", seed: int = 42) -> Dict[str, Any]:
    g = torch.Generator(device=device).manual_seed(seed)

    q = (
        torch.randn(
            (cfg.q_tokens, 1, NUM_HEADS, HEAD_DIM),
            dtype=torch.bfloat16,
            device=device,
            generator=g,
        )
        / 5.0
    )

    k_cache = _build_quantized_cache(
        cfg.swa_blocks, SWA_BLOCK_SIZE, device=device, generator=g
    )
    extra_k_cache = _build_quantized_cache(
        cfg.extra_blocks, cfg.extra_block_size, device=device, generator=g
    )

    swa_total = cfg.swa_blocks * SWA_BLOCK_SIZE
    extra_total = cfg.extra_blocks * cfg.extra_block_size

    indices = torch.randint(
        0, swa_total, (cfg.q_tokens, 1, SWA_TOPK),
        dtype=torch.int32, device=device, generator=g,
    )

    extra_indices = torch.full(
        (cfg.q_tokens, 1, cfg.topk2), -1, dtype=torch.int32, device=device,
    )
    if cfg.actual_topk2 > 0:
        extra_indices[..., : cfg.actual_topk2] = torch.randint(
            0, extra_total, (cfg.q_tokens, 1, cfg.actual_topk2),
            dtype=torch.int32, device=device, generator=g,
        )

    topk_length = torch.full((cfg.q_tokens,), SWA_TOPK, dtype=torch.int32, device=device)
    extra_topk_length = torch.full(
        (cfg.q_tokens,), cfg.actual_topk2, dtype=torch.int32, device=device
    )

    attn_sink = torch.randn((NUM_HEADS,), dtype=torch.float32, device=device)
    inf_mask = torch.randn((NUM_HEADS,), dtype=torch.float32, device=device)
    attn_sink[inf_mask < -0.5] = float("-inf")

    return dict(
        q=q,
        k_cache=k_cache,
        block_table=None,
        cache_seqlens=None,
        head_dim_v=HEAD_DIM,
        tile_scheduler_metadata=None,
        num_splits=None,
        softmax_scale=HEAD_DIM**-0.5,
        causal=False,
        is_fp8_kvcache=True,
        indices=indices,
        attn_sink=attn_sink,
        extra_k_cache=extra_k_cache,
        extra_indices_in_kvcache=extra_indices,
        topk_length=topk_length,
        extra_topk_length=extra_topk_length,
    )


# ---------------------------------------------------------------------------
# Benchmark loop
# ---------------------------------------------------------------------------
def _benchmark(fn, *, warmup: int = 10, iters: int = 50) -> Dict[str, float]:
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()

    starts = [torch.cuda.Event(enable_timing=True) for _ in range(iters)]
    ends = [torch.cuda.Event(enable_timing=True) for _ in range(iters)]
    for i in range(iters):
        starts[i].record()
        fn()
        ends[i].record()
    torch.cuda.synchronize()

    times = sorted(s.elapsed_time(e) for s, e in zip(starts, ends))
    return {
        "min_ms": times[0],
        "p10_ms": times[max(0, int(0.10 * iters) - 1)],
        "median_ms": times[iters // 2],
        "p90_ms": times[max(0, int(0.90 * iters) - 1)],
        "mean_ms": sum(times) / len(times),
    }


def _run_one(cfg: AttnCfg) -> Dict[str, float]:
    inputs = _build_inputs(cfg)
    out, _ = dpsk_v4_fp8_attention_fwd(**inputs)
    assert out.shape == (cfg.q_tokens, 1, NUM_HEADS, HEAD_DIM)
    return _benchmark(lambda: dpsk_v4_fp8_attention_fwd(**inputs))


def _print_row(tag: str, cfg: AttnCfg, stats: Dict[str, float]) -> None:
    print(
        f"{tag:>8s} {cfg.compress:>6s} "
        f"seqlen={cfg.seqlen:<5d} q={cfg.q_tokens:<4d} "
        f"topk2={cfg.topk2:<4d} (real={cfg.actual_topk2:<4d}) "
        f"swa_blk={cfg.swa_blocks:<3d} x_blk={cfg.extra_blocks:<4d} | "
        f"med={stats['median_ms']:7.4f}ms  "
        f"p10={stats['p10_ms']:7.4f}  p90={stats['p90_ms']:7.4f}  "
        f"min={stats['min_ms']:7.4f}"
    )


def run_sweep() -> None:
    print("=" * 110)
    print(f"DSV4-Pro DP-attn  num_heads={NUM_HEADS}  head_dim={HEAD_DIM}  "
          f"page_size={PAGE_SIZE}  swa_window={SWA_BLOCK_SIZE}  c4_topk={C4_SPARSE_TOPK}")
    print("=" * 110)

    print(f"\n--- PREFILL  (chunk={PREFILL_CHUNK} q-tokens per call) ---")
    for compress in ("c4", "c128"):
        for seqlen in PREFILL_SEQLENS:
            cfg = AttnCfg(
                compress=compress, seqlen=seqlen,
                q_tokens=PREFILL_CHUNK, is_decode=False,
            )
            _print_row("prefill", cfg, _run_one(cfg))

    print(f"\n--- DECODE  (context_seqlen={DECODE_SEQLEN}, c128 capture-pad to {DECODE_C128_TOPK_PAD}) ---")
    for compress in ("c4", "c128"):
        for conc in DECODE_CONCS:
            cfg = AttnCfg(
                compress=compress, seqlen=DECODE_SEQLEN,
                q_tokens=conc, is_decode=True,
            )
            _print_row("decode", cfg, _run_one(cfg))


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------
SMOKE_CFG = AttnCfg(compress="c4", seqlen=2048, q_tokens=8)


@pytest.mark.skipif(not torch.cuda.is_available(), reason="needs a GPU")
def test_dpsk_v4_smoke():
    inputs = _build_inputs(SMOKE_CFG)
    out, lse = dpsk_v4_fp8_attention_fwd(**inputs)
    assert out.shape == (SMOKE_CFG.q_tokens, 1, NUM_HEADS, HEAD_DIM)
    assert lse.shape == (SMOKE_CFG.q_tokens, 1, NUM_HEADS)
    assert out.dtype == torch.bfloat16
    assert lse.dtype == torch.float32
    assert torch.isfinite(out).all(), "output has NaN/Inf"


@pytest.mark.skipif(not torch.cuda.is_available(), reason="needs a GPU")
@pytest.mark.parametrize("compress", ["c4", "c128"])
@pytest.mark.parametrize("seqlen", PREFILL_SEQLENS)
def test_dpsk_v4_prefill_perf(compress, seqlen):
    cfg = AttnCfg(
        compress=compress, seqlen=seqlen, q_tokens=PREFILL_CHUNK, is_decode=False,
    )
    _print_row("prefill", cfg, _run_one(cfg))


@pytest.mark.skipif(not torch.cuda.is_available(), reason="needs a GPU")
@pytest.mark.parametrize("compress", ["c4", "c128"])
@pytest.mark.parametrize("conc", DECODE_CONCS)
def test_dpsk_v4_decode_perf(compress, conc):
    cfg = AttnCfg(
        compress=compress, seqlen=DECODE_SEQLEN, q_tokens=conc, is_decode=True,
    )
    _print_row("decode", cfg, _run_one(cfg))


if __name__ == "__main__":
    run_sweep()
