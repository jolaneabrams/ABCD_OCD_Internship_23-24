#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status
set -x  # Print commands and their arguments as they are executed

output_path=/scratch/faculty/kjann/testenv/MSE_run_01/
matlab_script_path=/scratch/faculty/kjann/testenv/scripts/

echo "Job script started"
echo "JOB variable: $JOB"

if [ -z "$JOB" ]; then
    echo "Error: JOB variable is not set" >&2
    exit 1
fi

echo "Starting job for subject: $JOB"
echo "Output path: $output_path"
echo "MATLAB script path: $matlab_script_path"

echo "Current directory: $(pwd)"
echo "Contents of MATLAB script directory:"
ls -l "$matlab_script_path"

# Log node information
uname -a > "${output_path}/node_info_${JOB}.log"

# Change to MATLAB script directory
cd "$matlab_script_path" || { echo "Error: Unable to change to MATLAB script directory" >&2; exit 1; }

# Define output and error log files
matlab_output="${output_path}/matlab_output_${JOB}.log"
matlab_error="${output_path}/matlab_error_${JOB}.log"

echo "About to run MATLAB command"

# Run MATLAB script
/usr/local/MATLAB/R2019b/bin/matlab -nodesktop -nosplash -r "try, JKA_MSE_Script_Dbuggy_testenv('$JOB'); catch ME, disp(ME.message); exit(1); end, exit(0);" > "$matlab_output" 2> "$matlab_error"

echo "MATLAB command completed"
echo "Job completed for subject: $JOB"





