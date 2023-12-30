#!/bin/bash


source $HOME/Analyzing-DataCenter-Workloads/src/scripts/setups/setup_utils.sh

# Run Stream
PROG=$SCRIPTS/runs/stream/run.sh

cd $SCRIPTS/runs/stream

if [ $(setup_pkgExists gcc) -eq 1 ]; then
    make $WA/stream/stream.bin
fi
if [ $(setup_pkgExists intel-basekit) -eq 1 ]; then
    setup_stream
    make $WA/stream/stream_avx512.bin
fi

sudo "${PROG}" "gcc"
#sudo "${PROG}" "icx"
