#!/bin/bash --login
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --gpus-per-node=v100:1
#SBATCH --cpus-per-gpu=2 
#SBATCH --mem=16G 
#SBATCH --constraint=intel
#SBATCH --partition=batch
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
wget -O nuScenes-map-expansion-v1.3.zip "https://s3.amazonaws.com/data.nuscenes.org/public/v1.0/nuScenes-map-expansion-v1.3.zip?AWSAccessKeyId=ASIA6RIK4RRMBC3JHRL3&Signature=5xnWEjKqIKLsx9dxir1ixOww98g%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEDgaCXVzLWVhc3QtMSJHMEUCIDb8Nbs4v5B91QW6h7ryFNpxNnZh4bTF2Y6ePNpAo9EeAiEA2jfk0OOR8zt3tPOjXXslvJ8m%2FvVYkRD6fqNv6n%2F2qdoq%2FQII8P%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARADGgw5OTkxMzk2MDk2ODgiDKbmteKlXy6w3LalnCrRAr3GMuk1FO8rc2CPnaRoEnMG7NVjRFN1MfRHFvj6P%2FvkktiBYPIfKRxb8oLhnn5Dq5B5LxiOxXpsKM%2Bq7BUW%2BiT%2BFxoatHH2yD5rpyCbIeNfihKH6Yh0J7HaQj7CABSYUZkWbaA67LRoESUku86oOJjniWKLZfrLRlN06HD%2BuP2pE%2FcePpEfa%2B%2FLFVucPdFJPvr6tIgpbFr8H95hALRDZ3Lpdwyvx5v4f0n7udg5vVDVwoLGACdOvAMw1uBmnGEwoE3NgBLqQPDULLzaguiGGtcS8l5xRAepS78z8L3GgmKJAQxP5iBypU9IELedC0ML2qv%2BQ4Oe4UnLMNRhD%2BCZh6cKYdqpPvCsfWoMGViA56StSc4R74jbxaDjBUlR3kigKJaulSaISKpIfy06ahZ5MEhK9sTtkurJ1imS4pFDDiZt%2FcLNKmAbvgAokoZkGrsON60ww73HoAY6ngGkSkenzdk%2FoRlY2GtEMmUfTHC8w47%2Big6E6vhUc4netg1QsuaFVs0ZCxfypPF8NLTHfjEYVrPIuvGAWOTKIhTUkId77xY%2B2yywROlEZ1sXPFhE04Q7ZI9%2FrOAf%2F0rpmpnDROVeNlfh9QDfJjyiv7ZK8BrpZxbbgOSvud%2F3FY%2BwZveHHKO0qGCi%2BGE51Z%2BPTrhWCelyS%2Fpw%2Bb5DGlOc8A%3D%3D&Expires=1679324741"
unzip nuScenes-map-expansion-v1.3.zip -d ./data/nuscenes/maps
python tools/create_data.py nuscenes --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0-mini
./tools/download_pretrained.sh