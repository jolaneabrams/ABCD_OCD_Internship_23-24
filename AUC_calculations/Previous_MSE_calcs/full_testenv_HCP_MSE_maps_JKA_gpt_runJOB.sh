#!/bin/sh

output_path=
matlab_script_path=/scratch/faculty/kjann/testenv/scripts/

# Log node information

uname -a > ${output_path}/node_info_$JOB.log

# Change to MATLAB script directory

cd $matlab_script_path
/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r  "full_testenv_HCP_MSE_maps_JKA_gpt('$SUBJ'); exit;" 



