#!/bin/bash



# Loop through all job scripts and submit them
for job_script in ./pamnet_target_*.sh
do
    echo "Submitting: $job_script"
    qsub "$job_script"
done

echo "All jobs have been submitted!"
