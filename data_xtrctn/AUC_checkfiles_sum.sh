#!/bin/bash

# Directory where the files are stored
directory="/scratch/faculty/kjann/testenv/MSE-AUC/run_02"

# File containing the list of subjects
subject_file="Latest_Unique_AUCs.txt"

# Output file for subjects with missing files
report_file="missing_AUC_files_run_02_report.txt"

# Clear the report file if it exists
> "$report_file"

# Read the subject list from the file
while IFS= read -r subject; do

  # Trim any leading/trailing whitespace (if any)
  subject=$(echo "$subject" | xargs)

  # Define the file paths
  auc_file="${directory}/${subject}_r0.3_auc.nii"
  hifreq_file="${directory}/${subject}_r0.3_auc_highfrq.nii"
  lowfreq_file="${directory}/${subject}_r0.3_auc_lowfrq.nii"

  # Initialize flags for missing files
  auc_missing=false
  hifreq_missing=false
  lowfreq_missing=false

  # Check file existence
  if [[ ! -f "$auc_file" ]]; then
    auc_missing=true
  fi

  if [[ ! -f "$hifreq_file" ]]; then
    hifreq_missing=true
  fi

  if [[ ! -f "$lowfreq_file" ]]; then
    lowfreq_missing=true
  fi

  # Report missing files
  if [[ $auc_missing == true || $hifreq_missing == true || $lowfreq_missing == true ]]; then
    echo "Subject: $subject" >> "$report_file"
    [[ $auc_missing == true ]] && echo "  AUC file is missing." >> "$report_file"
    [[ $hifreq_missing == true ]] && echo "  HiFreq file is missing." >> "$report_file"
    [[ $lowfreq_missing == true ]] && echo "  LowFreq file is missing." >> "$report_file"
    echo "------" >> "$report_file"
  fi

done < "$subject_file"

echo "Report generated: $report_file"

