#!/bin/bash


source $HOME/Analyzing-DataCenter-Workloads/src/scripts/setups/setup_utils.sh

# Run Stream
PROG=$SCRIPTS/runs/stream/run.sh

cd $SCRIPTS/runs/stream

export CC=gcc

if [ $(setup_pkgExists gcc) -eq 1 ]; then
    make $WA/stream/stream.bin
fi
if [ $(setup_pkgExists icx) -eq 1 ]; then
    make $WA/stream/stream_avx.bin $WA/stream/stream_avx2.bin $WA/stream/stream_avx512.bin
fi

source "${PROG}"
