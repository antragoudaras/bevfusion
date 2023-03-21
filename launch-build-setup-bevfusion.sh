#!/bin/bash

# entire script fails if a single command fails
set -e

# script should be run from the project directory
PROJECT_DIR="$PWD"

# project should have a src directory
SRC_DIR="$PROJECT_DIR"

JOB_NAME=build-setup-bevfusion-A100-capability

sbatch --job-name "$JOB_NAME" "$SRC_DIR"/build-setup-bevfusion.sbatch