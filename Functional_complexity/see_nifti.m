% Add paths
addpath(fullfile('/ifs/loni/faculty/kjann/Utilities/NIFTI/'));
addpath(fullfile('/ifs/loni/faculty/kjann/Utilities/spm12'));
addpath(fullfile('/ifs/loni/faculty/kjann/Utilities/Atlases/'));
addpath(fullfile('/scratch/faculty/kjann/testenv/scripts/'));  
    
spm('Defaults','fMRI');
spm_jobman('initcfg');

nii_file = '/scratch/faculty/kjann/testenv/H_O_ROIs/ROI_output/GLMs/ANCOVAs/pre-ANCOVA/Sample_files_4_Tholds/swusub-NDARINVP16EZY2C_ses-baselineYear1Arm1_task-rest_run-01_bold.nii'; 
V = spm_vol(nii_file);              % Load NIfTI file header
img_data = spm_read_vols(V);        % Read image data

slice_num = 49;                     % Specify the 49th axial slice
imagesc(img_data(:,:,slice_num));    % Display the 49th slice
colormap gray;                       % Apply grayscale color map
axis image;                          % Keep aspect ratio
title(['Axial Slice ', num2str(slice_num)]);

% Coronal: img_data(:,slice_num,:) (vary the second dimension).
% Sagittal: img_data(slice_num,:,:) (vary the first dimension).