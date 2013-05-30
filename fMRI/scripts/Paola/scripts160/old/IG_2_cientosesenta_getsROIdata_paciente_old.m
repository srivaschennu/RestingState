function  IG_2_cientosesenta_getsROIdata_paciente(direc)

direc = 'C:\Users\Ithabi\Documents';
cd(direc)   
rois_path= fullfile(direc,'paola/scripts160/160rois/'); 



warning off
cd (rois_path);
A=dir('*.mat');


for suj=1
    suj
    clear y    
    
    for run=1
        clear scans vox coords im imagen a b c Files reg k region MASKS

       filedir=fullfile(direc,'Subject\MyPreprocessing\fMRI_scans')
        cd(filedir)
       
        Files=spm_select('list',filedir,'swrf*.*nii');
  
        for reg=1:length(A)
            reg
            roi_name=A(reg).name;
            roi_file = spm_select('list',rois_path,roi_name);
            cd(rois_path);
            roi = maroi('load_cell', roi_file);  % make maroi ROI objects
            cd(filedir)
            mY = get_marsy(roi{:}, Files, 'mean');  % extract data into marsy data object
            scans(:,reg)= summary_data(mY); % get summary time course(s)
        end

            
        timeseries_cientosesenta(suj).run(run).timeseries = scans;
    end
end

cd(fullfile(direc,'results'))
save('timeseries_cientosesenta8','timeseries_cientosesenta');
