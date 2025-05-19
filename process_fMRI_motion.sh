#!/bin/bash

# Input arguments
fmri_dir=$1  # Directory containing fMRI files
output_dir=$2 # Output directory
task_id=$3    # SGE Task ID

# Get the list of fMRI files
fmri_files=(${fmri_dir}/*.nii)

# Select file based on task ID (adjusted for 0-indexing)
fmri_file=${fmri_files[$((task_id-1))]}

# Extract subject ID from the filename
subject_id=$(basename "${fmri_file}" .nii)

# Output file for motion outliers
out_file="${output_dir}/${subject_id}_motion_outliers.txt"

# Summary statistics file (dvars)
dvars_file="${output_dir}/${subject_id}_dvars.txt"

# Plot file for dvars
plot_file="${output_dir}/${subject_id}_dvars_plot.png"

# Run fsl_motion_outliers with -nomoco option
fsl_motion_outliers -i "${fmri_file}" -o "${out_file}" --nomoco -s "${dvars_file}" -p "${plot_file}"

echo "Processed ${subject_id}"
