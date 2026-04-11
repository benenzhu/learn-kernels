#!/bin/bash
# MiniMax-M2.5 FP8 Throughput Benchmark
# ISL=8192, OSL=512, 4 TP/Concurrency configs
set -euo pipefail

export HF_HOME=/data/models/minimax
export AITER_LOG_LEVEL=WARNING

MODEL="MiniMaxAI/MiniMax-M2.5"
ISL=8192
OSL=512
PORT=8002
MAX_MODEL_LEN=16384
RESULT_DIR="$(dirname "$0")/results"
mkdir -p "$RESULT_DIR"

# tp:conc pairs - order: most stable first
CONFIGS="${1:-2:16 4:32 8:64 1:8}"

wait_for_server() {
    local url="$1"
    local max_wait=600  # 10 minutes max (compilation takes time)
    local elapsed=0
    echo "Waiting for server at $url ..."
    while ! curl -s "$url" > /dev/null 2>&1; do
        sleep 5
        elapsed=$((elapsed + 5))
        if [ $elapsed -ge $max_wait ]; then
            echo "ERROR: Server did not start within ${max_wait}s"
            return 1
        fi
        echo "  ... waiting (${elapsed}s)"
    done
    echo "Server is ready (took ${elapsed}s)"
}

kill_server() {
    echo "Stopping server..."
    pkill -f "atom.entrypoints.openai_server" 2>/dev/null || true
    sleep 3
    pkill -9 -f "atom.entrypoints.openai_server" 2>/dev/null || true
    sleep 2
}

for config in $CONFIGS; do
    TP="${config%:*}"
    CONC="${config#*:}"
    NUM_PROMPTS=$((CONC * 10))
    TAG="tp${TP}_conc${CONC}"
    LOG_FILE="${RESULT_DIR}/${TAG}_server.log"
    BENCH_LOG="${RESULT_DIR}/${TAG}_bench.log"

    echo "=========================================="
    echo "Config: TP=${TP}, Concurrency=${CONC}"
    echo "=========================================="

    # Kill any existing server
    kill_server

    # Start server
    echo "Starting ATOM server (TP=${TP})..."
    python -m atom.entrypoints.openai_server \
        --model "$MODEL" \
        --kv_cache_dtype fp8 \
        -tp "$TP" \
        --trust-remote-code \
        --max-model-len "$MAX_MODEL_LEN" \
        --server-port "$PORT" \
        > "$LOG_FILE" 2>&1 &
    SERVER_PID=$!

    # Wait for server
    if ! wait_for_server "http://localhost:${PORT}/v1/models"; then
        echo "FAILED: Server did not start for ${TAG}"
        echo "Check log: $LOG_FILE"
        kill_server
        continue
    fi

    # Run benchmark
    echo "Running benchmark: ISL=${ISL}, OSL=${OSL}, Conc=${CONC}, Prompts=${NUM_PROMPTS}"
    python -m atom.benchmarks.benchmark_serving \
        --model="$MODEL" \
        --backend=vllm \
        --base-url="http://localhost:${PORT}" \
        --dataset-name=random \
        --random-input-len="$ISL" \
        --random-output-len="$OSL" \
        --random-range-ratio=0.8 \
        --num-prompts="$NUM_PROMPTS" \
        --max-concurrency="$CONC" \
        --request-rate=inf \
        --ignore-eos \
        --save-result \
        --result-dir="$RESULT_DIR" \
        --percentile-metrics="ttft,tpot,itl,e2el" \
        2>&1 | tee "$BENCH_LOG"

    echo "Benchmark ${TAG} complete."
    echo ""

    # Stop server
    kill_server
done

echo "All benchmarks complete. Results in: $RESULT_DIR"
