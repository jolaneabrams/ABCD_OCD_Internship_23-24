folder_path = 'the path your average complexity maps for all the scales over scan runs ';
cd (folder_path)
files = dir('*_a1.nii');
for i = 1: 1194
    file_name = split(files(i).name,'_');
    x=file_name(1,1);
    subj=x{1};
    HCP_MSE_maps(subj)
end
