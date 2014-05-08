#!/bin/bash

if ! `hash perl >/dev/null 2>&1`
then
    echo "This script depends on perl, which is not on the PATH."
    exit 1
fi

echo -n "Running benchmark ... "

Rscript src/bin/benchmark.R > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
fi

echo "done."

echo -n "Adjusting benchmark output ... "

perl -pi -e '
    s/^"\d*",//;
    s/"p-values"/"gold-p","mode-p","pcor-p"/;
    s/gold=//;
    s/mode=//;
    s/pcor=//;
    s/;/","/g;
    ' benchmark.csv

echo "done."
