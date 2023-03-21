#!/bin/bash --login

# entire script fails if a single command fails
set -e
# create the conda environment
PROJECT_DIR="$PWD"
ENV_PREFIX="$PROJECT_DIR"/env
mamba env create --prefix $ENV_PREFIX --file "$PROJECT_DIR"/environment_ibex.yml --force
conda activate $ENV_PREFIX
mim install mmcv==1.4.0
mim install mmcv-full==1.4.0
pip install mmdet==2.20.0
git clone https://github.com/nutonomy/nuscenes-devkit.git nuscenes-devkit
cd nuscenes-devkit
pip install -r setup/requirements.txt