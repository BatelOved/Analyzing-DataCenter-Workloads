#!/bin/bash

# Env's:
export WA=${HOME}/Analyzing-DataCenter-Workloads
export SRC=${WA}/src
export RESULTS=${SRC}/results
export SCRIPTS=${SRC}/scripts

# Alias:
alias cdw="cd $WA"
alias cds="cd $SRC"
alias cdr="cd $RESULTS"
alias cdsc="cd $SCRIPTS"

alias run_pkb="bash $SCRIPTS/runs/run_pkb.sh"
alias run_multiload="bash $SCRIPTS/runs/run_multiload.sh"
alias run_fleetbench="bash $SCRIPTS/runs/run_fleetbench.sh"
alias run_stream="bash $SCRIPTS/runs/run_stream.sh"
alias clean_aws="bash $SCRIPTS/clean_aws/clean_aws.sh"
