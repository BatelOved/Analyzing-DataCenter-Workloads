#!/bin/bash


source $HOME/Analyzing-DataCenter-Workloads/src/scripts/setups/setup_utils.sh
setup_multichase

# Run multiload
PROG=$HOME/Analyzing-DataCenter-Workloads/multichase/run_multiload.sh

export CC=gcc

# Array of arguments to pass
ARGS=()

#Command args: $0 <run_test_type> <iterations> <samples> <socket_eval> <remote_memnode> <thread_affinity>

#<run_test_type>
#      0 = Memory Read Latency (Runs multichase \"simple\" test, but all multichase commands should work manually)
#      1 = Memory Bandwidth    (Runs a list of bandwidth load algorithms)
#      2 = Loaded Latency.     (\"Chaseload\" combines 1 \"simple\" latency thread and multiple Bandwidth threads)

ARGS+=(1) # run_test_type
ARGS+=(5) # iterations

cd $HOME/Analyzing-DataCenter-Workloads/multichase
make

source "${PROG}" "${ARGS[@]}"

cd "$HOME/Analyzing-DataCenter-Workloads"
