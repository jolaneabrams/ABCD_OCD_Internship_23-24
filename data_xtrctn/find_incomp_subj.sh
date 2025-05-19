#!/bin/bash

# Define the input path
input_path="/scratch/faculty/kjann/testenv/outputdir"

# Define output file
output_file="/scratch/faculty/kjann/testenv/incomplete_subjects_050824"

# Get a list of unique NDARINV identifiers
ndar_list=$(ls ${input_path} | grep -oP 'NDARINV\w{8}' | sort -u)

# Loop through each NDARINV identifier
for ndar in $ndar_list
do
    # Check if the files with *a15_run-01.nii and *a15_run-02.nii exist for this NDARINV identifier
    run01_exists=$(ls ${input_path} | grep -q "${ndar}.*a15_run-01.nii" && echo "yes" || echo "no")
    run02_exists=$(ls ${input_path} | grep -q "${ndar}.*a15_run-02.nii" && echo "yes" || echo "no")
    
    # If either file is missing, log the NDARINV identifier
    if [ "$run01_exists" = "no" ] || [ "$run02_exists" = "no" ]; then
        echo "${ndar}" >> ${output_file}
    fi
done

echo "Results saved to ${output_file}"




