#!/bin/bash
source ~/anaconda3/etc/profile.d/conda.sh
conda env create -f environment.yml
conda activate bevfusion-env
mim install mmcv-full==1.4.0
pip install mmdet==2.20.0
# ln -s /home/tragoua/anaconda3/envs/bevfusion-env/bin/x86_64-conda_cos6-linux-gnu-cc /home/tragoua/anaconda3/envs/bevfusion-env/bin/gcc
# ln -s /ibex/scratch/tragoua/bevfusion-env/bin/x86_64-conda-linux-gnu-gcc /ibex/scratch/tragoua/design_baselines/bin/g++
# mkdir -p ./data/sets/nuscenes  # Make the directory to store the nuScenes dataset in.
# wget https://www.nuscenes.org/data/v1.0-mini.tgz  # Download the nuScenes mini split.
# tar -xf v1.0-mini.tgz -C ./data/sets/nuscenes  # Uncompress the nuScenes mini split.
git clone https://github.com/nutonomy/nuscenes-devkit.git nuscenes-devkit && cd nuscenes-devkit && pip install -r setup/requirements.txt
cd ~/bevfusion/ && python setup.py develop
## Dataset Preperation
# mkdir -p ./data/sets/nuscenes  # Make the directory to store the nuScenes dataset in.
# wget https://www.nuscenes.org/data/v1.0-mini.tgz  # Download the nuScenes mini split.
# tar -xf v1.0-mini.tgz -C ./data/sets/nuscenes
# export PYTHONPATH="${PYTHONPATH}:/home/tragoua/bevfusion/nuscenes-devkit/python-sdk"
#python tools/create_data.py nuscenes --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0-mini