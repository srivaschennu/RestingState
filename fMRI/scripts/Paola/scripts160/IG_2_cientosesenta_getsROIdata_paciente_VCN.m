% Pabo Bartfeld
% edited by IG, 15.10.12
% gets timeseiries for 168 ROI's
% -------------------------------------------------------------------------


% function  IG_2_cientosesenta_getsROIdata_paciente(direc)

% no function:
clear;clc
direc = '/home/ig300';
% -------------------------------------------------------------------------

datadir = '/scratch/ig300';
%Subj = {'ris19219';'ris16656';'ris20255'};  % Subj = {'19219_20120111/MyPreprocessing/fMRI_scans'}
rois_path = fullfile(direc,'scripts','Cam','Paola','scripts160','160rois/');
A = dir([rois_path '*.mat']);               % saves all info about the 168 ROI's in A
LoadSubjects
load([direc filesep 'results' filesep 'timeseries_168.mat'])
for isuj=1:7%:length(Subj)
    isuj
    clear scans vox coords im imagen a b c Files reg k region MASKS


    filedir = fullfile(datadir,['ris' Subj{isuj}],'fMRI')
    cd(filedir)

    Files=spm_select('list',filedir,'^swr.*\.nii$');

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

    timeseries_168(isuj).Subject = Subj{isuj};
    timeseries_168(isuj).timeseries = scans;
end %isuj

cd(fullfile(direc,'results'))
save('timeseries_168','timeseries_168');
