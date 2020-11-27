#!/bin/bash

if [ `uname` == Linux ]; then
    OSL='l'
fi
if [ `uname` == Darwin ]; then
    OSL='m'
fi

unzip -qq -o $QZIP
echo .z.k|QLIC=$(dirname $QLICSRC) QHOME=./ numactl --physcpubind=0 ${OSL}64/q -q
