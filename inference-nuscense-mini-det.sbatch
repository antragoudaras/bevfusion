#!/bin/bash --login
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=v100:1
#SBATCH --cpus-per-gpu=4 
#SBATCH --mem=36G 
#SBATCH --constraint=intel
#SBATCH --partition=batch
#SBATCH --mail-type=ALL
#SBATCH --output=./inference-nuscenses-mini-lidar+camera-logs/%x-%j-slurm.out
#SBATCH --error=./inference-nuscenses-mini-lidar+camera-logs/%x-%j-slurm.err

set -e
module purge

conda activate ./env

torchpack dist-run -np 1 -v python tools/test.py configs/nuscenes/det/transfusion/secfpn/camera+lidar/swint_v0p075/convfuser.yaml pretrained/bevfusion-det.pth --eval bbox --show --show-dir ./camera+lidar_det_results