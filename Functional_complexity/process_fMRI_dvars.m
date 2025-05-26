function process_fMRI_dvars()

  % Add NIFTI toolbox to path if not already there
    nifti_path = '/ifs/loni/faculty/kjann/Utilities/NIFTI/';
    if ~contains(path, nifti_path)
        addpath(nifti_path);
    end

    % Set directories
    scans_dir = '/scratch/faculty/kjann/testenv/scripts/all_SWUs';
    output_dir = '/scratch/faculty/kjann/testenv/SWU_motion_outliers/dvars';
    
    % Create output directory if it doesn't exist
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    % Get list of all .nii files
    all_files = dir(fullfile(scans_dir, '*.nii'));
    total_scans = length(all_files);
    scan_count = min(25, total_scans);
    
    % Arrays to store results
    subject_ids = cell(scan_count, 1);
    [mean_dvars, max_dvars] = deal(zeros(scan_count, 1));
    
    % Get the SGE task ID if running as array job
    task_id = str2double(getenv('SGE_TASK_ID'));
    if isempty(task_id) || isnan(task_id)
        task_id = 1;  % Default to 1 if not running as array job
    end
    
    % Process only the assigned scan
    i = task_id;
    if i <= scan_count
        % Get the current file
        curr_file = all_files(i);
        
        % Extract subject ID
        [~, fname, ~] = fileparts(curr_file.name);
        subject_ids{i} = extractBetween(fname, 'sub-', '_ses');
        
        % Load the nifti file
        try
            nii = load_nii(fullfile(scans_dir, curr_file.name));
            
            % Calculate DVARS
            [mean_dvars(i), max_dvars(i), dvars_ts] = calculate_dvars(nii.img);
            
            % Save DVARS timeseries to text file
            dvars_file = fullfile(output_dir, [subject_ids{i}{1}, '_dvars.txt']);
            save(dvars_file, 'dvars_ts', '-ascii');
            
            % Create and save individual results
            subj_result = table(subject_ids(i), mean_dvars(i), max_dvars(i), ...
                'VariableNames', {'Subject', 'Mean_DVARS', 'Max_DVARS'});
            
            % Save individual results
            writetable(subj_result, fullfile(output_dir, ...
                [subject_ids{i}{1}, '_dvars_results.csv']));
            
        catch ME
            warning('Error processing subject %s: %s', subject_ids{i}{1}, ME.message);
            mean_dvars(i) = NaN;
            max_dvars(i) = NaN;
        end
    end
end

function [mean_val, max_val, dvars_ts] = calculate_dvars(img_4d)
    % Calculate DVARS (temporal derivative of timeseries RMS variance over voxels)
    % Input: 4D image array [x y z time]
    
    % Reshape 4D to 2D [voxels time]
    [nx, ny, nz, nt] = size(img_4d);
    img_2d = reshape(img_4d, [], nt);
    
    % Remove zero/non-brain voxels
    mask = any(img_2d, 2);  % Voxels that are non-zero at any timepoint
    img_2d = img_2d(mask, :);
    
    % Calculate temporal difference of timeseries
    img_diff = diff(img_2d, 1, 2);  % Difference between consecutive volumes
    
    % Calculate RMS of difference over voxels
    dvars_ts = sqrt(mean(img_diff.^2, 1));
    
    % Calculate summary metrics (excluding first 5 timepoints)
    if length(dvars_ts) > 5
        dvars_ts_trim = dvars_ts(6:end);
        mean_val = mean(dvars_ts_trim);
        max_val = max(dvars_ts_trim);
    else
        warning('Time series has fewer than 6 timepoints');
        mean_val = NaN;
        max_val = NaN;
    end
end