#!/bin/bash
exp_num="$1"
shot_num="$2"
data_type="$3"
config_file=configs/eva-1b_convpass_exp"$exp_num"/in21k-eva1b_convpass_bs4_lr6e-4_"$shot_num"-shot_"$data_type".py
if test -z "$exp_num" || test -z "$shot_num" || test -z "$data_type"
then
        echo "Missing parameter"
        exit
else
        echo start on $(date)
        export PYTHONPATH=$PWD:$PYTHONPATH
        export OMP_NUM_THREADS=12
        export MKL_NUM_THREADS=12
        echo Using configuration file: "$config_file"
        python tools/train.pyc "$config_file" --gpu-ids 0 1 2 3 --local_rank 0 --seed 42 --deterministic
        echo end on $(date)
fi