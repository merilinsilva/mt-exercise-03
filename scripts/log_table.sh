'''
Authors:

Merilin Sousa Silva
Shubhi Pareek
'''


# Define the directories
base=/Users/merilinsilva/Documents/SemestersUZH/4thSem/MT/exercises/msousa_spareek_mt_exercise03
logs=$base/logs
model_name=transformer_deen
log_prenorm=$logs/$model_name/validation_metrics_pre.log
log_postnorm=$logs/$model_name/validation_metrics_post.log


# Extracts the ppl of every 500 steps from the baseline model log
grep "Evaluation result (greedy)" $logs/$model_name/baseline.log > $logs/$model_name/validation_metrics_baseline.log

# Define new extracted log
log_baseline=$logs/$model_name/validation_metrics_baseline.log

# Output file where the table will be saved
logfile=$logs/final_table.log

# Now we extract the perplexity and create arrays out of the perplexity values
readarray -t baseline_vals < <(grep "ppl:" "$log_baseline" | sed -nE 's/.*ppl: *([0-9]+\.[0-9]+),.*/\1/p')
readarray -t prenorm_vals < <(grep "ppl:" "$log_prenorm" | sed -nE 's/.*ppl: *([0-9]+\.[0-9]+),.*/\1/p')
readarray -t postnorm_vals < <(grep "ppl:" "$log_postnorm" | sed -nE 's/.*ppl: *([0-9]+\.[0-9]+),.*/\1/p')


# header
printf "%-15s %-12s %-12s %-12s\n" "Validation ppl" "Baseline" "Prenorm" "Postnorm" > "$logfile"

# separator
printf "%-15s %-12s %-12s %-12s\n" "---------------" "------------" "------------" "------------" >> "$logfile"

# Finally we generate the step values
step=500
for i in "${!baseline_vals[@]}"; do
    printf "%-15s %-12s %-12s %-12s\n" "$step" "${baseline_vals[$i]}" "${prenorm_vals[$i]}" "${postnorm_vals[$i]}" >> "$logfile"
    
    # To not make the table to big
    if [ "$step" -ge 32000 ]; then
        break
    fi
    
    step=$((step + 500))

done

echo "Table successfully saved"