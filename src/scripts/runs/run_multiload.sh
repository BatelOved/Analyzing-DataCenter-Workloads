#!/bin/bash


# Run multiload
PROG=$HOME/Analyzing-DataCenter-Workloads/multichase/run_multiload.sh

# Array of arguments to pass
ARGS=()

#ARGS+=(--iterations=5)

"${PROG}" "${ARGS[@]}"
