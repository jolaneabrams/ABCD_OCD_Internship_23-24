#!/bin/sh

input_path=/scratch/faculty/kjann/testenv/H_O_ROIs/ROI_output/GLMs/ANCOVAs/pre-ANCOVA/MSE_01_a1s/;
output_path=/scratch/faculty/kjann/testenv/SampEnAUCs/run_01/;

# Create the LogFiles directory if it doesn't exist
mkdir -p ${output_path}/LogFiles

# Clear existing log files (optional)
# rm -f ${output_path}/LogFiles/log_*.txt
# rm -f ${output_path}/LogFiles/error_*.txt

# Define the list of subjects 
subjects=" o
"

# Loop over each subject
for subj in $subjects
do
    # Trim any leading/trailing whitespace (if any)
    subj=$(echo $subj | xargs)

    # Construct job details
    JOBNAME=MSE_${subj}
    LOG=${output_path}/LogFiles/log_${subj}.txt
    ERROR=${output_path}/LogFiles/error_${subj}.txt

    # Debugging output
    echo "Submitting job for subject: $subj"
    echo "Log file path: $LOG"
    echo "Error file path: $ERROR"

    # Submit the job
    echo "Submitting job for subject: $subj"
    qsub -q compute7.q -cwd -N $JOBNAME -o $LOG -e $ERROR -v SUBJ=$subj /scratch/faculty/kjann/testenv/scripts/full_testenv_HCP_MSE_maps_JKA_gpt_runJOB.sh
done


