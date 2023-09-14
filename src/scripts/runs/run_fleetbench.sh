#!/bin/bash

# Run fleetbench
cd "$HOME/Analyzing-DataCenter-Workloads/fleetbench"
PROG="bazel"

# Array of arguments to pass
ARGS=()

ARGS+=(run --config=clang --config=opt)
ARGS+=(fleetbench/swissmap:hot_swissmap_benchmark)
#ARGS+=(fleetbench/swissmap:cold_swissmap_benchmark)
#ARGS+=(fleetbench/proto:proto_benchmark)
#ARGS+=(fleetbench/tcmalloc:empirical_driver)
#ARGS+=(fleetbench/compression:compression_benchmark)
#ARGS+=(fleetbench/hashing:hashing_benchmark)
#ARGS+=(fleetbench/libc:mem_benchmark)
ARGS+=(--)

#ARGS+=(--benchmark_list_tests=true)
ARGS+=(--benchmark_repetitions=5)
ARGS+=(--benchmark_min_time=30s)
ARGS+=(--benchmark_format=console)
ARGS+=(--benchmark_counters_tabular=true)

"${PROG}" "${ARGS[@]}"

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
