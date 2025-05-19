#!/bin/sh

input_path=/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/OCD_ABCD_Complexity/OCD_ABCD_PreprocComplexWOdenoise
output_path=/scratch/faculty/kjann/testenv/MSE-AUC/

# Create the LogFiles directory if it doesn't exist

mkdir -p ${output_path}/LogFiles

# Clear existing log files (optional)
# rm -f ${output_path}/LogFiles/log_*.txt
# rm -f ${output_path}/LogFiles/error_*.txt

pool=" "

for subj in $pool
do
    JOBNAME=MSE_${subj}
    LOG=${output_path}/LogFiles/log_${subj}.txt
    ERROR=${output_path}/LogFiles/error_${subj}.txt

    qsub -q compute7.q -cwd -v JOB=$subj /scratch/faculty/kjann/testenv/scripts/JKA_runJOB_full_testenv_HCP_MSE_maps_qsub.sh

done


