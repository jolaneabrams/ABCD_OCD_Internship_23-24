%% Calculate Sample Entropy for large sample data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script calculates sample entropy in each voxel using parallel processing

function JKA_MSE_Script_Dbuggy_testenv(subject)

    % Paths
    input_path = '/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/combined_OCD_ABCD_SWUs/';
    output_path = '/scratch/faculty/kjann/testenv/MSE_run_01/';

    % Set up logging
    log_file = fullfile(output_path, [subject '_log.txt']);
    log_fid = fopen(log_file, 'w');
    if log_fid == -1
        error('Unable to open log file for writing');
    end

    % Add paths
    addpath('/ifs/loni/faculty/kjann/Utilities/NIFTI/');
    addpath('/ifs/loni/faculty/kjann/Utilities/complexity_GUI/');
    addpath('/ifs/loni/faculty/kjann/Utilities/Atlases/');
    addpath('/scratch/faculty/kjann/testenv/scripts/'); 

    % Error checking
    if ~exist(input_path, 'dir') || ~exist(output_path, 'dir')
        fclose(log_fid);
        error('Input or output directory does not exist');
    end
    if nargin < 1 || isempty(subject)
        fclose(log_fid);
        error('Subject filename must be provided');
    end 

    fprintf(log_fid, 'Processing subject: %s\n', subject);

    % Complexity Test Parameters
    TR = 800;
    rvals = [0.3];
    mvals = [2];  
    
    % Load Brain Mask
    
    mask = load_nii('/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/BrainMASK.nii');
    
    % Load fMRI data

    cd(input_path)
    pwd
    display(subject)

    fmri_image_load = load_nii(subject);
        
   % Get the patient ID

    name_list = split(subject,"_");
    name = name_list{1,1};

   % Get the run number

    run = name_list{4,1};
    
    fmri_image(:,:,:,:) = fmri_image_load.img;

    % Remove first 5 volumes
    fmri_image(:,:,:,1:5) = [];

    % Selecting time scale for MSE

    maxscale = 15;

    % fMRI image dimensions

    [dim1, dim2, dim3, dim4] = size(fmri_image);  

   % Voxel-wise MSE calculations

    voxel_real = zeros(dim1, dim2, dim3);

    trial_img1 = double(fmri_image);

    for m = 1:length(mvals)
        for r = 1:length(rvals)
            for a = 1:maxscale
                for xi = 1:dim1
                    for yi = 1:dim2
                        for zi = 1:dim3
                            if mask.img(xi, yi, zi) == 1
                                voxel_cal1 = sample_entropy(mvals(m), rvals(r) * std(squeeze(trial_img1(xi, yi, zi, :))), squeeze(trial_img1(xi, yi, zi, :)), a); 
                                voxel_real(xi, yi, zi) = voxel_cal1(1, 1);
                            end
                        end  
                    end
                end

                img_name = [name '_' 'r' num2str(rvals(r)) '_' 'a' num2str(a) '_' run '.nii'];
                temp1 = mask;
                temp1.img = voxel_real;
                cd(output_path)
                save_nii(temp1, img_name)
                clear temp1
                cd(input_path)
            end
        end
        
        clear trial_img1
    end

    clear trial_img1
    clear voxel_real

    fclose(log_fid); 
end
