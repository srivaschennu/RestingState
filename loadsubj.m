% subjlist = {
%     'p0713_restingstate'
%     'p0813_restingstate'
%     'p0913_restingstate'
%     'p1013_restingstate'
%     'p0114_restingstate'
%     };

% testlist = {
%     % 	'p0311_restingstate1'	0	7	0	''	0
%     'NW_restingstate'   2  25   2     ''    2
%     };

patlist = {
    %
    % patients
    
'p0311_restingstate1'	0		7		0		''		0		0.228442
'p0411_restingstate1'	0		7		0		''		1		0.259748
'p1611_restingstate'	0		7		1		''		1		0.212447
'p0510V2_restingstate'	0		7		0		''		1		0.221375
'p1311_restingstate'	0		8		0		''		1		0.188267
'p2011_restingstate'	0		7		0		''		0		0.198175
'p0612_restingstate'	0		8		0		''		1		0.199048
'p71v3_restingstate'	0		8		0		''		1		0.218903
'p0712_restingstate'	0		7		0		''		0		0.215873
'p0113_restingstate'	0		7		1		''		1		0.225189
'p0313_restingstate'	0		7		1		''		1		0.185676
'p0613_restingstate'	0		8		0		''		1		0.203341
'p0812_restingstate1'	0		7		1		''		1		0.210286
'p0611_restingstate'	1		10		1		''		0		0.190276
'p0312_restingstate'	1		8		1		''		0		0.169976
'p0211_restingstate1'	1		12		1		''		1		0.260806
'p0511_restingstate'	1		9		1		''		0		0.220698
'p0811_restingstate'	1		10		0		''		0		0.182966
'p0911_restingstate'	1		11		1		''		1		0.230025
'p1011_restingstate'	1		10		0		''		1		0.250833
'p1511_restingstate'	1		10		1		''		1		0.202039
'p1811_restingstate'	1		12		0		''		1		0.202443
'p1911_restingstate'	1		9		0		''		1		0.212305
'p0112_restingstate'	1		9		1		''		0		0.214766
'p0212_restingstate'	1		12		0		''		1		0.219258
'p0512_restingstate'	1		8		1		''		1		0.237562
'p0710V2_restingstate'	1		14		1		''		1		0.235221
'p0711_restingstate'	1		15		0		''		1		0.245130
'p1711_restingstate'	1		17		0		''		0		0.239529
'p1012_restingstate'	1		13		1		''		1		0.202452
'p0213_restingstate'	1		19		1		''		1		0.207541
'p0413_restingstate'	1		14		0		''		1		0.216509    
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
    
    'NW_restingstate'	2	25	2	''	2	1.000000
    'p37_restingstate'	2	25	2	''	2	1.000000
    'p38_restingstate'	2	25	2	''	2	1.000000
    'p40_restingstate'	2	25	2	''	2	1.000000
    'p41_restingstate'	2	25	2	''	2	1.000000
    'p42_restingstate'	2	25	2	''	2	1.000000
    'p43_restingstate'	2	25	2	''	2	1.000000
    'p44_restingstate'	2	25	2	''	2	1.000000
    'p45_restingstate'	2	25	2	''	2	1.000000
    'p46_restingstate'	2	25	2	''	2	1.000000
    'p47_restingstate'	2	25	2	''	2	1.000000
    'p48_restingstate'	2	25	2	''	2	1.000000
    'p49_restingstate'	2	25	2	''	2	1.000000
    'subj01_restingstate'	2	25	2	''	2	1.000000
    'subj02_restingstate'	2	25	2	''	2	1.000000
    'VS_restingstate'	2	25	2	''	2	1.000000
    'SS_restingstate'	2	25	2	''	2	1.000000
    'SB_restingstate'	2	25	2	''	2	1.000000
    'ML_restingstate'	2	25	2	''	2	1.000000
    'MC_restingstate'	2	25	2	''	2	1.000000
    'JS_restingstate'	2	25	2	''	2	1.000000
    'ET_restingstate'	2	25	2	''	2	1.000000
    'EP_restingstate'	2	25	2	''	2	1.000000
    'CL_restingstate'	2	25	2	''	2	1.000000
    'CD_restingstate'	2	25	2	''	2	1.000000
    'AC_restingstate'	2	25	2	''	2	1.000000
    %     'jenny_restingstate'
    %     %'SaltyWater_restingstate'
    % 'p50_restingstate'
    % 'FD_restingstate'
    % 'CS_restingstate'  ''
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