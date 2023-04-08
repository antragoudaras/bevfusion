#!/bin/bash
source ~/anaconda3/etc/profile.d/conda.sh
# create the conda environment
PROJECT_DIR="$PWD"
ENV_PREFIX="$PROJECT_DIR"/env
conda env create --prefix $ENV_PREFIX --file "$PROJECT_DIR"/environment.yml --force
conda activate $ENV_PREFIX
mim install mmcv==1.4.0
mim install mmcv-full==1.4.0
pip install mmdet==2.20.0
git clone https://github.com/nutonomy/nuscenes-devkit.git nuscenes-devkit && cd nuscenes-devkit && pip install -r setup/requirements.txt
cd ~/bevfusion/ && python setup.py develop
mkdir -p ./data/nuscenes
# wget https://www.nuscenes.org/data/v1.0-mini.tgz
tar -xf v1.0-mini.tgz -C ./data/nuscenes
# wget -O nuScenes-map-expansion-v1.3.zip "https://s3.amazonaws.com/data.nuscenes.org/public/v1.0/nuScenes-map-expansion-v1.3.zip?AWSAccessKeyId=ASIA6RIK4RRMNFJBNDMI&Signature=MchMNJtWZOfrBBV%2BBStg7wWImVA%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEOL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIEIcc2%2F8eFivngWWpNEziJfA0n1PPddUxW6e7Baacrg5AiEAvyKGK2Y4%2F36qfPaGRzYW0O4%2BzoAM4lIZXavM5H%2Fd3Egq%2FQIIq%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARADGgw5OTkxMzk2MDk2ODgiDEVFlxatwgoAjb3ldyrRApkRG4lADlRLykYgBcrh%2BWuufNhAYabfbPEJiP5Vs8xsUX8ZSnw7DL2N8sHYAuMS8zyhQHBbypDpWZ2XFyzPuJPOVmnwylyTIpoT5v%2BQ%2BU%2BgURAe%2B8dC5zeEkD9IGpykUCNOFQYl9%2F3psv%2BCEun7IL5AOcWVyqp3kO4UKswMKeJrieok1chwzFNZlvMmHVUCxs0LnOysOFUh4Fs1nWd3b7XH67sm%2BEZNihHXnJy2nSaaX2qyw74OFp02P6My58bGeaHujFxUACy1ELCTPqZanvQYe1H9%2Fpf04uROTTxRWM54T6%2Bw4OEyiQpvQWTFYSwR22ZGDbsDxN8aZFgUixI%2B7siThGa%2Fkeci6l1Bf2TgQnYvHyPspoNV9enECLk4BSGp5cR2J7YFHaDMWADZIFofnghA1AHe9UXHp%2BoV04RIpzpF4taxlh6XvENtUXtm4pRV6Ksw%2F%2FTsoAY6ngHkFhIxD%2FnXcLUt1QvnQT2aeiLT5RBpQwgxHOurfqz%2Fq2ikwJnI43bqHkBNlwlgCBNrNJY8A8nIJrKpd8XEjz0p25thcL%2BDHZbREIekAAJbqnvHNCGa%2FlcFaSDPP4d9Y6nrHB%2Bl36wi183ieoPTX3sLklvk1XmMgF2qWHtWUIfoB6so0EmvREEasniiMMFz%2Bx%2Fyx0qOTMhWhivCVAEJDA%3D%3D&Expires=1679938049"
unzip nuScenes-map-expansion-v1.3.zip -d ./data/nuscenes/maps
python tools/create_data.py nuscenes --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0-mini
# ./tools/download_pretrained.sh