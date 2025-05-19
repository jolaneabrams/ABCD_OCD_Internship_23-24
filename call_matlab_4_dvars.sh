#!/bin/bash

# Add the NIFTI toolbox path - adjust this path to where you have the toolbox installed
export MATLABPATH="/path/to/nifti_toolbox:$MATLABPATH"

# Call MATLAB script
matlab -nodisplay -nodesktop -r "try; process_fMRI_dvars; catch ME; disp(ME.message); exit(1); end; exit(0);"