#!/bin/bash

src_dir="/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/OCD_ABCD_PreprocComplexWOdenoise/"
dest_dir="/scratch/faculty/kjann/testenv/H_O_ROIs/dnsmpl/"

files=(
    "swusub-NDARINVKT7E0NA1_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKT7E0NA1_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVKTN3FFWD_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKTN3FFWD_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVKVXP0RJF_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKVXP0RJF_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVKW02LRCP_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKW02LRCP_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVKWZ5L3B4_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKWZ5L3B4_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVKX4KKBJR_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKX4KKBJR_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVKX7Y3XLZ_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVKX7Y3XLZ_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
    "swusub-NDARINVL1GF9KZ8_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"
    "swusub-NDARINVL1GF9KZ8_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"
   
)

for file in "${files[@]}"; do
    echo "Checking file: ${src_dir}${file}"
    if [ -f "${src_dir}${file}" ]; then
        cp "${src_dir}${file}" "${dest_dir}"
        if [ $? -eq 0 ]; then
            echo "Copied: ${file}"
        else
            echo "Failed to copy: ${file}"
        fi
    else
        echo "File does not exist: ${src_dir}${file}"
    fi
done






























