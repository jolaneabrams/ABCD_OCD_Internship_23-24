% Load sample subject fMRI and MSE data for thresholds
sample_fMRI_file = fullfile(sample_fMRI_dir, 'swusub-NDARINVP16EZY2C_ses-baselineYear1Arm1_task-rest_run-01_bold.nii');
sample_fMRI_data = spm_read_vols(spm_vol(sample_fMRI_file));
sample_MSE_file = fullfile(sample_MSE_dir, 'swusub-NDARINVP16EZY2C_r0.3_a1_run-01.nii');
sample_MSE_data = spm_read_vols(spm_vol(sample_MSE_file));

% Load Brain Mask
mask = load_nii('/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/BrainMASK.nii');

% Visualize histograms
figure;

% fMRI histogram
subplot(2,1,1);
histogram(sample_fMRI_data(:), 100);
title('fMRI Intensity Distribution for Sample File');
xlabel('Intensity');
ylabel('Frequency');

% MSE histogram
subplot(2,1,2);
histogram(sample_MSE_data(:), 100);
title('MSE Intensity Distribution for Sample File');
xlabel('Intensity');
ylabel('Frequency');

% Save the figure
saveas(gcf, 'sample_data_histograms.png');

% Calculate and print percentiles
fMRI_percentiles = prctile(sample_fMRI_data(:), [1 5 10 25 50 75 90 95 99]);
MSE_percentiles = prctile(sample_MSE_data(:), [1 5 10 25 50 75 90 95 99]);

fprintf('fMRI percentiles (1, 5, 10, 25, 50, 75, 90, 95, 99): \n');
disp(fMRI_percentiles);
fprintf('MSE percentiles (1, 5, 10, 25, 50, 75, 90, 95, 99): \n');
disp(MSE_percentiles);

% Define thresholds based on sample data
fMRI_threshold = prctile(sample_fMRI_data(:), 5);
MSE_threshold = prctile(sample_MSE_data(:), 5);

fprintf('fMRI threshold (5th percentile): %f\n', fMRI_threshold);
fprintf('MSE threshold (5th percentile): %f\n', MSE_threshold)