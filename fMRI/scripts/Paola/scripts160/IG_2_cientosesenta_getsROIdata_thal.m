% Pabo Bartfeld
% edited by IG, 26.03.13
% gets timeseiries for new Thalamic ROI's
% -------------------------------------------------------------------------
clear;clc
direc = '/home/ig300';
% -------------------------------------------------------------------------

datadir = '/scratch/ig300';
rois_path = fullfile(direc,'scripts','Cam','Paola','scripts160','0P168rois/');
A = dir([rois_path '*.mat']);               % saves all info about the 168 ROI's in A
load([direc filesep 'results' filesep 'timeseries_168_N16.mat'])

LoadSubjects
index = [1 2 3 5 8 12 14 16 19 20 21 23 26 27 28 31];
Subj = Subj(index);

for isuj=1:length(Subj)
    isuj
    clear scans vox coords im imagen a b c Files reg k region MASKS


    filedir = fullfile(datadir,['ris' Subj{isuj}],'fMRI')
    cd(filedir)

    Files=spm_select('list',filedir,'^swr.*\.nii$');

    for reg=169:length(A)
        reg
        roi_name=A(reg).name;
        %roi_file = spm_select('list',rois_path,roi_name); % selects Mat file of ROI
        roi_file = spm_select('list',rois_path,['^' roi_name]) % selects Mat file of ROI
        cd(rois_path);
        roi = maroi('load_cell', roi_file);  % make maroi ROI objects
        cd(filedir)
        mY = get_marsy(roi{:}, Files, 'mean');  % extract data into marsy data object
        timeseries_168(isuj).timeseries(:,reg)= summary_data(mY); % get summary time course(s)     
    end

    %timeseries_168(isuj).Subject = Subj{isuj};
    %timeseries_168(isuj).timeseries(:,169:end) = scans(:,169:end);
end %isuj

cd(fullfile(direc,'results'))
save('timeseries_205','timeseries_168');
