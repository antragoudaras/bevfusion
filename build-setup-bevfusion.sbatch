#!/bin/bash --login
#SBATCH --gpus=1
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --time=01:30:00
#SBATCH --constraint=a100
#SBATCH --reservation=A100
#SBATCH --mail-type=ALL
#SBATCH --output=./%x-%j-slurm.out
#SBATCH --error=./%x-%j-slurm.err

set -e
module purge

conda activate ./env

python setup.py develop

mkdir -p ./data/nuscenes
wget https://www.nuscenes.org/data/v1.0-mini.tgz
tar -xf v1.0-mini.tgz -C ./data/nuscenes
wget -O nuScenes-map-expansion-v1.3.zip "https://s3.amazonaws.com/data.nuscenes.org/public/v1.0/nuScenes-map-expansion-v1.3.zip?AWSAccessKeyId=ASIA6RIK4RRMK6W4IWNF&Signature=pfbPJ91GKU7hTUp%2BSbbcWDgWRGQ%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEMf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCICwihgxx3cjP3LvIGS6yPo6Sp3D5afBnc5fr9neJs1e1AiEAst8D2uLwiqP4xJxw2Kah4csUhAK6izQFqBE90YWHZ7gq%2FQIIj%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARADGgw5OTkxMzk2MDk2ODgiDIieupq2sSNQaPQpkSrRAkdx7zlXmUPh4GexirrAU0pu%2Bkcs5LGVJXw0wFzzkWE6Mg2UOw%2FrqdBgcP%2Btamo03lh1DZ%2F8gS1uay6k1WGCWGYIOqdzxt3WgqwoEftxCkEEmX9ZfjKsoFuHZQFr%2BMBt114SRqkTYWdCT9DzE8p2lsCLh4hAcAsRIwCz4170gwTLNGISIvz4ozQHyT%2F5QDsjg64lN3EHO0D%2FmyynYwKwTsFMyuMKc4hTftAJ2IS%2BdwLQgU6Ho1SUnLwx2vp3DWH2kK7G4bKZoLY31vLpETPn6XMMEvdz8TekCXP%2B111Zu9qoughq%2B%2FMmm7vn%2FRb6KRL6echH%2BULoxJjSnVEXIgOLJDanrhSabQ4BKLf2Av9B8xLm9DYsHex8oG3dAgUNb5aPKwlM8ocipzJN2jStG3alBl6ro7s4Ea9WRBp47Nzr5rUN9XlEYphlOgjj%2B7z3Y9Q1CGMw9fbmoAY6ngHDhgX1vcaxLLA1IosVn1Kfm7hx9TbAfEFkCgBtuusSi5ZyYfwFjRVwITCcYSmjkDMSupwZEdrCItcjOsjpewMh16x3znvRmcyzleyLn13vdJ5bfIDY0hz8c7wSJuq7kVCsqgKhHVHubSGcU%2FS5fOm4pcuRqFsZnq46swc7uROl4a2%2FRm%2F4ddhznaa1ER60Fy1nE5ov%2FBnJ6md%2F8nfMzQ%3D%3D&Expires=1679843074"
unzip nuScenes-map-expansion-v1.3.zip -d ./data/nuscenes/maps
python tools/create_data.py nuscenes --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0-mini
./tools/download_pretrained.sh