%% HCP - Head Motion Analysis Part 01 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
%%%% NOTE %%%%%
% Processing one direction at a time (LR/RL)   
% Calculating MSE for Sample Entropy data by taking area under the curve
% for different values of scale(a)
    % Overall MSE 
    % MSE for two different frequencies (< 0.1 Hz)
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Call the function to run it
HCP_MSE_maps_JKA();

function HCP_MSE_maps_JKA()

    % Load Brain Mask
    mask = load_nii('/scratch/faculty/kjann//BrainMASK.nii');
    
    % image dimensions
    im_x = 91; im_y = 109; im_z = 91;

    % test subjects
    test_subjects = {
        'swusub-NDARINV02RCED7D'
'swusub-NDARINV0314RN9P'
'swusub-NDARINV05WK8AN7'
'swusub-NDARINV06DE9Y0L'
'swusub-NDARINV06DP74KL'
};

    % Subject MSE maps
    path_results = '/Volumes/Work24etc/Jann_Complexity_OCD_ABCD/AUC/output';
    folder_path = '/Volumes/Work24etc/Jann_Complexity_OCD_ABCD/OCD_ABCD_PreprocComplexWOdenoise';
    cd(folder_path)

    % Loop over test subjects
    for subj_idx = 1:length(test_subjects)
        subj = test_subjects{subj_idx};

   % LR
        LR_files = dir(fullfile(folder_path, [subj '*.nii']));

        r03_list = cell(15,1);
        param = 1:15;

        for m = 1:15
            r03_list{m} =  [subj '_r0.3_a' num2str(param(m)) '_run-01.nii']; 
        end
   
    image1 = zeros(im_x,im_y,im_z,size(r03_list,1));

    
    for j = 1 :length(r03_list)
        im_path1 = [folder_path,'/',r03_list{j}];
        image_file1 = load_nii(im_path1);
        get_img1 = image_file1.img;
        image1(:,:,:,j) = get_img1;

    end
    
    % Calculating frequencies
    tr = 0.8;
    fr = 1./(tr.*(1:15))';
    % Get indicies of scales for low and high frequencies
    low_fr = find(fr < 0.1);
    high_fr = find(fr > 0.1);

    
    vx_mse1 = zeros(15,1);
    vx_lowfr_mse1 = zeros(length(low_fr),1);
    vx_highfr_mse1 = zeros(length(high_fr),1);
    auc_r03 = zeros(im_x,im_y,im_z);   
    auc_r03_lowfr = zeros(im_x,im_y,im_z);
    auc_r03_highfr = zeros(im_x,im_y,im_z);


    for x = 1:im_x
        for y = 1:im_y
            for z = 1:im_z
                for k1 = 1:size(image1,4)
                    if mask.img(x,y,z) == 1
                        vx_mse1(k1,1) = image1(x,y,z,k1);
                    else
                        vx_mse1(k1,1) = 0;
                    end
                end
                % Calculate AUC all scales
                auc_r03(x,y,z) = trapz(vx_mse1);

                
                for k2 = 1:length(low_fr)
                    if mask.img(x,y,z) == 1
                        vx_lowfr_mse1(k2,1) = image1(x,y,z,low_fr(k2));
            
                    else
                        vx_lowfr_mse1(k2,1) = 0;
                   
                    end
                end
                
                % Calculate AUC for low frequencies
                auc_r03_lowfr(x,y,z) = trapz(vx_lowfr_mse1);
             
                
               for k3 = 1:length(high_fr)
                    if mask.img(x,y,z) == 1
                        vx_highfr_mse1(k3,1) = image1(x,y,z,high_fr(k3));
           
                    else
                        vx_highfr_mse1(k3,1) = 0;
       
                    end
                end
                
                % Calculate AUC for high frequencies
                auc_r03_highfr(x,y,z) = trapz(vx_highfr_mse1);
        
            end
        end
    end

    file_name = split(LR_files(1).name,'_');
       
    temp1 = mask;
 
    temp1_name = file_name; 

    temp1_name{3} = 'auc'; 

    temp1_name = [temp1_name{1} '_' temp1_name{2} '_' temp1_name{3} '.nii'];
 
    temp1.img = auc_r03;
  
    
    % Save Nifti
    save_path = path_results;

    cd(save_path)
    save_nii(temp1, temp1_name)

    clear temp1
 
    
    temp1 = mask;
 
    temp1_name = file_name; 

    temp1_name{3} = 'auc_lowfrq'; 
    temp1_name = [temp1_name{1} '_' temp1_name{2} '_' temp1_name{3} '.nii'];

    temp1.img = auc_r03_lowfr;
 
    % Save Nifti
    save_path = path_results;

    cd(save_path)
    save_nii(temp1, temp1_name)

    clear temp1

    temp1 = mask;
 
    temp1_name = file_name; 
    temp1_name{3} = 'auc_highfrq'; 
    temp1_name = [temp1_name{1} '_' temp1_name{2} '_' temp1_name{3} '.nii'];
    temp1.img = auc_r03_highfr;
 
    
    % Save Nifti
    save_path = path_results;
    cd(save_path)
    save_nii(temp1, temp1_name)
 
    
    clear temp1

    
    end
end









