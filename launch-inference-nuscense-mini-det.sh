#!/bin/bash

# entire script fails if a single command fails
set -e

# script should be run from the project directory
PROJECT_DIR="$PWD"

# project should have a src directory
SRC_DIR="$PROJECT_DIR"
JOB_RESULTS_DIR="$PROJECT_DIR"/inference-nuscenses-mini-lidar+camera-logs

mkdir -p "$JOB_RESULTS_DIR"

JOB_NAME=inference-nuscenes-mini-lidar+camera

sbatch --job-name "$JOB_NAME" "$SRC_DIR"/inference-nuscense-mini-det.sbatch