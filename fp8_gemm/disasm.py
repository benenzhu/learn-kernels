#!/usr/bin/env python3
"""Disassemble AMD GPU .co (code object) files into clean .s assembly.

Usage:
    python disasm.py input.co                # -> input.s
    python disasm.py a.co b.co               # -> a.s b.s
    python disasm.py input.co -o out.s       # -> out.s
"""

import argparse
import re
import subprocess
import sys
from pathlib import Path

OBJDUMP = "/opt/rocm/llvm/bin/llvm-objdump"

# Match trailing "// hex_addr: hex_bytes" comments
TRAILING_COMMENT = re.compile(r"\s*//\s*[0-9A-Fa-f]+:.*$")


def disasm(co_path: Path, out_path: Path):
    result = subprocess.run(
        [OBJDUMP, "-d", str(co_path)],
        capture_output=True, text=True,
    )
    if result.returncode != 0:
        print(f"error: llvm-objdump failed for {co_path}", file=sys.stderr)
        print(result.stderr, file=sys.stderr)
        sys.exit(1)

    lines = []
    for line in result.stdout.splitlines():
        line = TRAILING_COMMENT.sub("", line)
        lines.append(line)

    out_path.write_text("\n".join(lines) + "\n")
    print(f"{co_path} -> {out_path}  ({len(lines)} lines)")


def main():
    parser = argparse.ArgumentParser(description="Disassemble .co to clean .s")
    parser.add_argument("inputs", nargs="+", type=Path, help=".co files")
    parser.add_argument("-o", "--output", type=Path, help="Output .s path (single input only)")
    args = parser.parse_args()

    if args.output and len(args.inputs) > 1:
        parser.error("-o only works with a single input file")

    for co in args.inputs:
        out = args.output if args.output else co.with_suffix(".s")
        disasm(co, out)


if __name__ == "__main__":
    main()
