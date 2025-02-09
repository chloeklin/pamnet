#!/bin/bash

# Loop to create job scripts for --target values from 0 to 11
for target in {0..11}
do
    script_filename="./pamnet_target_${target}.sh"

    cat <<EOL > "$script_filename"
#!/bin/bash

#PBS -q gpuvolta
#PBS -P um09
#PBS -l ncpus=96
#PBS -l ngpus=8
#PBS -l mem=128GB
#PBS -l walltime=40:00:00
#PBS -l storage=scratch/um09
#PBS -l jobfs=100GB

cd /scratch/um09/hl4138

module load python3/3.7.4 cuda/10.1
module list

source pamnet-venv/bin/activate
cd pamnet

# Run the Python script with the current parameters
python3 -u main_qm9.py --dataset 'QM9' --model 'PAMNet' --target=${target} --epochs=300 --batch_size=32 --dim=128 --n_layer=6 --lr=1e-4
EOL

    chmod +x "$script_filename"
    echo "Generated: $script_filename"
done

echo "All PBS job scripts created in '$output_dir'!"
