#!/bin/bash

env > "${output_dir}/env_variables_${task_id}.log"

# Directories
fmri_dir="/scratch/faculty/kjann/testenv/scripts/all_SWUs"
output_dir="/scratch/faculty/kjann/testenv/" #SWU_motion_outliers"
log_dir="/scratch/faculty/kjann/testenv/"

# Get the list of fMRI files
fmri_files=(${fmri_dir}/*.nii)

# Submit a job (array)
qsub -V -cwd -o "${log_dir}/job_out.log" -e "${log_dir}/job_err.log" \
     -N "motionQC" -q compute7.q -t 1-20 -tc 20 \
     "./process_fMRI_motion.sh ${fmri_dir} ${output_dir} \$SGE_TASK_ID"



# qsub -V -cwd -o "${log_dir}/job_out.log" -e "${log_dir}/job_err.log" \
#      -N "motionQC" \
#      -q compute7.q \
#      -t 1-20 -tc 20 \
#      #${#fmri_files[@]} \
#      -tc 100 \
#      # -b y 
#      "./process_fMRI_motion.sh ${fmri_dir} ${output_dir} \$SGE_TASK_ID"

echo "Task ID: ${SGE_TASK_ID}"  # Add this line to check the variable in the output logs

