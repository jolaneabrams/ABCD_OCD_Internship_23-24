
# run using bash

scriptpath=/ifs/loni/faculty/kjann/ABCD-ADHD/filesADHDcomorbidities_preprocessedandcomplexitywithoutdenoising
PATHdir=/ifs/loni/faculty/kjann/ABCD-ADHD/filesADHDcomorbidities_preprocessedandcomplexitywithoutdenoising/complexityinput/run02

pool="swusub-NDARINVU9P37GDT_ses-baselineYear1Arm1_task-rest_run-02_bold.nii  swusub-NDARINVZXHZPZ48_ses-baselineYear1Arm1_task-rest_run-02_bold.nii"

cd $PATHdir


for subj in $pool; do

  echo $subj

  qsub -q compute7.q -cwd -v JOB=$subj $scriptpath/runJOB_MSEcalc_qsub.sh


done
