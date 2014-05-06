#!/bin/bash

if [ $# -ne 1 ]
then
    echo "usage: <script> <benchmark-file>"
    exit 1
fi

echo -n "Adjusting benchmark output ... "

# TODO: The MacOS version of 'sed' requires an additional
#       argument before the filename, whereas the MinGW version
#       cannot take this argument; make this cross-platform
#       (via $OSTYPE, uname -s, etc.).
#
sed \
    -e 's/"p-values"/"gold-p","mode-p","pcor-p"/g' \
    -e 's/gold=//g' \
    -e 's/mode=//g' \
    -e 's/pcor=//g' \
    -e 's/;/","/g' \
    -i $1

echo "done."
