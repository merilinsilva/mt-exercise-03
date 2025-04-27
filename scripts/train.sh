#! /bin/bash

base=/Users/merilinsilva/Documents/SemestersUZH/4thSem/MT/exercises/msousa_spareek_mt_exercise03

joeynmt_dir="$base/joeynmt"  

export PYTHONPATH=$joeynmt_dir:$PYTHONPATH

models=$base/models
configs=$base/mt-exercise-03/configs
logs=$base/logs
num_threads=10
model_name=transformer_deen



SECONDS=0


OMP_NUM_THREADS=$num_threads python $joeynmt_dir/joeynmt/training.py $configs/deen_transformer_regular.yaml \
    2> $logs/$model_name/out_post > $logs/$model_name/err_post

grep "Evaluation result (greedy)" $logs/$model_name/out_post > $logs/$model_name/validation_metrics_post.log

echo "time taken:"
echo "$SECONDS seconds"
