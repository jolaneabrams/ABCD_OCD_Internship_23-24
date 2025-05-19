#!/bin/bash

# Define source and destination
source_dir="/scratch/faculty/kjann/testenv/AUC/MSE_02"
destination_dir="/scratch/faculty/kjann/testenv/scripts/copying_files/MSE_02_a1s"

# Find and copy the files using -name
find "$source_dir" -type f -name 'swusub-NDARINV????????_r0.3_a1_*.nii' -exec cp {} "$destination_dir" \;

# Optional: Print message after copying
echo "Files copied to $destination_dir"

