% Script generated by Brainstorm (11-Feb-2016)

% Input files
sFiles = {...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_1).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_10).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_11).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_12).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_13).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_14).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_15).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_16).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_17).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_18).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_19).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_2).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_20).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_21).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_22).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_23).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_24).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_25).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_26).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_27).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_28).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_29).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_3).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_30).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_31).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_32).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_33).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_34).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_35).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_36).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_37).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_38).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_39).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_4).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_40).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_41).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_42).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_43).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_44).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_45).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_46).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_47).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_48).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_49).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_5).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_50).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_51).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_52).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_53).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_54).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_55).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_56).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_57).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_58).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_59).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_6).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_7).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_8).mat', ...
    'link|NW_restingstate/@default_study/results_wMNE_EEG_KERNEL_160212_1541.mat|NW_restingstate/restingstate/data_NW_restingstate_(_9).mat'};

% Start a new report
bst_report('Start', sFiles);

% Process: Phase locking value NxN
sFiles = bst_process('CallProcess', 'process_plv1n', sFiles, [], ...
    'timewindow', [0, 9.996], ...
    'scouts', {'Destrieux', {'G_Ins_lg_and_S_cent_ins L', 'G_Ins_lg_and_S_cent_ins R', 'G_and_S_cingul-Ant L', 'G_and_S_cingul-Ant R', 'G_and_S_cingul-Mid-Ant L', 'G_and_S_cingul-Mid-Ant R', 'G_and_S_cingul-Mid-Post L', 'G_and_S_cingul-Mid-Post R', 'G_and_S_frontomargin L', 'G_and_S_frontomargin R', 'G_and_S_occipital_inf L', 'G_and_S_occipital_inf R', 'G_and_S_paracentral L', 'G_and_S_paracentral R', 'G_and_S_subcentral L', 'G_and_S_subcentral R', 'G_and_S_transv_frontopol L', 'G_and_S_transv_frontopol R', 'G_cingul-Post-dorsal L', 'G_cingul-Post-dorsal R', 'G_cingul-Post-ventral L', 'G_cingul-Post-ventral R', 'G_cuneus L', 'G_cuneus R', 'G_front_inf-Opercular L', 'G_front_inf-Opercular R', 'G_front_inf-Orbital L', 'G_front_inf-Orbital R', 'G_front_inf-Triangul L', 'G_front_inf-Triangul R', 'G_front_middle L', 'G_front_middle R', 'G_front_sup L', 'G_front_sup R', 'G_insular_short L', 'G_insular_short R', 'G_oc-temp_lat-fusifor L', 'G_oc-temp_lat-fusifor R', 'G_oc-temp_med-Lingual L', 'G_oc-temp_med-Lingual R', 'G_oc-temp_med-Parahip L', 'G_oc-temp_med-Parahip R', 'G_occipital_middle L', 'G_occipital_middle R', 'G_occipital_sup L', 'G_occipital_sup R', 'G_orbital L', 'G_orbital R', 'G_pariet_inf-Angular L', 'G_pariet_inf-Angular R', 'G_pariet_inf-Supramar L', 'G_pariet_inf-Supramar R', 'G_parietal_sup L', 'G_parietal_sup R', 'G_postcentral L', 'G_postcentral R', 'G_precentral L', 'G_precentral R', 'G_precuneus L', 'G_precuneus R', 'G_rectus L', 'G_rectus R', 'G_subcallosal L', 'G_subcallosal R', 'G_temp_sup-G_T_transv L', 'G_temp_sup-G_T_transv R', 'G_temp_sup-Lateral L', 'G_temp_sup-Lateral R', 'G_temp_sup-Plan_polar L', 'G_temp_sup-Plan_polar R', 'G_temp_sup-Plan_tempo L', 'G_temp_sup-Plan_tempo R', 'G_temporal_inf L', 'G_temporal_inf R', 'G_temporal_middle L', 'G_temporal_middle R', 'Lat_Fis-ant-Horizont L', 'Lat_Fis-ant-Horizont R', 'Lat_Fis-ant-Vertical L', 'Lat_Fis-ant-Vertical R', 'Lat_Fis-post L', 'Lat_Fis-post R', 'Pole_occipital L', 'Pole_occipital R', 'Pole_temporal L', 'Pole_temporal R', 'S_calcarine L', 'S_calcarine R', 'S_central L', 'S_central R', 'S_cingul-Marginalis L', 'S_cingul-Marginalis R', 'S_circular_insula_ant L', 'S_circular_insula_ant R', 'S_circular_insula_inf L', 'S_circular_insula_inf R', 'S_circular_insula_sup L', 'S_circular_insula_sup R', 'S_collat_transv_ant L', 'S_collat_transv_ant R', 'S_collat_transv_post L', 'S_collat_transv_post R', 'S_front_inf L', 'S_front_inf R', 'S_front_middle L', 'S_front_middle R', 'S_front_sup L', 'S_front_sup R', 'S_interm_prim-Jensen L', 'S_interm_prim-Jensen R', 'S_intrapariet_and_P_trans L', 'S_intrapariet_and_P_trans R', 'S_oc-temp_lat L', 'S_oc-temp_lat R', 'S_oc-temp_med_and_Lingual L', 'S_oc-temp_med_and_Lingual R', 'S_oc_middle_and_Lunatus L', 'S_oc_middle_and_Lunatus R', 'S_oc_sup_and_transversal L', 'S_oc_sup_and_transversal R', 'S_occipital_ant L', 'S_occipital_ant R', 'S_orbital-H_Shaped L', 'S_orbital-H_Shaped R', 'S_orbital_lateral L', 'S_orbital_lateral R', 'S_orbital_med-olfact L', 'S_orbital_med-olfact R', 'S_parieto_occipital L', 'S_parieto_occipital R', 'S_pericallosal L', 'S_pericallosal R', 'S_postcentral L', 'S_postcentral R', 'S_precentral-inf-part L', 'S_precentral-inf-part R', 'S_precentral-sup-part L', 'S_precentral-sup-part R', 'S_suborbital L', 'S_suborbital R', 'S_subparietal L', 'S_subparietal R', 'S_temporal_inf L', 'S_temporal_inf R', 'S_temporal_sup L', 'S_temporal_sup R', 'S_temporal_transverse L', 'S_temporal_transverse R'}}, ...
    'scoutfunc', 1, ...  % Mean
    'scouttime', 1, ...  % Before
    'freqbands', {'alpha', '8, 12', 'max'}, ...
    'mirror', 1, ...
    'keeptime', 0, ...
    'outputmode', 2);  % Concatenate input files before processing (one file)

% Save and display report
ReportFile = bst_report('Save', sFiles);
bst_report('Open', ReportFile);

