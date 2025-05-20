function MSE_script(subject)

% Read data paths
path = '/scratch/faculty/kjann/Internship/Jolane_2023/OCD_ABCD_Complexity_tests/Six_Rnd_SWUs/';
path_results = '/scratch/faculty/kjann/Internship/Jolane_2023/OCD_ABCD_Complexity_tests/Six_Complexity/';

% Add necessary paths
addpath('/ifs/loni/faculty/kjann/Utilities/NIFTI')
addpath('/ifs/loni/faculty/kjann/Utilities/complexity_GUI')
addpath('/ifs/loni/faculty/kjann/Utilities/Atlases')

% Verify file existence
subject_path = fullfile(path, subject);
if exist(subject_path, 'file') ~= 2
    error('File not found: %s', subject_path);
end

% Print contents of the directory for debugging
disp('Contents of the directory:');
dir_contents = dir(path);
disp({dir_contents.name});

% Load fMRI data
try
    fmri_image_load = load_nii(subject_path);
    fmri_image = fmri_image_load.img; 
catch ME
    error('Error loading NIfTI file: %s', ME.message);
end

%%%% Complexity Test Parameters %%%%
TR = 800;
rvals = [0.3];
mvals = [2];

%%%% Load Brain Mask %%%%
mask_path = '/scratch/faculty/kjann/Internship/Jolane_2023/OCD_ABCD_Complexity_tests/BrainMASK.nii';
if exist(mask_path, 'file') ~= 2
    error('Brain mask file not found at: %s', mask_path)
else
    disp('Brain mask file found.')
end

mask = load_nii(mask_path);

%%%% Load ROI Atlases %%%%
% roi = load_nii('/ifs/loni/faculty/kjann/Utilities/Atlases/HarvardOxfordIndividualROIs_downsample/H0_ROIs_4Dimage.nii');
% roi_path = '/ifs/loni/faculty/kjann/Dilmini/HarvardOxfordIndividualROIs_downsample/H0_ROIs_4Dimage.nii';
% cd(roi_path)

% roi_files = dir('*.nii');
% roi_count = length(roi_files);

% Get ROI image Data
% roi_img(:,:,:,:) = roi.img;

%%%% Load fMRI Data %%%%
cd(path)
fmri_image_load = load_nii(subject);

% Get patient ID 
name_list = split(subject, "_");
name = name_list{1, 1};

% Check if the variable fmri_image exists before clearing it
if exist('fmri_image', 'var')
    % Clear the first 5 volumes
    fmri_image(:,:,:,1:5) = [];
else
    warning('Variable fmri_image does not exist. Skipping deletion.');
end

% Get run number
run = name_list{4, 1};

% Select timescale for MSE
maxscale = 15;

% fMRI image dimensions
[dim1, dim2, dim3, dim4] = size(fmri_image);

% Voxel-wise MSE calculations - Original data
voxel_real = zeros(dim1, dim2, dim3);
trial_img1 = double(fmri_image);

for m = 1:length(mvals)
    for r = 1:length(rvals)
        for a = 1:maxscale
            for xi = 1:dim1
                for yi = 1:dim2
                    for zi = 1:dim3
                        if mask.img(xi, yi, zi) == 1
                            voxel_call = sample_entropy(mvals(m), rvals(r) * std(squeeze(trial_img1(xi, yi, zi, :))), squeeze(trial_img1(xi, yi, zi, :)), a);
                            voxel_real(xi, yi, zi) = voxel_call(1);
                        end
                    end    
                end
            end
            img_name = [name '_r' num2str(rvals(r)) '_a' num2str(a) '_' run '.nii'];
            temp1 = mask;
            temp1.img = voxel_real;
            cd(path_results)
            save_nii(temp1, img_name)
            clear temp1
            cd(path)
        end
    end

    clear trial_img1
    clear voxel_real
end




