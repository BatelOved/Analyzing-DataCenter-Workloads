#!/bin/bash


# Run PerfKitBenchmarker
PROG=$HOME/Analyzing-DataCenter-Workloads/PerfKitBenchmarker/pkb.py
CNFG=$HOME/Analyzing-DataCenter-Workloads/src/scripts/configs/config.yaml

# Array of arguments to pass
ARGS=()

ARGS+=(--benchmark_config_file=${CNFG})
ARGS+=(--cloud=AWS)
ARGS+=(--run_processes=200)
ARGS+=(--run_stage_iterations=5)
#ARGS+=(--aws_spot_instances=true)
#ARGS+=(--dry_run=true)

"${PROG}" "${ARGS[@]}"
