newsubj = {
%     'p0713_restingstate'
%     'p0813_restingstate'
    'p0913_restingstate'
%     'p1013_restingstate' % noisy
    'p0114_restingstate'
    };

testlist = {
    % 	'p0311_restingstate1'	0	7	0	''	0
%     'NW_restingstate'   2  25   2     ''    2
    'AC_restingstate'   2  25   2     ''    2
    };

patlist = {
    %
    % patients
    
'p0311_restingstate1'	0		7		0		''		0		0.228442	19262
'p0411_restingstate1'	0		7		0		''		1		0.259748	19277
'p1611_restingstate'	0		7		1		''		1		0.212447	19829
'p0510V2_restingstate'	0		7		0		''		1		0.221375	18744
'p1311_restingstate'	0		8		0		''		1		0.188267	19655
'p2011_restingstate'	0		7		0		''		0		0.198175	20112
'p0612_restingstate'	0		8		0		''		1		0.199048	20174
'p71v3_restingstate'	0		8		0		''		1		0.218903	17680
'p0712_restingstate'	0		7		0		''		0		0.215873	21348
'p0113_restingstate'	0		7		1		''		1		0.225189	21636
'p0313_restingstate'	0		7		1		''		1		0.185676	21675
'p0613_restingstate'	0		8		0		''		1		0.203341	22248
'p0812_restingstate1'	0		7		1		''		1		0.210286	21415
'p0611_restingstate'	1		10		1		''		0		0.190276	19348
'p0312_restingstate'	1		8		1		''		0		0.169976	20466
'p0211_restingstate1'	1		12		1		''		1		0.260806	19219
'p0511_restingstate'	1		9		1		''		0		0.220698	19306
'p0811_restingstate'	1		10		0		''		0		0.182966	19447
'p0911_restingstate'	1		11		1		''		1		0.230025	19475
'p1011_restingstate'	1		10		0		''		1		0.250833	19551
'p1511_restingstate'	1		10		1		''		1		0.202039	19757
'p1811_restingstate'	1		12		0		''		1		0.202443	19953
'p1911_restingstate'	1		9		0		''		1		0.212305	20054
'p0112_restingstate'	1		9		1		''		0		0.214766	20255
'p0212_restingstate'	1		12		0		''		1		0.219258	13676
'p0512_restingstate'	1		8		1		''		1		0.237562	20800
'p0710V2_restingstate'	1		14		1		''		1		0.235221	18872
'p0711_restingstate'	1		15		0		''		1		0.245130	17853
'p1711_restingstate'	1		17		0		''		0		0.239529	16656
'p1012_restingstate'	1		13		1		''		1		0.202452	21482
'p0213_restingstate'	1		19		1		''		1		0.207541	21677
'p0413_restingstate'	1		14		0		''		1		0.216509	22117   
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
    
'NW_restingstate'		2		25		2		''		2		1.000000	0
'p37_restingstate'		2		25		2		''		2		1.000000	0
'p38_restingstate'		2		25		2		''		2		1.000000	0
'p40_restingstate'		2		25		2		''		2		1.000000	0
'p41_restingstate'		2		25		2		''		2		1.000000	0
'p42_restingstate'		2		25		2		''		2		1.000000	0
'p43_restingstate'		2		25		2		''		2		1.000000	0
'p44_restingstate'		2		25		2		''		2		1.000000	0
'p45_restingstate'		2		25		2		''		2		1.000000	0
'p46_restingstate'		2		25		2		''		2		1.000000	0
'p47_restingstate'		2		25		2		''		2		1.000000	0
'p48_restingstate'		2		25		2		''		2		1.000000	0
'p49_restingstate'		2		25		2		''		2		1.000000	0
'subj01_restingstate'	2		25		2		''		2		1.000000	0
'subj02_restingstate'	2		25		2		''		2		1.000000	0
'VS_restingstate'		2		25		2		''		2		1.000000	0
'SS_restingstate'		2		25		2		''		2		1.000000	0
'SB_restingstate'		2		25		2		''		2		1.000000	0
'ML_restingstate'		2		25		2		''		2		1.000000	0
'MC_restingstate'		2		25		2		''		2		1.000000	0
'JS_restingstate'		2		25		2		''		2		1.000000	0
'ET_restingstate'		2		25		2		''		2		1.000000	0
'EP_restingstate'		2		25		2		''		2		1.000000	0
'CL_restingstate'		2		25		2		''		2		1.000000	0
'CD_restingstate'		2		25		2		''		2		1.000000	0
'AC_restingstate'		2		25		2		''		2		1.000000	0
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