#!/bin/bash
echo start on $(date)
export PYTHONPATH=$PWD:$PYTHONPATH
export OMP_NUM_THREADS=12
export MKL_NUM_THREADS=12
python tools/bulk_predictor.pyc
echo end on $(date)