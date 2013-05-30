function  cientosesenta_getsROIdata_hypnal(direc)
cd(direc)   
rois_path= fullfile(direc,'/scripts160/codigos/160rois/'); 



warning off
cd (rois_path);
A=dir('*.mat');


for suj=1
    suj
    clear y    
    
    for run=1
        clear scans vox coords im imagen a b c Files reg k region MASKS

       filedir=fullfile(direc,'datos/datos_NiftiPairs/W')
        cd(filedir)
       
        Files=spm_select('list',filedir,'swr*.*nii');
  
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

cd(fullfile(direc,'Resultados'))
save('timeseries_cientosesenta','timeseries_cientosesenta');
