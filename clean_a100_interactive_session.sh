#!/bin/bash

# entire script fails if a single command fails
set -e

# script should be run from the project directory
PROJECT_DIR="$PWD"

rm -rf ${PROJECT_DIR}/interactive-a100-session*
rm -rf ${PROJECT_DIR}/2023*