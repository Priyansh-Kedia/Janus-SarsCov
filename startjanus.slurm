#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#
# N: Number of nodes
# n: Number of cores. For frontera it is N*56
# NHOSTS: Usually the same as N
# PPN: Process per node. Since each node has 56 cores and there
#   are 4 threads per core, we want 4*56=224 process in each node

#SBATCH -J janus
#SBATCH -N 2 -n 136
#SBATCH -p normal
#SBATCH -o janus.o%j
#SBATCH -e janus.e%j
#SBATCH -t 24:00:00
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A VinaXB       # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=kediapriyansh@gmail.com


#------------------------------------------------------
module purge
module load TACC
module load launcher
source ~/anaconda3/etc/profile.d/conda.sh
conda activate janus

pip install --no-deps -r requirements.txt
conda install pytorch pandas numpy
# conda env update --file environment.yml

bash startup.sh

conda deactivate