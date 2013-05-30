% Pabo Bartfeld
% edited by IG, 15.10.12
% gets timeseiries for 168 ROI's
% -------------------------------------------------------------------------
clear;clc
direc = 'C:\Users\Ithabi\Documents';
cd(direc)   
% -------------------------------------------------------------------------

datadir = fullfile(direc,'Subject',filesep);

Subj = {'19219'};  % Subj = {'19219_20120111/MyPreprocessing/fMRI_scans'}
rois_path = fullfile(datadir,'0P160rois',filesep);
A = dir([rois_path '*.mat']);               % saves all info about the 168 ROI's in A

for isuj=1:3
    isuj

    filedir = fullfile(datadir,Subj{isuj},'fMRI')
    cd(filedir)

    %Files=spm_select('list',filedir,'^swr.*\.nii$');
    Files=spm_select('list',filedir,'^f.*\.nii$');

    for reg=1:length(A)
        reg
        roi_name=A(reg).name;
        roi_file = spm_select('list',rois_path,roi_name); % selects Mat file of ROI
        cd(rois_path);
        roi = maroi('load_cell', roi_file);  % make maroi ROI objects
        cd(filedir)
        mY = get_marsy(roi{:}, Files, 'mean');  % extract data into marsy data object
        scans(:,reg)= summary_data(mY); % get summary time course(s)
    end


    timeseries_168(isuj).timeseries = scans;
end

cd(fullfile(direc,'results'))
save('timeseries_168','timeseries_168');
