#!/bin/bash

echo -n "Generating bivariate-comparison table ... "

[ -f bivariate-comp.csv ] && rm bivariate-comp.csv

Rscript src/bin/bivariate-comp.R > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
fi

echo "done."
