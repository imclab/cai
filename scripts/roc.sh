#!/bin/bash

if ! `hash perl >/dev/null 2>&1`
then
    echo "This script depends on perl, which is not on the PATH."
    exit 1
fi

echo -n "Generating ROC data ... "

Rscript src/bin/roc.R > /dev/null 2>&1

if [ $? -ne 0 ]
then
    echo "aborting (Rscript completed in error)."
    exit 1
fi

echo "done."

echo -n "Adjusting ROC data ... "

perl -pi -e '
    s/^"\d*",//;
    ' roc.csv

echo "done."
