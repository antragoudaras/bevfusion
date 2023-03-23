#!/bin/bash

#SBATCH --job-name=interactive-a100-session
#SBATCH --gpus=1
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --constraint=a100
#SBATCH --reservation=A100
#SBATCH --output=./%x-%j-slurm.out
#SBATCH --error=./%x-%j-slurm.err

source $HOME/miniconda3/bin/activate ./env


export CODE_SERVER_CONFIG=~/.config/code-server/config.yaml
node=$(/bin/hostname)
port=10121
user=tragoua 
submit_host=glogin

if [ -f ${CODE_SERVER_CONFIG} ] ; then
 rm ${CODE_SERVER_CONFIG}
fi

echo "bind-addr: ${node}:${port}" >> $CODE_SERVER_CONFIG 
echo "auth: password" >> $CODE_SERVER_CONFIG
echo "password: qwerty1234!" >> $CODE_SERVER_CONFIG
echo "cert: false" >> $CODE_SERVER_CONFIG

echo "Copy the following line in a new terminal to create a secure SSH tunnel between your computer and Ibex compute node."
echo "ssh -L localhost:${port}:${node}:${port} ${user}@${submit_host}.ibex.kaust.edu.sa"

code-server --auth=password --verbose