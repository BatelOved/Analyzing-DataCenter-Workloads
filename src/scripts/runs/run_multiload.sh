#!/bin/bash


# Run multiload
PROG=$HOME/Analyzing-DataCenter-Workloads/multichase/run_multiload.sh

# Array of arguments to pass
ARGS=()

ARGS+=(2) # run_test_type (Loaded Latency)
ARGS+=(5) # iterations

cd $HOME/Analyzing-DataCenter-Workloads/multichase
make

source "${PROG}" "${ARGS[@]}"

cd "$HOME/Analyzing-DataCenter-Workloads"
