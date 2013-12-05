#!/bin/bash

# Run all configurations specified number of times.

if [ ! $# -eq 2 ]
then
    echo "usage: <script> <model> <run-count>"
    exit 1
fi

model=$1
n=$2

echo "Running $n iterations of model $model ..."

i=0
while [ $i -lt $n ]
do
    filebase="results/`date +%Y-%m-%d-%H%M`-$model"
    Rscript src/bin/$model.R > ${filebase}.txt
    mv Rplots.pdf ${filebase}.pdf
    i=$[$i+1]
done

echo "Completed batch run."
