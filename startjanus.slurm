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
#   are 4 threads per core, we want 4*68=224 process in each node

#SBATCH -J janus # job name
#SBATCH -N 1 -n 1 # number of cores and nodes
#SBATCH -p skx-normal # queue
#SBATCH -o janus.o%j # output file
#SBATCH -e janus.e%j # error file 
#SBATCH -t 24:00:00 # time for which the code will run
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A Cheminfomratics-comm       # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=kediapriyansh@gmail.com


#------------------------------------------------------
module purge
module load TACC
module load python_cacher
module load remora
module load launcher
source /work2/08213/pkedia/stampede2/anaconda3/etc/profile.d/conda.sh
conda activate janus

# pip install --upgrade pip

# pip install --no-deps -r requirements.txt
# conda install pytorch pandas numpy
# conda env update --file environment.yml
# conda env update --file env.yml --prune
# conda install --file environment.txt

# export LAUNCHER_WORKDIR=/work2/08213/pkedia/stampede2/Janus-SarsCov
# export LAUNCHER_JOB_FILE=startup.sh

# ${LAUNCHER_DIR}/paramrun

# ./JANUS.py
remora python JANUS.py

conda deactivate
