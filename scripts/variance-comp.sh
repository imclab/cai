#!/bin/bash

echo -n "Examining variance comparisons ... "

# Rscript src/bin/variance-comp.R > /dev/null 2>&1
mkdir -p variance-comp
Rscript src/bin/variance-comp.R > variance-comp/run.log 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
fi

echo "done."
