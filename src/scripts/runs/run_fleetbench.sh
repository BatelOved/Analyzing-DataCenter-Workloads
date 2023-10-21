#!/bin/bash

# Run fleetbench
cd "$HOME/Analyzing-DataCenter-Workloads/fleetbench"
PROG="bazel"

# Array of arguments to pass
PROG_ARGS=(run --config=clang --config=opt)

TESTS=()
TESTS+=(fleetbench/swissmap:hot_swissmap_benchmark)
TESTS+=(fleetbench/swissmap:cold_swissmap_benchmark)
TESTS+=(fleetbench/proto:proto_benchmark)
TESTS+=(fleetbench/tcmalloc:empirical_driver)
TESTS+=(fleetbench/compression:compression_benchmark)
TESTS+=(fleetbench/hashing:hashing_benchmark)
TESTS+=(fleetbench/libc:mem_benchmark)

BENCHMARK_ARGS=()
BENCHMARK_ARGS+=(--)
BENCHMARK_ARGS+=(--benchmark_repetitions=5)
BENCHMARK_ARGS+=(--benchmark_min_time=30s)
BENCHMARK_ARGS+=(--benchmark_format=csv)
BENCHMARK_ARGS+=(--benchmark_counters_tabular=true)


for test in ${TESTS[@]}; do
    echo "Test: $test"
    echo ""

    "${PROG}" "${PROG_ARGS[@]}" "$test" "${BENCHMARK_ARGS[@]}"
    echo "============================================================================================================="
done


cd "$HOME/Analyzing-DataCenter-Workloads"

# benchmark [--benchmark_list_tests={true|false}]
#           [--benchmark_filter=<regex>]
#           [--benchmark_min_time=`<integer>x` OR `<float>s` ]
#           [--benchmark_min_warmup_time=<min_warmup_time>]
#           [--benchmark_repetitions=<num_repetitions>]
#           [--benchmark_enable_random_interleaving={true|false}]
#           [--benchmark_report_aggregates_only={true|false}]
#           [--benchmark_display_aggregates_only={true|false}]
#           [--benchmark_format=<console|json|csv>]
#           [--benchmark_out=<filename>]
#           [--benchmark_out_format=<json|console|csv>]
#           [--benchmark_color={auto|true|false}]
#           [--benchmark_counters_tabular={true|false}]
#           [--benchmark_perf_counters=<counter>,...]
#           [--benchmark_context=<key>=<value>,...]
#           [--benchmark_time_unit={ns|us|ms|s}]
#           [--v=<verbosity>]
