#!/bin/bash

# Run all configurations specified number of times.

if [ ! $# -eq 2 ]
then
    echo "usage: <script> <model> <run-count>"
    exit 1
fi

model=$1
n=$2

if [ ! $n -gt 0 ]
then
    echo "<run-count> must be a positive integer."
    exit 1
fi

if [ ! -e "./src/bin/${model}.R" ]
then
    echo "Model script '$model' not found."
    exit 1
fi

if [ ! -e "./src/bin" ]
then
    echo "Must be run from project root directory."
    exit 1
fi

mkdir -p results

echo -n "Collecting for $n iterations over model '$model' ... "

i=0
while [ $i -lt $n ]
do
    filebase="results/`date +%Y-%m-%d-%H%M`-$model"
    Rscript src/bin/$model.R > ${filebase}.log 2>&1

    if [ $? -ne 0 ]
    then
        echo "aborting batch collection (Rscript completed in error)."
        exit 1
    fi

    mv Rplots.pdf ${filebase}.pdf
    i=$[$i+1]
done

echo "done."
