#!/bin/bash

src_dir="/scratch/faculty/kjann/testenv/outputdir/"
dest_dir="/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/OCD_ABCD_PreprocComplexWOdenoise/"

echo "Starting copy from $src_dir to $dest_dir..."

if [ -d "$src_dir" ]; then
    cp -r "$src_dir"/* "$dest_dir"
    if [ $? -eq 0 ]; then
        echo "All contents copied successfully."
    else
        echo "Failed to copy contents."
    fi
else
    echo "Source directory does not exist: $src_dir"
fi































