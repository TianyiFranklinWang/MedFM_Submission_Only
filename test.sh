#!/bin/bash
exp_num="$1"
shot_num="$2"
data_type="$3"
device_id="$4"
config_file=configs/eva-1b_adapt_exp"$exp_num"/in21k-eva1b_adapt_bs4_lr6e-4_"$shot_num"-shot_"$data_type".py
output_file=result/exp"$exp_num"/"$data_type"_"$shot_num"-shot_submission.csv
if test -z "$exp_num" || test -z "$shot_num" || test -z "$data_type" || test -z "$device_id"
then
        echo "Missing parameter"
        exit
else
        echo start on $(date)
        export PYTHONPATH=$PWD:$PYTHONPATH
        export OMP_NUM_THREADS=12
        export MKL_NUM_THREADS=12
        python tools/test_prediction.pyc "$config_file" --output-prediction "$output_file" --device cuda:"$device_id"
        echo end on $(date)
fi