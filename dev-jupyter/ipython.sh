#!/bin/bash
export ROOTSYS=/usr/local/root
export PATH=$ROOTSYS/bin:$PATH
export PYTHONDIR=$ROOTSYS
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$ROOTSYS/bindings/pyroot:$LD_LIBRARY_PATH 
export PYTHONPATH=$ROOTSYS/lib:$ROOTSYS/build/lib:$ROOTSYS/bindings/pyroot
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/root/lib:/lib:$LD_LIBRARY_PATH

jupyter notebook
