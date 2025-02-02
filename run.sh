#!/bin/bash

#PBS -q gpuvolta
#PBS -P um09
#PBS -l ncpus=48
#PBS -l ngpus=4
#PBS -l mem=128GB
#PBS -l walltime=00:20:00
#PBS -l storage=scratch/um09
#PBS -l jobfs=100GB
#PBS -v PYTHONPATH=/scratch/um09/hl4138/llm-venv/lib/python3.10/site-packages

cd /scratch/um09/hl4138

module load python3/3.7.4 cuda/10.1
module list

source pamnet-venv/bin/activate
cd pamnet

# Run the Python script with the current parameters
python3 -u main_qm9.py --dataset 'QM9' --model 'PAMNet' --target=7 --epochs=900 --batch_size=32 --dim=128 --n_layer=6 --lr=1e-4