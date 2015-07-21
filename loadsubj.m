newdata = {
%    'p0713_restingstate'  %not enough data
%     'p1013_restingstate' % noisy
%     'p0813_restingstate'
%     'p0913_restingstate'
%    'p0114_restingstate' % patient with hydrocephalus

% 'Srivas_resting_DI'
% 'Srivas_resting_RM'
% 'DanielSoto'
% 'AlvaroJimenez'
'CamiloHernandez'
% 'FranciscoRissetti'
% 'ClaudioLavin'
'CristianCabezas'
% 'MarcoLillo'
% 'EmilioGuzman'
% 'Srivas_resting_WP'
% 'Srivas_resting_TG'
% 'Srivas_Resting_TE'
% 'Srivas_Resting_SRJ'
% 'Srivas_resting_ES' %%noisy
% 'Srivas_resting_ACR'%% no alpha
% 'Srivas_Resting_AA'
% 'Srivas_resting_NMH'
% 'TeresitaSilva'
% 'HelenaCarvacho' %too noisy rejected
% 'GorkaNavarrete'
% 'StefanieHarbt'
% 'JuanPablo'
% 'JesusVidal'
% 'EmilioVera'
% % 'IvanCorrea' %missing
% 'CarinaPuccio'
% 'ClaudiaUrrea'
% 'BeatrizGarreton'
% 'FranciscoPerez'
};


patlist = {
    %
    % patients
%name                     type   crs    com-foll? followup? etio    ris     
'p0311_restingstate1'		0		7		0		''		0		19262
'p0411_restingstate1'		0		7		0		''		1		19277
'p1611_restingstate'		0		7		1		''		1		19829
'p0510V2_restingstate'		0		7		0		''		1		18744
'p1311_restingstate'		0		8		0		''		1		19655
'p2011_restingstate'		0		7		0		''		0		20112
'p0612_restingstate'		0		8		0		''		1		20174
'p71v3_restingstate'		0		8		0		''		1		17680
'p0712_restingstate'		0		7		0		''		0		21348
'p0113_restingstate'		0		7		1		''		1		21636
'p0313_restingstate'		0		7		1		''		1		21675
'p0613_restingstate'		0		8		0		''		1		22248
'p0812_restingstate1'		0		7		1		''		1		21415
'p0611_restingstate'		1		10		1		''		0		19348
'p0312_restingstate'		1		8		1		''		0		20466
'p0211_restingstate1'		1		12		1		''		1		19219
'p0511_restingstate'		1		9		1		''		0		19306
'p0811_restingstate'		1		10		0		''		0		19447
'p0911_restingstate'		1		11		1		''		1		19475
'p1011_restingstate'		1		10		0		''		1		19551
'p1511_restingstate'		1		10		1		''		1		19757
'p1811_restingstate'		1		12		0		''		1		19953
'p1911_restingstate'		1		9		0	


% %new patients
% 'p0813_restingstate'		0		7		0		''		0		22665
% 'p0913_restingstate'		0		6		0		''		0		22717

    %     %follow-ups
    %     'p0311V2_restingstate'  0   8   0   'p0311_restingstate1'   0
    %     'p1311v2_restingstate'  0   8   0   'p1311_restingstate'    1
    %     'p0612v2_restingstate'  0   7   1   'p0612_restingstate'    1
    %     'p0712v2_restingstate'  0   7   0   'p0712_restingstate'    0
    %     'p0411V2_restingstate'  1   8   0   'p0411_restingstate1'   1 %noisy
    %     'p0512v2_restingstate'  1   8   0   'p0512_restingstate'    1 %noisy
    %     'p0511V2_restingstate'  1   10  0   'p0511_restingstate'    0 %noisy
    %     'p1511v2_restingstate'  1   10  0   'p1511_restingstate'    1
    %     'p0611v2_restingstate'  1   11  0   'p0611_restingstate'    0 %noisy
    %     'p0211V2_restingstate'	1   16  1   'p0211_restingstate1'   1
    %     'p1811v2_restingstate'  1   20  0   'p1811_restingstate'    1
    
    %duplicates
    % p0211_restingstate2'   2   14 duplicate
    %'p0311_restingstate2'   0   7 duplicate
    %'p0411_restingstate2'   0   7 duplicate
    
    
    % 'p2111_restingstate'    1   10 %noisy
    % 'p0513_restingstate' %noisy
    
    %'p66v4_restingstate'   %no data
    %'p0412_restingstate'   %no data
    %'p0812v2_restingstate' %no data
    
    %'p0912_restingstate' severely disabled
    };

ctrllist = {
    %     controls
    
'NW_restingstate'		2		25		2		''		2		0
'p37_restingstate'		2		25		2		''		2		0
'p38_restingstate'		2		25		2		''		2		0
'p40_restingstate'		2		25		2		''		2		0
'p41_restingstate'		2		25		2		''		2		0
'p42_restingstate'		2		25		2		''		2		0
'p43_restingstate'		2		25		2		''		2		0
'p44_restingstate'		2		25		2		''		2		0
'p45_restingstate'		2		25		2		''		2		0
'p46_restingstate'		2		25		2		''		2		0
'p47_restingstate'		2		25		2		''		2		0
'p48_restingstate'		2		25		2		''		2		0
'p49_restingstate'		2		25		2		''		2		0
'subj01_restingstate'	2		25		2		''		2		0
'subj02_restingstate'	2		25		2		''		2		0
'VS_restingstate'		2		25		2		''		2		0
'SS_restingstate'		2		25		2		''		2		0
'SB_restingstate'		2		25		2		''		2		0
'ML_restingstate'		2		25		2		''		2		0
'MC_restingstate'		2		25		2		''		2		0
'JS_restingstate'		2		25		2		''		2		0
'ET_restingstate'		2		25		2		''		2		0
'EP_restingstate'		2		25		2		''		2		0
'CL_restingstate'		2		25		2		''		2		0
'CD_restingstate'		2		25		2		''		2		0
'AC_restingstate'		2		25		2		''		2		0

    %     'jenny_restingstate'
    %     %'SaltyWater_restingstate'
    % 'p50_restingstate'
    % 'FD_restingstate'
    % 'CS_restingstate'  ''
    };

newctrllist = {
'DanielaCabezas'		2		25		2		''		2		0
'FranciscoOlivares'		2		25		2		''		2		0
'AlisonSaldana'         2		25		2		''		2		0
% 'FiorellaZaneta'		2		25		2		''		2		0 % no ALPHA! maybe reject
'RobertoGarcia' 		2		25		2		''		2		0
'DanielSoto'    		2		25		2		''		2		0
'AlvaroJimenez' 		2		25		2		''		2		0
% 'CamiloHernandez'		2		25		2		''		2		0 %large blinks
'FranciscoRissetti'		2		25		2		''		2		0
% 'ClaudioLavin'  		2		25		2		''		2		0 % noisy v small alpha
'CristianCabezas'		2		25		2		''		2		0
'MarcoLillo'    		2		25		2		''		2		0
'EmilioGuzman'  		2		25		2		''		2		0
'TeresitaSilva'         2		25		2		''		2		0
% 'GorkaNavarrete'        2		25		2		''		2		0 %no alpha
'StefanieHarbt'         2		25		2		''		2		0
'JuanPablo'             2		25		2		''		2		0
'JesusVidal'            2		25		2		''		2		0
'EmilioVera'            2		25		2		''		2		0
'CarinaPuccio'          2		25		2		''		2		0
'ClaudiaUrrea'          2		25		2		''		2		0
'BeatrizGarreton'       2		25		2		''		2		0
'FranciscoPerez'        2		25		2		''		2		0
% 'Srivas_resting_DI'		2		25		2		''		2		0 %theta peak
'Srivas_resting_RM'		2		25		2		''		2		0
'Srivas_resting_WP'     2		25		2		''		2		0
'Srivas_resting_TG'     2		25		2		''		2		0
% 'Srivas_Resting_TE'     2		25		2		''		2		0
'Srivas_Resting_SRJ'    2		25		2		''		2		0
'Srivas_resting_ES'     2		25		2		''		2		0 %%noisy
% 'Srivas_resting_ACR'    2		25		2		''		2		0 %% no alpha
'Srivas_Resting_AA'     2		25		2		''		2		0
'Srivas_resting_NMH'    2		25		2		''		2		0
};

% fmrilist = {
%     'p0211_restingstate2'   2   14
%     'p1711_restingstate'    2   19
%     'p0112_restingstate'	1   9
%     'p0711_restingstate'    2   15
%     %    'p0211V2_restingstate'	2   16
%     'p0311_restingstate2'   0   7
%     'p0911_restingstate'    1   10
%     'p1311_restingstate'    0   8
%     'p1611_restingstate'    0   7   1
%     'p1911_restingstate'    1   9
%     'p2011_restingstate'    1   8
%     'p0312_restingstate'    1   8
%     'p0512_restingstate'    0   0
%     'p1511v2_restingstate'  0   0
%     'p71v3_restingstate'    0   0
%     'p0712_restingstate'    0   0
%     'p1012_restingstate'    0   0
%     %    'p1311v2_restingstate'  0   0
%     };

% overnight = {
%     'p2_overnight1_noalpha_chunk1'  0
%     'p2_overnight1_noalpha_chunk2'  0
%     'p2_overnight1_noalpha_chunk3'  0
%     'p2_overnight1_noalpha_chunk4'  0
%     'p2_overnight1_noalpha_chunk5'  0
%     'p2_overnight1_noalpha_chunk6'  0
%     
%     'p2_overnight2_alpha_chunk1'    1
%     'p2_overnight2_alpha_chunk2'    1
%     'p2_overnight2_alpha_chunk3'    1
%     'p2_overnight2_alpha_chunk4'    1
%     'p2_overnight2_alpha_chunk5'    1
%     'p2_overnight2_alpha_chunk6'    1
%     };

allsubj = cat(1,patlist,ctrllist);
newsubj = cat(1,patlist,newctrllist);