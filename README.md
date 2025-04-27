# MT Exercise 3: Layer Normalization for Transformer Models

This repo is a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models, as well as the necessary data for training your own model

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3.10 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps for macOS & Linux users

Clone this repository or your fork thereof in the desired place:

    git clone https://github.com/marpng/mt-exercise-03

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Make sure to install the exact software versions specified in the the exercise sheet before continuing.

Download Moses for post-processing:

    ./scripts/download_install_packages.sh


Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved. It is also possible to continue training from there later on.

# Instruction by our team

## Directory changes that need to be made

### mt-exercise-03/configs/deen_transformer_regular.yaml

1. Under data please change the directories `train, dev and test` to your according full path to the files in the folder `data`
2. Also under data change the full path of `voc_file` under `shared_models` and also of `codes` the full path that ends with `joeynmt/test/data/toy/bpe200.codes` -- do this for src and trg
3. In `training` change the `model_dir` to the current directory of the model (depends on it being pre or post), e.g. ending in `configs/models/transformer_model_post`

### mt-exercise-03/scripts/train.sh

1. We set the base path to the full path of our main repository that included `mt-exercise-03`, `joeynmt`, `venvs`, and later on `logs`. So change it to your main directory.
2. In these lines:
       `OMP_NUM_THREADS=$num_threads python $joeynmt_dir/joeynmt/training.py $configs/deen_transformer_regular.yaml \
        2> $logs/$model_name/out_post > $logs/$model_name/err_post`

       `grep "Evaluation result (greedy)" $logs/$model_name/out_post > $logs/$model_name/validation_metrics_post.log`

   Please change the out_post, err_post and validation..._post.log according to if you are training the pre or post-norm model.

### mt-exercise-03/scripts/log_table.sh
1. Change the base path to the same one as in `train.sh`

### mt-exercise-03/scripts/plot_line_chart.py
1. On line 17 and 61 change the paths accordingly

## How to solve the exercise
1. After making sure all the instructions are followed in the README.md of the joeynmt repository on github change the `layer_norm:` argument in the model's encoder and decoder in `mt-exercise-03/configs/deen_transformer_regular.yaml` to "post" or "pre"
2. Change the the directories in the train.sh as mentioned before and then from the main directory (outside of the `mt-exercise-03` run the command `YOURPATH/mt-exercise-03/scripts/train.sh`. Do this for pre and post norm.
3. Under `scripts` you will find the bash file `log_table.sh`, run the file with its full path to create the `final_table.log`
4. In the same folder you will find `plot_line_chart.py`, run `/usr/local/bin/python3 YOURPATH/mt-exercise-03/scripts/plot_line_chart.py` to create the final plot.
