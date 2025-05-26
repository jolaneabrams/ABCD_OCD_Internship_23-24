#!/bin/bash

# Directories
fmri_dir="/scratch/faculty/kjann/testenv/scripts/all_SWUs"
output_dir="/scratch/faculty/kjann/testenv/SWU_motion_outliers/dvars"
log_dir="/scratch/faculty/kjann/testenv/SWU_motion_outliers/dvars/LogFiles"

# Remove existing log directory and recreate it
rm -rf "${log_dir}"
mkdir -p "${log_dir}"

# Create output directories if they don't exist
mkdir -p "${output_dir}"

# Get the list of fMRI files
num_files=$(ls ${fmri_dir}/*.nii 2>/dev/null | wc -l)
max_jobs=25
num_jobs=$((num_files < max_jobs ? num_files : max_jobs))

# Submit array job
qsub -V -cwd \
     -o "${log_dir}/job_\$TASK_ID.out" \
     -e "${log_dir}/job_\$TASK_ID.err" \
     -N "motionQC" \
     -q compute7.q \
     -t 1-${num_jobs} \
     -tc ${num_jobs} \
     "./call_matlab_4_dvars.sh"


