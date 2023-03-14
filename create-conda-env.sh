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
git clone https://github.com/nutonomy/nuscenes-devkit.git nuscenes-devkit && cd nuscenes-devkit && pip install -r setup/requirements.txt
# cd ~/bevfusion/ && python setup.py develop
# mkdir -p ./data/nuscenes
# wget https://www.nuscenes.org/data/v1.0-mini.tgz
# tar -xf v1.0-mini.tgz -C ./data/nuscenes
# wget -O nuScenes-map-expansion-v1.3.zip "https://s3.amazonaws.com/data.nuscenes.org/public/v1.0/nuScenes-map-expansion-v1.3.zip?AWSAccessKeyId=ASIA6RIK4RRMEDQDYHPA&Signature=9LDQjPQX2yCEbcRzjRMcNlYTzIY%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEB0aCXVzLWVhc3QtMSJGMEQCIAvCe9UJy%2FsVi5Yba%2FZZaTzhUutGRA7yFCaUNURooB3eAiBB3f9yscg%2F5Pe44VdhYtDrgG0AkbKRVNe8soiKd1akdCr9AgjW%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAMaDDk5OTEzOTYwOTY4OCIM2QJ6a0Z8jA6rfrfSKtECc7VE61Y8ZPK4rp9awCPf3y84gVfB4%2BB4qvNmySJkCNOXa09JMMvhJ04ZpkD4YLkhC8pmHZ9a%2BPgu5HzfkNIhRzLzt%2FxcL5zZt2wWl10QIYifKQ4AXmUXq%2BZ%2FYsk6g3NrqygMSrOrHSLw7GVRsOUz8qJSO%2BJgI0z2w8MVOG62uDlgO%2BJdR5TXldO8OC71aIzjhKkbgKmJqWcpHuRuwdxyUclHLJygeo%2BV4ubv2pniAyqUi24853iHjRc2RHnnHtqFhFwwwrl%2Bc3J42cFMXkHn4aFAIQ4ydzJoenXBchlHqvSyJgum3GTUA8y9jujpyWsoh9JuLYGuhTfg2eAGunNmLY11GLcWI0%2FV3YYFkxE6mB9LX1Oycs9j6IVtwk01spM0y%2FCzysY4ELT8cblgCUdjYvlwTMnKKmBrgRrpwbe7JWjp4lHzTlH79Mu3fBq9qkRC%2FDCy3sGgBjqfAYJhyWT2Z5uzhMXpL%2FSkPHO5B6zrQ2g8vMQVUScCgjXPo81p6Us5jP0cNqAlD9XMVw8rJAjysxB%2BxlMveGnyJmFioXrXkBgxBJaK5XBFnYonOzXymTmHK8o8Xl19BrNZr%2BnX324NauYMSckzraJDeJXICdc7pFpsz89OegY%2FR9EKsDA0iyJUjoHLRB%2FTXeVyFWRdQWOST1bJrDIwbKqeJw%3D%3D&Expires=1679230775"
# unzip nuScenes-map-expansion-v1.3.zip -d ./data/nuscenes
# python tools/create_data.py nuscenes --root-path ./data/nuscenes --out-dir ./data/nuscenes --extra-tag nuscenes --version v1.0-mini