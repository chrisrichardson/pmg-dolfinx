#!/bin/bash -l
#SBATCH --exclusive
#SBATCH --job-name=examplejob           # Job name
##SBATCH -o %x-j%j.out
#SBATCH --nodes=1                       # Total number of nodes
#SBATCH --ntasks-per-node=8
#SBATCH --gres=gpu:8
#SBATCH --hint=nomultithread
#SBATCH --time=00:30:00                  # Run time (d-hh:mm:ss)
#SBATCH --partition=standard-g
#SBATCH --account=project_465000356  # Project for billing
#SBATCH --exclusive

echo "Starting job $SLURM_JOB_ID at `date`"

ulimit -c unlimited
ulimit -s unlimited

gpu_bind=../select_gpu.sh
cpu_bind="--cpu-bind=map_cpu:49,57,17,23,1,9,33,41"

#export MPICH_GPU_SUPPORT_ENABLED=1
#export MPICH_OFI_NIC_POLICY=NUMA

#time srun -N ${SLURM_NNODES} -n ${SLURM_NTASKS} ${cpu_bind} /opt/rocm/rocprofiler/bin/rocprof --stats --basenames on  ./vector-update
time srun -N ${SLURM_NNODES} -n ${SLURM_NTASKS} ${cpu_bind} ./rocprof_wrapper.sh cg cg --ndof=30000000
