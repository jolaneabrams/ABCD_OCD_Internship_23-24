%% Calculate Sample Entopy for large sample data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script calculates sample entropy in each voxel using parallel processing


function MSE_script(subject)

    %%%% Read data %%%%

    path = '/ifs/loni/faculty/kjann/ABCD-ADHD/filesADHDcomorbidities_preprocessedandcomplexitywithoutdenoising/complexityinput/run02';
    path_results = '/ifs/loni/faculty/kjann/ABCD-ADHD/filesADHDcomorbidities_preprocessedandcomplexitywithoutdenoising/complexityoutput_first5volumesremoved/run02';
    
    cd(path)

    %%%% Add paths %%%%
    addpath('/ifs/loni/faculty/kjann/Utilities/NIFTI/')
    addpath('/ifs/loni/faculty/kjann/Utilities/complexity_GUI/')
    addpath('/ifs/loni/faculty/kjann/Utilities/Atlases/')

    disp(subject)

    %%%% Complexity Test Parameters %%%%
    TR = 800;
    rvals = [0.3];
    mvals = [2];  
    
    %%% Load Brain Mask %%%
    mask = load_nii('/ifs/loni/faculty/kjann/Shekhar/complexity_output/BrainMASK.nii');
    %%%% Load ROI Atlases %%%%
    %  roi = load_nii('/ifs/loni/faculty/kjann/Utilities/Atlases/HarvardOxfordIndividualROIs_downsample/HO_ROIs_4Dimage.nii');
    % roi_path =  '/ifs/loni/faculty/kjann/Dilmini/HarvardOxfordIndividualROIs_downsample/HO_ROIs_4Dimage.nii';
    % cd(roi_path)
    % 
    % roi_files = dir('*.nii');
    % roi_count = length(roi_files);
  
    %%% Get ROI image data
    % roi_img(:,:,:,:) = roi.img;

    %%%% Load fMRI data %%%%
    cd(path)
    fmri_image_load = load_nii(subject);
    
    % Get the patient ID
    name_list = split(subject,"_");
    name = name_list{1,1};

    % get the run number
    run = name_list{4,1};
    
    fmri_image(:,:,:,:) = fmri_image_load.img;

    % Remove first 5 volumes
    fmri_image(:,:,:,1:5) = [];

    % Selecting time scale for MSE

    maxscale = 15;

    % fmri image dimensions
    [dim1, dim2, dim3, dim4] = size(fmri_image);


 
    % Voxel-wise MSE calculations - Original Data
    
    voxel_real = zeros(dim1, dim2, dim3);

    trial_img1 = double(fmri_image);
    
    for m = 1:length(mvals)
        for r = 1:length(rvals)
            for a = 1:maxscale
                for xi= 1:dim1
                    for yi= 1:dim2
                        for zi= 1:dim3
                            if mask.img(xi,yi,zi) == 1
                                voxel_cal1 = sample_entropy(mvals(m),rvals(r)*std(squeeze(trial_img1(xi,yi,zi,:))),squeeze(trial_img1(xi,yi,zi,:)),a); 
                                voxel_real(xi,yi,zi) = voxel_cal1(1,1);
                            end
                        end  
                    end
                end
                img_name = [name '_' 'r' num2str(rvals(r)) '_' 'a' num2str(a) '_' run '.nii'];
                temp1 = mask;
                temp1.img = voxel_real;
                cd(path_results)
                save_nii(temp1, img_name)
                clear temp1
                cd(path)
            end
        end
        
        clear trial_img1
    end

    clear trial_img1
    clear voxel_real
    
  
    