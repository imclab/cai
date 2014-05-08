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

perl -pi.bak -e '
    s/^"\d*",//;
    s/"p-values"/"gold-p","mode-p","pcor-p"/;
    s/gold=//;
    s/mode=//;
    s/pcor=//;
    s/;/","/g;
    ' benchmark.csv

if [ -e benchmark.csv ]
then
    if [ -e benchmark.csv.bak ]
    then
        rm benchmark.csv.bak
    fi
fi

echo "done."

echo -n "Generating ROC data ... "

Rscript src/bin/roc.R > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
fi

echo "done."

echo -n "Adjusting ROC data ... "

perl -pi.bak -e '
    s/^"\d*",//;
    ' roc.csv

if [ -e roc.csv ]
then
    if [ -e roc.csv.bak ]
    then
        rm roc.csv.bak
    fi
fi

echo "done."
