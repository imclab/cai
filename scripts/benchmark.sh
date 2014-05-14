#!/bin/bash

if ! `hash perl >/dev/null 2>&1`
then
    echo "This script depends on perl, which is not on the PATH."
    exit 1
fi

if ! `hash gnuplot >/dev/null 2>&1`
then
    echo "This script depends on gnuplot, which is not on the PATH."
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

echo -n "Generating accuracy data ... "

Rscript src/bin/accuracy.R > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
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

echo -n "Plotting accuracy ..."

gnuplot > accuracy.png << EOF
    reset
    set terminal png
    set datafile separator ","

    set xlabel "Percent Correct"
    set ylabel "alpha-level"

    set title "Accuracy of mode, pCor Methods"
    # set nokey
    set grid

    plot \
    "accuracy.csv" using 1:2 title columnhead with lines lw 2, \
                "" using 1:3 title columnhead with lines lw 2
EOF

echo "done."

echo -n "Plotting ROC curve ..."

gnuplot > roc.png << EOF
    reset
    set terminal png
    set datafile separator ","

    set xlabel "FPR"
    set ylabel "TPR"

    set title "ROC for mode-test, pCor on Retention-MN-10K"
    # set nokey
    set grid

    set size square

    plot \
    "roc.csv" using 3:2 title columnhead with lines lw 2, \
           "" using 5:4 title columnhead with lines lw 2
EOF

echo "done."
