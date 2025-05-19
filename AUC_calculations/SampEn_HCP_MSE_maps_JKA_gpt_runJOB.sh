#!/bin/sh

output_path='/scratch/faculty/kjann/testenv/AUC_calculations/SampEnAUCs/run_01/'
matlab_script_path='/scratch/faculty/kjann/testenv/scripts/AUC_calculations/'  # Directory where MATLAB script lives

# Log node information
mkdir -p ${output_path}/LogFiles
uname -a > ${output_path}/LogFiles/node_info_${JOBNAME}.log

# Change to MATLAB script directory
cd $matlab_script_path

# Debug: list files in the directory to confirm the script exists
ls -l ${matlab_script_path}

# Run MATLAB script
#/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r  "addpath('$matlab_script_path'); SampEn_HCP_MSE_maps_JKA_gpt('$SUBJ'); exit;"

#/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r "addpath('/scratch/faculty/kjann/testenv/scripts/AUC_calculations/); SampEn_HCP_MSE_maps_JKA_gpt('$SUBJ'); exit;" > ${output_path}/LogFiles/matlab_output.log 2>&1

/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r  "disp('Running function'); SampEn_HCP_MSE_maps_JKA_gpt('$SUBJ'); exit;"
