#!/bin/bash

src_dir="/scratch/faculty/kjann/Internship/Jolane_2023/Scripts_new/OCD_Ctrl_Files/completeDataOCD_CtrlsKJ/"
dest_dir="/scratch/faculty/kjann/testenv/scripts/all_SWUs/"

echo "Starting copy from $src_dir to $dest_dir..."

# Check if source directory exists
if [ -d "$src_dir" ]; then
    # Ensure the destination directory exists
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
        if [ $? -ne 0 ]; then
            echo "Failed to create destination directory: $dest_dir"
            exit 1
        fi
    fi

    # Loop through files starting with "swusub-" and ending in "_bold.nii"
    for file in ${src_dir}/swusub-*bold.nii; do
        if [ -e "$file" ]; then
            cp "$file" "$dest_dir/"
            if [ $? -eq 0 ]; then
                echo "Copied: $file"
            else
                echo "Failed to copy: $file"
            fi
        else
            echo "No matching files found."
            break
        fi
    done
else
    echo "Source directory does not exist: $src_dir"
fi

echo "Copy process completed."



























