%% HCP - Head Motion Analysis Part 01 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
%%%% NOTE %%%%%
% Processing one direction at a time (LR/RL)   
% Calculating MSE for Sample Entropy data by taking area under the curve
% for different values of scale(a)
    % Overall MSE 
    % MSE for two different frequencies (< 0.1 Hz)
    
% Add-Ons
% Nifti Toolbox (SPM12)  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function SampEn_HCP_MSE_maps_JKA_gpt(subj)

    % Add paths for necessary toolboxes
    addpath('/ifs/loni/faculty/kjann/Utilities/NIFTI/')
    addpath('/ifs/loni/faculty/kjann/Utilities/complexity_GUI/')
    
    % Debug: Log starting point
    disp(['Processing subject: ', subj]);
    
    % Load Brain Mask
    try
        mask = load_nii('/scratch/faculty/kjann/Internship/Jolane_2023/real_OCD_ABCD_Complexity/BrainMASK.nii');
        disp('Loaded brain mask successfully.');
    catch ME
        disp(['Error loading brain mask: ', ME.message]);
        return;
    end
    
    % Image dimensions
    im_x = 91; im_y = 109; im_z = 91;
    output_path = '/scratch/faculty/kjann/testenv/scripts/AUC_calculations/SampEnAUCs/run_01';
    input_path = '/scratch/faculty/kjann/testenv/H_O_ROIs/ROI_output/GLMs/ANCOVAs/pre-ANCOVA/MSE_01_a1s';
    cd(input_path)

    % Debug: Verify subject files
    disp('Looking for subject files...');
    LR_files = dir(fullfile(input_path, [subj '*.nii']));
    if isempty(LR_files)
        disp(['No files found for subject: ', subj]);
        return;
    else
        disp(['Found ', num2str(length(LR_files)), ' files for subject: ', subj]);
    end

    % Define file list
    param = 1;  % Since you only have 'a1' files
    r03_list = cell(1,1);
    r03_list{1} =  [subj '_r0.3_a' num2str(param) '_run-01.nii'];

    image1 = zeros(im_x, im_y, im_z, 1);

    % Load the image for 'a1'
    try
        for j = 1:length(r03_list)
            im_path1 = fullfile(input_path, r03_list{j});
            disp(['Loading file: ', im_path1]);
            
            if exist(im_path1, 'file')
                image_file1 = load_nii(im_path1);
                image1(:,:,:,j) = image_file1.img;
                disp(['Loaded file: ', im_path1]);
            else
                warning(['File not found: ', im_path1]);
                return;  % Exit the function if the file isn't found
            end
        end
    catch ME
        disp(['Error loading images: ', ME.message]);
        return;
    end

% Calculating frequencies
    tr = 0.8;
    fr = 1./(tr.*(1:15))';
    low_fr = find(fr < 0.1);
    high_fr = find(fr > 0.1);

    % Initialize variables
    vx_mse1 = zeros(15,1);
    vx_lowfr_mse1 = zeros(length(low_fr),1);
    vx_highfr_mse1 = zeros(length(high_fr),1);
    auc_r03 = zeros(im_x, im_y, im_z);   
    auc_r03_lowfr = zeros(im_x, im_y, im_z);
    auc_r03_highfr = zeros(im_x, im_y, im_z);

    % Process each voxel
    for x = 1:im_x
        for y = 1:im_y
            for z = 1:im_z
                for k1 = 1:size(image1, 4)
                    if mask.img(x,y,z) == 1
                        vx_mse1(k1,1) = image1(x,y,z,k1);
                    else
                        vx_mse1(k1,1) = 0;
                    end
                end
                % Calculate AUC all scales
                auc_r03(x,y,z) = trapz(vx_mse1);

                % Calculate AUC for low frequencies
                for k2 = 1:length(low_fr)
                    if mask.img(x,y,z) == 1
                        vx_lowfr_mse1(k2,1) = image1(x,y,z,low_fr(k2));
                    else
                        vx_lowfr_mse1(k2,1) = 0;
                    end
                end
                auc_r03_lowfr(x,y,z) = trapz(vx_lowfr_mse1);

                % Calculate AUC for high frequencies
                for k3 = 1:length(high_fr)
                    if mask.img(x,y,z) == 1
                        vx_highfr_mse1(k3,1) = image1(x,y,z,high_fr(k3));
                    else
                        vx_highfr_mse1(k3,1) = 0;
                    end
                end
                auc_r03_highfr(x,y,z) = trapz(vx_highfr_mse1);
            end
        end
    end

    % Prepare file names
    file_name = split(LR_files(1).name,'_');
   
    temp1 = mask;
    temp1_name = file_name; 
    temp1_name{3} = 'auc'; 
    temp1_name = [temp1_name{1} '_' temp1_name{2} '_' temp1_name{3} '.nii'];
    temp1.img = auc_r03;

    % Save Nifti
    save_path = output_path;
    cd(save_path)
    save_nii(temp1, temp1_name)

    clear temp1

    temp1 = mask;
    temp1_name = file_name; 
    temp1_name{3} = 'auc_lowfrq'; 
    temp1_name = [temp1_name{1} '_' temp1_name{2} '_' temp1_name{3} '.nii'];
    temp1.img = auc_r03_lowfr;

    % Save Nifti
    save_path = output_path;
    cd(save_path)
    save_nii(temp1, temp1_name)

    clear temp1

    temp1 = mask;
    temp1_name = file_name; 
    temp1_name{3} = 'auc_highfrq'; 
    temp1_name = [temp1_name{1} '_' temp1_name{2} '_' temp1_name{3} '.nii'];
    temp1.img = auc_r03_highfr;

    % Save Nifti
    save_path = output_path;
    cd(save_path)
    save_nii(temp1, temp1_name)

    clear temp1
end

