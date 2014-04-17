#!/bin/bash

if [ $# -ne 1 ]
then
    echo "usage: <script> <benchmark-file>"
    exit 1
fi

echo -n "Adjusting benchmark output ... "

sed \
    -e 's/"p-values"/"gold-p","mode-p","pcor-p"/g' \
    -e 's/gold=//g' \
    -e 's/mode=//g' \
    -e 's/pcor=//g' \
    -e 's/;/","/g' \
    -i $1

echo "done."
