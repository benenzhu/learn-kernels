#!/bin/bash
# MiniMax-M2.5 Kernel-Level Profiling
# TP=1, ISL=1k/8k, Conc=4/8/16/32, Level 0 vs Level 3
set -euo pipefail

export HF_HOME=/data/models/minimax
export AITER_LOG_LEVEL=WARNING

MODEL="MiniMaxAI/MiniMax-M2.5"
PORT=8200
GPU=1  # Use GPU 1 (GPU 0 has ccbot)
RESULT_BASE="$(dirname "$0")/kernel_traces"
mkdir -p "$RESULT_BASE"

LEVELS="${1:-0 3}"
ISLS="${2:-1024 8192}"
CONCS="${3:-4 8 16 32}"
NUM_PROMPTS_PER_CONC=50  # enough for stable profiling

wait_for_server() {
    local max_wait=600
    local elapsed=0
    while ! curl -s "http://localhost:${PORT}/v1/models" > /dev/null 2>&1; do
        sleep 5
        elapsed=$((elapsed + 5))
        if [ $elapsed -ge $max_wait ]; then
            echo "ERROR: Server did not start within ${max_wait}s"
            return 1
        fi
        [ $((elapsed % 30)) -eq 0 ] && echo "  ... waiting (${elapsed}s)"
    done
    echo "Server ready (took ${elapsed}s)"
}

kill_server() {
    pkill -f "openai_server.*MiniMax" 2>/dev/null || true
    sleep 3
    pkill -9 -f "openai_server.*MiniMax" 2>/dev/null || true
    sleep 2
}

for LEVEL in $LEVELS; do
    LEVEL_DIR="${RESULT_BASE}/level${LEVEL}"
    mkdir -p "$LEVEL_DIR"

    echo "=========================================="
    echo "Starting server: Level ${LEVEL}, TP=1, GPU=${GPU}"
    echo "=========================================="
    kill_server

    CUDA_VISIBLE_DEVICES=$GPU python -m atom.entrypoints.openai_server \
        --model "$MODEL" \
        --kv_cache_dtype fp8 \
        -tp 1 \
        --trust-remote-code \
        --max-model-len 16384 \
        --level "$LEVEL" \
        --torch-profiler-dir "$LEVEL_DIR" \
        --server-port "$PORT" \
        > "${LEVEL_DIR}/server.log" 2>&1 &

    if ! wait_for_server; then
        echo "FAILED: Server did not start for level ${LEVEL}"
        cat "${LEVEL_DIR}/server.log" | tail -20
        kill_server
        continue
    fi

    for ISL in $ISLS; do
        for CONC in $CONCS; do
            TAG="level${LEVEL}_isl${ISL}_conc${CONC}"
            echo "------------------------------------------"
            echo "Profiling: ${TAG}"
            echo "------------------------------------------"

            # Run benchmark with --profile (auto start/stop profiler)
            python -m atom.benchmarks.benchmark_serving \
                --model="$MODEL" \
                --backend=vllm \
                --base-url="http://localhost:${PORT}" \
                --dataset-name=random \
                --random-input-len="$ISL" \
                --random-output-len=50 \
                --random-range-ratio=0.8 \
                --num-prompts="$NUM_PROMPTS_PER_CONC" \
                --max-concurrency="$CONC" \
                --request-rate=inf \
                --ignore-eos \
                --profile \
                --save-result \
                --result-dir="$LEVEL_DIR" \
                2>&1 | tee "${LEVEL_DIR}/${TAG}_bench.log"

            # Rename trace file to include config tag
            LATEST_TRACE=$(ls -t "${LEVEL_DIR}"/rank_0/*.json.gz 2>/dev/null | head -1)
            if [ -n "$LATEST_TRACE" ]; then
                mv "$LATEST_TRACE" "${LEVEL_DIR}/rank_0/${TAG}_trace.json.gz"
                echo "Trace saved: ${LEVEL_DIR}/rank_0/${TAG}_trace.json.gz"
            else
                echo "WARNING: No trace file found for ${TAG}"
            fi

            echo "${TAG} done."
            sleep 2
        done
    done

    kill_server
    echo "Level ${LEVEL} complete."
done

echo "All profiling complete. Traces in: ${RESULT_BASE}"
