#!/bin/bash


# Run multiload
PROG=$HOME/Analyzing-DataCenter-Workloads/multichase/run_multiload.sh

# Array of arguments to pass
ARGS=()

ARGS+=(1) # run_test_type (Memory Bandwidth)
ARGS+=(5) # iterations

cd $HOME/Analyzing-DataCenter-Workloads/multichase
make

source "${PROG}" "${ARGS[@]}"

cd "$HOME/Analyzing-DataCenter-Workloads"
