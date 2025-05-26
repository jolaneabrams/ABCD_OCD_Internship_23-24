#!/bin/sh

scriptpath=/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/combined_OCD_ABCD_SWUs/
PATHdir=/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/OAPCWODN/


pool="swusub-NDARINVB8WVUJ56_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVB8WVUJ56_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVL7ZXH7GM_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVL7ZXH7GM_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKT7E0NA1_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKT7E0NA1_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKTN3FFWD_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKTN3FFWD_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKVXP0RJF_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKVXP0RJF_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKW02LRCP_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKW02LRCP_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKWZ5L3B4_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKWZ5L3B4_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKX4KKBJR_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKX4KKBJR_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVKX7Y3XLZ_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVKX7Y3XLZ_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVL1GF9KZ8_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVL1GF9KZ8_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVL1RVKM6B_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVL1RVKM6B_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVLC488VTJ_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVLC488VTJ_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVLCMU795T_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVLCMU795T_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVLG186K52_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVLG186K52_ses-baselineYearlArml_task-rest_run-02_bold.nii swusub-NDARINVLK2ZABWM_ses-baselineYearlArml_task-rest_run-01_bold.nii swusub-NDARINVLK2ZABWM_ses-baselineYearlArml_task-rest_run-02_bold.nii"

for JOB in $pool
do
    JOBNAME=MSE_${JOB}
    LOG=${PATHdir}/LogFiles/log_${JOB}.txt
    ERROR=${PATHdir}/LogFiles/error_${JOB}.txt
    
    echo '#!/bin/bash' > run_${JOB}.sh
    echo "uname -a > ${PATHdir}/node_info_${JOB}.log" >> run_${JOB}.sh
    echo "cd ${scriptpath}" >> run_${JOB}.sh
    echo "/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r \"MSE_script('$JOB')\"" >> run_${JOB}.sh

    qsub -q iniadmin7.q -cwd -v JOB=$subj /scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/JKA_runJOB_MSEcalc_qsub_Dbuggy.sh

done


