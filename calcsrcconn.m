function calcsrcconn

loadsubj
loadpaths
brainstormdbpath = '/Users/chennu/Data/brainstorm_db/';
studyname = 'RestingState';

subjlist = newctrllist;

for i = 1:size(subjlist,1)
    
    % Input files
    sFiles = [];
    RawFiles = strcat(strcat(filepath,newctrllist),'.mat');
    
    %% Start a new report
    bst_report('Start', sFiles);
    
    %% Process: Import MEG/EEG: Existing epochs
    sFiles = bst_process('CallProcess', 'process_import_data_epoch', sFiles, [], ...
        'subjectname', subjlist{i}, ...
        'condition', 'default', ...
        'datafile', {RawFiles(i), 'EEG-EEGLAB'}, ...
        'iepochs', [], ...
        'eventtypes', '', ...
        'createcond', 0, ...
        'channelalign', 0, ...
        'usectfcomp', 0, ...
        'usessp', 0, ...
        'freq', [], ...
        'baseline', []);
    
    %% Process: Set channel file
    sFiles = bst_process('CallProcess', 'process_import_channel', sFiles, [], ...
        'channelfile', {RawFiles{i}, RawFiles{i}}, ...
        'usedefault', 68, ...  % ICBM152: GSN HydroCel 91
        'channelalign', 0);
    
    %% copy over head model
    headmodelfile = 'headmodel_surf_openmeeg.mat';
    copyfile(headmodelfile,sprintf('%sdata/%s/%s/@default_study/%s.mat',...
        brainstormdbpath,...
        studyname,...
        subjlist{i},...
        headmodelfile));
    
    % Process: Compute noise covariance
    sFiles = bst_process('CallProcess', 'process_noisecov', sFiles, [], ...
        'baseline', [0, 9.996], ...
        'sensortypes', 'EEG', ...
        'target', 1, ...  % Noise covariance
        'dcoffset', 1, ...  % Block by block, to avoid effects of slow shifts in data
        'method', 1, ...  % Full noise covariance matrix
        'copycond', 0, ...
        'copysubj', 0, ...
        'replacefile', 1);  % Replace
    
    sFiles = bst_process('CallProcess', 'process_inverse', sFiles, [], ...
        'Comment', '', ...
        'method', 1, ...  % Minimum norm estimates (wMNE)
        'wmne', struct(...
        'NoiseCov', [], ...
        'InverseMethod', 'wmne', ...
        'ChannelTypes', {{}}, ...
        'SNR', 3, ...
        'diagnoise', 0, ...
        'SourceOrient', {{'fixed'}}, ...
        'loose', 0.2, ...
        'depth', 1, ...
        'weightexp', 0.5, ...
        'weightlimit', 10, ...
        'regnoise', 1, ...
        'magreg', 0.1, ...
        'gradreg', 0.1, ...
        'eegreg', 0.1, ...
        'ecogreg', 0.1, ...
        'seegreg', 0.1, ...
        'fMRI', [], ...
        'fMRIthresh', [], ...
        'fMRIoff', 0.1, ...
        'pca', 1), ...
        'sensortypes', 'EEG', ...
        'output', 2);  % Kernel only: one per file
    
    % Process: Phase locking value NxN
    sFiles = bst_process('CallProcess', 'process_plv1n', sFiles, [], ...
        'timewindow', [0, 9.996], ...
        'scouts', {'Destrieux', {'G_Ins_lg_and_S_cent_ins L', 'G_Ins_lg_and_S_cent_ins R', 'G_and_S_cingul-Ant L', 'G_and_S_cingul-Ant R', 'G_and_S_cingul-Mid-Ant L', 'G_and_S_cingul-Mid-Ant R', 'G_and_S_cingul-Mid-Post L', 'G_and_S_cingul-Mid-Post R', 'G_and_S_frontomargin L', 'G_and_S_frontomargin R', 'G_and_S_occipital_inf L', 'G_and_S_occipital_inf R', 'G_and_S_paracentral L', 'G_and_S_paracentral R', 'G_and_S_subcentral L', 'G_and_S_subcentral R', 'G_and_S_transv_frontopol L', 'G_and_S_transv_frontopol R', 'G_cingul-Post-dorsal L', 'G_cingul-Post-dorsal R', 'G_cingul-Post-ventral L', 'G_cingul-Post-ventral R', 'G_cuneus L', 'G_cuneus R', 'G_front_inf-Opercular L', 'G_front_inf-Opercular R', 'G_front_inf-Orbital L', 'G_front_inf-Orbital R', 'G_front_inf-Triangul L', 'G_front_inf-Triangul R', 'G_front_middle L', 'G_front_middle R', 'G_front_sup L', 'G_front_sup R', 'G_insular_short L', 'G_insular_short R', 'G_oc-temp_lat-fusifor L', 'G_oc-temp_lat-fusifor R', 'G_oc-temp_med-Lingual L', 'G_oc-temp_med-Lingual R', 'G_oc-temp_med-Parahip L', 'G_oc-temp_med-Parahip R', 'G_occipital_middle L', 'G_occipital_middle R', 'G_occipital_sup L', 'G_occipital_sup R', 'G_orbital L', 'G_orbital R', 'G_pariet_inf-Angular L', 'G_pariet_inf-Angular R', 'G_pariet_inf-Supramar L', 'G_pariet_inf-Supramar R', 'G_parietal_sup L', 'G_parietal_sup R', 'G_postcentral L', 'G_postcentral R', 'G_precentral L', 'G_precentral R', 'G_precuneus L', 'G_precuneus R', 'G_rectus L', 'G_rectus R', 'G_subcallosal L', 'G_subcallosal R', 'G_temp_sup-G_T_transv L', 'G_temp_sup-G_T_transv R', 'G_temp_sup-Lateral L', 'G_temp_sup-Lateral R', 'G_temp_sup-Plan_polar L', 'G_temp_sup-Plan_polar R', 'G_temp_sup-Plan_tempo L', 'G_temp_sup-Plan_tempo R', 'G_temporal_inf L', 'G_temporal_inf R', 'G_temporal_middle L', 'G_temporal_middle R', 'Lat_Fis-ant-Horizont L', 'Lat_Fis-ant-Horizont R', 'Lat_Fis-ant-Vertical L', 'Lat_Fis-ant-Vertical R', 'Lat_Fis-post L', 'Lat_Fis-post R', 'Pole_occipital L', 'Pole_occipital R', 'Pole_temporal L', 'Pole_temporal R', 'S_calcarine L', 'S_calcarine R', 'S_central L', 'S_central R', 'S_cingul-Marginalis L', 'S_cingul-Marginalis R', 'S_circular_insula_ant L', 'S_circular_insula_ant R', 'S_circular_insula_inf L', 'S_circular_insula_inf R', 'S_circular_insula_sup L', 'S_circular_insula_sup R', 'S_collat_transv_ant L', 'S_collat_transv_ant R', 'S_collat_transv_post L', 'S_collat_transv_post R', 'S_front_inf L', 'S_front_inf R', 'S_front_middle L', 'S_front_middle R', 'S_front_sup L', 'S_front_sup R', 'S_interm_prim-Jensen L', 'S_interm_prim-Jensen R', 'S_intrapariet_and_P_trans L', 'S_intrapariet_and_P_trans R', 'S_oc-temp_lat L', 'S_oc-temp_lat R', 'S_oc-temp_med_and_Lingual L', 'S_oc-temp_med_and_Lingual R', 'S_oc_middle_and_Lunatus L', 'S_oc_middle_and_Lunatus R', 'S_oc_sup_and_transversal L', 'S_oc_sup_and_transversal R', 'S_occipital_ant L', 'S_occipital_ant R', 'S_orbital-H_Shaped L', 'S_orbital-H_Shaped R', 'S_orbital_lateral L', 'S_orbital_lateral R', 'S_orbital_med-olfact L', 'S_orbital_med-olfact R', 'S_parieto_occipital L', 'S_parieto_occipital R', 'S_pericallosal L', 'S_pericallosal R', 'S_postcentral L', 'S_postcentral R', 'S_precentral-inf-part L', 'S_precentral-inf-part R', 'S_precentral-sup-part L', 'S_precentral-sup-part R', 'S_suborbital L', 'S_suborbital R', 'S_subparietal L', 'S_subparietal R', 'S_temporal_inf L', 'S_temporal_inf R', 'S_temporal_sup L', 'S_temporal_sup R', 'S_temporal_transverse L', 'S_temporal_transverse R'}}, ...
        'scoutfunc', 1, ...  % Mean
        'scouttime', 2, ...  % After
        'freqbands', {'alpha', '8, 12', 'max'}, ...
        'mirror', 1, ...
        'keeptime', 0, ...
        'outputmode', 3);  % Save average connectivity matrix (one file)
    
end

%% Save and display report
ReportFile = bst_report('Save', sFiles);
bst_report('Open', ReportFile);

