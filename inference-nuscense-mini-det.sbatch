#!/bin/bash --login
#SBATCH --gpus=1
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=64G
#SBATCH --time=00:15:00
#SBATCH --constraint=a100
#SBATCH --reservation=A100
#SBATCH --mail-type=ALL
#SBATCH --output=./inference-nuscenses-mini-lidar+camera-logs/%x-%j-slurm.out
#SBATCH --error=./inference-nuscenses-mini-lidar+camera-logs/%x-%j-slurm.err

set -e
module purge

conda activate ./env

# torchpack dist-run -np 1 python tools/test.py configs/nuscenes/det/transfusion/secfpn/camera+lidar/swint_v0p075/convfuser.yaml pretrained/bevfusion-det.pth --eval "bbox"
# srun --gpus=1 --gpus-per-node=1 --cpus-per-task=4 --ntasks=1 --nodes=1 --mem=32G --time=01:00:00 --constraint=a100 --reservation=A100 --pty bash
torchpack dist-run -np 1 python tools/test.py configs/nuscenes/det/transfusion/secfpn/camera+lidar/swint_v0p075/convfuser.yaml pretrained/bevfusion-det.pth --eval 'bbox' --out 'camera_lidar_bev_det.pkl' --eval-options 'show=False' 'out_dir=results_camera_lidar_bev'