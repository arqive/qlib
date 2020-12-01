#!/bin/bash

export OLD_QPATH=$QPATH
export QPATH=$CONDA_PREFIX/q/lib
export OLD_QINIT=$QINIT
export QINIT=$CONDA_PREFIX/q/q.q
