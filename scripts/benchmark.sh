#!/bin/bash

echo -n "Running benchmark ... "

Rscript src/bin/benchmark.R > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
fi

echo "done."
