#!/bin/bash

src_dir="/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/OCD_ABCD_PreprocComplexWOdenoise/"
dest_dir="/scratch/faculty/kjann/testenv/H_O_ROIs/MSE_run_01_test"

files=(
"swusub-NDARINV00BD7VDC_r0.3_a1_run-01.nii"
"swusub-NDARINV00U4FTRU_r0.3_a1_run-01.nii"
"swusub-NDARINV019DXLU4_r0.3_a1_run-01.nii"
"swusub-NDARINV01NAYMZH_r0.3_a1_run-01.nii"
"swusub-NDARINV022ZVCT8_r0.3_a1_run-01.nii"
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






























