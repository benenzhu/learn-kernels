#!/bin/bash
# Sweep allreduce benchmark across TP2, TP4, TP8 and aggregate results.
# Usage: bash run_sweep_tp.sh

set -euo pipefail
cd "$(dirname "$0")"

LOGDIR="./logs_tp_sweep"
mkdir -p "$LOGDIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SUMMARY="$LOGDIR/summary_${TIMESTAMP}.log"

echo "=== AllReduce TP Sweep  $(date) ===" | tee "$SUMMARY"
echo "" | tee -a "$SUMMARY"

#for TP in 2 4 8; do
for TP in 4; do
    LOGFILE="$LOGDIR/tp${TP}_${TIMESTAMP}.log"
    echo ">>> Running TP=${TP} (nproc_per_node=${TP}) ..." | tee -a "$SUMMARY"

    torchrun --nproc_per_node=${TP} bench_allreduce.py 2>&1 | tee "$LOGFILE"

    echo "" >> "$SUMMARY"
    echo "===== TP=${TP} =====" >> "$SUMMARY"
    # Extract only the table lines (skip INFO/Registering/byts noise)
    grep -E '^\s*(tokens|------|=|Pattern|$|\s+[0-9])' "$LOGFILE" >> "$SUMMARY" 2>/dev/null || true
    echo "" >> "$SUMMARY"
    echo "<<< TP=${TP} done." | tee -a "$SUMMARY"
    echo ""
done

echo ""
echo "=== All done. Summary: $SUMMARY ==="
echo ""
cat "$SUMMARY"
