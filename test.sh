#!/bin/bash
exp_type="$1"  # exp_type: no-ema_no-aug, no-ema_aug, ema_aug
exp_num="$2"  # exp_num: 1, 2, 3, 4, 5
shot_num="$3"  # shot_num: 1, 5, 10
data_type="$4"  # data_type: chest, colon, endo
device_id="$5"
config_file=configs/eva-1b_adapt_"$exp_type"_exp"$exp_num"/in21k-eva1b_adapt_bs4_lr6e-4_"$shot_num"-shot_"$data_type".py
output_file=result_"$exp_type"/exp"$exp_num"/"$data_type"_"$shot_num"-shot_submission.csv
if test -z "$exp_type" || test -z "$exp_num" || test -z "$shot_num" || test -z "$data_type" || test -z "$device_id"
then
        echo "Missing parameter"
        exit
else
        echo start on $(date)
        mkdir -p result/exp"$exp_num"
        export PYTHONPATH=$PWD:$PYTHONPATH
        export OMP_NUM_THREADS=12
        export MKL_NUM_THREADS=12
        if [[ $exp_type == "no-ema_no-aug" ]]
        then
                python tools/test_prediction.pyc "$config_file" --output-prediction "$output_file" --device cuda:"$device_id"
        else
                python tools/test_prediction_tta.pyc "$config_file" --output-prediction "$output_file" --device cuda:"$device_id"
        fi
        echo end on $(date)
fi