#!/bin/bash

if [ $# -ne 1 ]
then
    echo "usage: <script> <benchmark-file>"
    exit 1
fi

if ! `hash perl >/dev/null 2>&1`
then
    echo "This script depends on perl, which is not on the PATH."
    exit 1
fi

echo -n "Adjusting benchmark output ... "

perl -pi -e '
    s/^"\d*",//;
    s/"p-values"/"gold-p","mode-p","pcor-p"/;
    s/gold=//;
    s/mode=//;
    s/pcor=//;
    s/;/","/g;
    ' $1

echo "done."
