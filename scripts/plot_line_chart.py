'''
Authors:

Merilin Sousa Silva
Shubhi Pareek
'''

######Imports
import matplotlib.pyplot as plt # Please install the package first
import numpy as np # Please install the package first
import re
############


# First we read the log file with the table -- Please change the path accordingly
mixed_perplexities_and_steps = []
with open("/Users/merilinsilva/Documents/SemestersUZH/4thSem/MT/exercises/msousa_spareek_mt_exercise03/logs/final_table.log", 'r') as f:
    # In each line the numbers are extracted and added to a combined list
    for i, line in enumerate(f):
        if i <= 1:
            continue
        else:
            mixed_perplexities_and_steps += re.findall(r'\d+\.*\d*', line)

# Now we create separated lists
steps = [step for step in mixed_perplexities_and_steps[::4]]
ppl_baseline = list(map(float, [ppl_baseline for ppl_baseline in mixed_perplexities_and_steps[1::4]]))
ppl_pre = list(map(float, [ppl_pre for ppl_pre in mixed_perplexities_and_steps[2::4]]))
ppl_post = list(map(float, [ppl_post for ppl_post in mixed_perplexities_and_steps[3::4]]))

# We set the figure size
plt.figure(figsize=(12, 6))

# Finally, we plot the values
line_names = ['ppl_baseline', 'ppl_prenorm', 'ppl-postnorm']
for i, data in enumerate([ppl_baseline, ppl_pre, ppl_post]):
    plt.plot(steps, data, alpha=0.9, label=line_names[i])


# Here we define the range of the y axis and rotate the x labels
plt.xticks(rotation= 90)

all_ppl = np.concatenate([ppl_baseline, ppl_pre, ppl_post])
min_ppl = np.floor(all_ppl.min())
max_ppl = np.ceil(all_ppl.max())

# Rounding to nearest muliple of 5
start = 5 * int(min_ppl // 5)
end = 5 * int((max_ppl // 5) + 1)


plt.yticks(np.arange(start, end + 1, 5))

plt.xlabel('Step Count')
plt.ylabel('Validation Perplexity')
plt.title("Validation Perplexities Based on Layer Normalization Technique")
plt.grid(True)
plt.legend()

# Save plot -- Change directory as needed
plt.savefig('/Users/merilinsilva/Documents/SemestersUZH/4thSem/MT/exercises/msousa_spareek_mt_exercise03/mt-exercise-03/model_ppl_plot.png')
