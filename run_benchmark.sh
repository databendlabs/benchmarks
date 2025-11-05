#!/bin/bash

# Databend Benchmark Runner
# This script helps run all or specific benchmarks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
DATABEND_HOST="${DATABEND_HOST:-localhost}"
DATABEND_PORT="${DATABEND_PORT:-8000}"
DATABEND_USER="${DATABEND_USER:-root}"
BENCHMARK_DIR="benchmarks"

# Usage function
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Run Databend SQL benchmarks

OPTIONS:
    -h, --help              Show this help message
    -b, --benchmark <name>  Run specific benchmark (tpch, clickbench, basic, aggregation, timeseries)
    -s, --setup-only        Only run setup scripts without queries
    -q, --query <file>      Run specific query file
    -H, --host <host>       Databend host (default: localhost)
    -P, --port <port>       Databend port (default: 8000)
    -u, --user <user>       Databend user (default: root)
    -a, --all               Run all benchmarks

EXAMPLES:
    # Run all benchmarks
    $0 --all

    # Run TPC-H benchmark
    $0 --benchmark tpch

    # Setup only
    $0 --benchmark basic --setup-only

    # Run specific query
    $0 --query benchmarks/tpch/q1.sql

EOF
    exit 1
}

# Run SQL file
run_sql() {
    local sql_file=$1
    local benchmark_name=$(basename $(dirname "$sql_file"))
    
    echo -e "${YELLOW}Running: $sql_file${NC}"
    
    start_time=$(date +%s.%N)
    
    if databend-query --host="$DATABEND_HOST" --port="$DATABEND_PORT" --user="$DATABEND_USER" < "$sql_file" 2>&1; then
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc)
        echo -e "${GREEN}✓ Completed in ${duration}s${NC}"
        echo "$benchmark_name,$(basename $sql_file),$duration" >> benchmark_results.csv
    else
        echo -e "${RED}✗ Failed${NC}"
        return 1
    fi
}

# Setup benchmark
setup_benchmark() {
    local benchmark=$1
    local setup_file="$BENCHMARK_DIR/$benchmark/setup.sql"
    
    if [ -f "$setup_file" ]; then
        echo -e "${YELLOW}Setting up $benchmark benchmark...${NC}"
        run_sql "$setup_file"
    else
        echo -e "${RED}Setup file not found: $setup_file${NC}"
        return 1
    fi
}

# Run benchmark queries
run_benchmark() {
    local benchmark=$1
    local benchmark_dir="$BENCHMARK_DIR/$benchmark"
    
    if [ ! -d "$benchmark_dir" ]; then
        echo -e "${RED}Benchmark directory not found: $benchmark_dir${NC}"
        return 1
    fi
    
    echo -e "${GREEN}Running $benchmark benchmark...${NC}"
    
    # Run setup if it exists
    if [ -f "$benchmark_dir/setup.sql" ] && [ "$SETUP_ONLY" != "1" ]; then
        setup_benchmark "$benchmark"
    fi
    
    if [ "$SETUP_ONLY" == "1" ]; then
        return 0
    fi
    
    # Run all query files
    for sql_file in "$benchmark_dir"/q*.sql; do
        if [ -f "$sql_file" ]; then
            run_sql "$sql_file"
        fi
    done
}

# Parse command line arguments
BENCHMARK=""
SETUP_ONLY="0"
RUN_ALL="0"
QUERY_FILE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -b|--benchmark)
            BENCHMARK="$2"
            shift 2
            ;;
        -s|--setup-only)
            SETUP_ONLY="1"
            shift
            ;;
        -q|--query)
            QUERY_FILE="$2"
            shift 2
            ;;
        -H|--host)
            DATABEND_HOST="$2"
            shift 2
            ;;
        -P|--port)
            DATABEND_PORT="$2"
            shift 2
            ;;
        -u|--user)
            DATABEND_USER="$2"
            shift 2
            ;;
        -a|--all)
            RUN_ALL="1"
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Initialize results file
echo "benchmark,query,duration_seconds" > benchmark_results.csv

# Main execution
if [ -n "$QUERY_FILE" ]; then
    # Run specific query
    run_sql "$QUERY_FILE"
elif [ "$RUN_ALL" == "1" ]; then
    # Run all benchmarks
    for benchmark in tpch clickbench basic aggregation timeseries; do
        run_benchmark "$benchmark"
        echo ""
    done
elif [ -n "$BENCHMARK" ]; then
    # Run specific benchmark
    run_benchmark "$BENCHMARK"
else
    echo -e "${RED}Please specify a benchmark to run or use --all${NC}"
    usage
fi

echo -e "${GREEN}Benchmark results saved to: benchmark_results.csv${NC}"
