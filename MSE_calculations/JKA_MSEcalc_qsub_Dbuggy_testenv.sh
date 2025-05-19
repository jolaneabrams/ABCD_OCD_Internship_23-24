#!/bin/sh
input=/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/combined_OCD_ABCD_SWUs/
output=/scratch/faculty/kjann/testenv/MSE_run_01/
pool="swusub-NDARINV00BD7VDC_ses-baselineYear1Arm1_task-rest_run-01_bold.nii swusub-NDARINV00U4FTRU_ses-baselineYear1Arm1_task-rest_run-01_bold.nii swusub-NDARINV019DXLU4_ses-baselineYear1Arm1_task-rest_run-01_bold.nii swusub-NDARINV01NAYMZH_ses-baselineYear1Arm1_task-rest_run-01_bold.nii swusub-NDARINV022ZVCT8_ses-baselineYear1Arm1_task-rest_run-01_bold.nii"

echo "Starting job submission script"

for subj in $pool
do
    echo "Submitting job for subject: $subj"
    qsub -q compute7.q -cwd -v JOB=$subj -l h_vmem=48G /scratch/faculty/kjann/testenv/scripts/JKA_runJOB_MSEcalc_qsub_Dbuggy_testenv.sh
    echo "Job submitted for subject: $subj"
done

echo "All jobs submitted"


