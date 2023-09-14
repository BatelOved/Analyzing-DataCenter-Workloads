#!/bin/bash


# Python Env & pip:
source $HOME/my_virtualenv/bin/activate
export CLOUDSDK_PYTHON=$HOME/my_virtualenv/bin/python

# Multichase Utilities:
export CC=gcc

# Env's:
export RUNS='/tmp/perfkitbenchmarker/runs'
export SRC=${HOME}/Analyzing-DataCenter-Workloads/src
export SCRIPTS=${SRC}/scripts
export CNFGS=${SCRIPTS}/configs

# Alias:
alias cdr="cd $RUNS"
alias cds="cd $SRC"
alias cdc="cd $CNFGS"
alias lt="ls -lt"
alias clean="rm -rf $RUNS/*"
alias run_pkb="bash $SCRIPTS/runs/run_pkb.sh"
alias run_multiload="bash $SCRIPTS/runs/run_multiload.sh"
alias run_fleetbench="bash $SCRIPTS/runs/run_fleetbench.sh"
alias clean_aws="bash $SCRIPTS/clean_aws/clean_aws.sh"
alias dl="rm -rf perfkitbenchmarker_keyfile* ssh* sysbench*"

# AWS Configure:
echo "SET YOUR AWS CREDENTIALS BEFORE RUNNING! (using aws configure command or env variables)"
