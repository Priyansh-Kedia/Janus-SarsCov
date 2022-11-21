# !/bin/bash
# ----------------------------------------------------
# Sample Slurm job script
#   for TACC Stampede2 SKX nodes
#
#   *** MPI Job on SKX Normal Queue ***
# 
# Last revised: 20 Oct 2017
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch skx.mpi.slurm" on Stampede2 login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do not use mpirun or mpiexec.
#
#   -- Max recommended MPI ranks per SKX node: 48
#      (start small, increase gradually).
#
#   -- If you're running out of memory, try running
#      fewer tasks per node to give each task more memory.
#
#----------------------------------------------------

#SBATCH -J janus           # Job name
#SBATCH -o janus.o%j       # Name of stdout output file
#SBATCH -e janus.e%j       # Name of stderr error file
#SBATCH -p skx-normal      # Queue (partition) name
#SBATCH -N 1               # Total # of nodes 
#SBATCH -n 8              # Total # of mpi tasks
#SBATCH -t 02:00:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=kediapriyansh@gmail.com
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A Cheminfomratics-comm       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module purge
module load TACC
module load python_cacher
module load remora
module load launcher
source /work2/08213/pkedia/stampede2/anaconda3/etc/profile.d/conda.sh
conda activate janus
remora python JANUS.py
conda deactivate

# Launch MPI code... 

ibrun ./myprogram         # Use ibrun instead of mpirun or mpiexec

# ---------------------------------------------------