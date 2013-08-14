subjlist = {
%     'p0612_restingstate'
%     'p0812_restingstate1'
%     'p0812_restingstate2'
%     'p0912_restingstate'
%     'p0113_restingstate'
%     'p0213_restingstate'
%     'p0612v2_restingstate'
%     'p0611v2_restingstate' %noisy
%     'p0313_restingstate' %noisy
%     'p0512v2_restingstate' %noisy
    'p0712v2_restingstate'
    'p0413_restingstate'
    'p0613_restingstate'
    };

patlist = {
    %
    % patients
    
    'p0211_restingstate1'   1   12  1   ''
    'p0311_restingstate1'   0   6   0   ''
    'p0411_restingstate1'   0   6   0   ''
    'p0511_restingstate'    1   9   1   ''
    'p0611_restingstate'    0   8   1   ''
    'p0710V2_restingstate'  2   14  1   ''
    'p0711_restingstate'    2   15  0   ''
    'p0811_restingstate'    1   10  0   ''
    'p0911_restingstate'    1   11  1   ''
    'p1011_restingstate'    1   10  0   ''
    'p1311_restingstate'    0   8   0   ''
    'p1511_restingstate'    1   10  1   ''
    'p1611_restingstate'    0   7   1   ''
    'p0510V2_restingstate'  0   6   0   ''
    'p1711_restingstate'    2   17  0   ''
    'p1811_restingstate'    1   12  0   ''
    'p1911_restingstate'    1   9   0   ''
    'p2011_restingstate'    0   7   0   ''
    'p0112_restingstate'	1   9   1   ''
    'p0212_restingstate'    1   12  0   ''
    'p0312_restingstate'    0   8   1   ''
    'p0512_restingstate'    1   8   1   ''
    'p0612_restingstate'    0   8   0   ''
    'p71v3_restingstate'    0   8   0   ''
    'p0712_restingstate'    0   7   0   ''
    'p0812_restingstate1'   1   7   1   ''
    'p1012_restingstate'    2   13  1   ''
    'p0113_restingstate'    0   7   0   ''
    'p0213_restingstate'    2   18  0   ''
    'p0313_restingstate'    0   7   0   '' %noisy
%     'p0413_restingstate'    2   14  0   ''
%     'p0613_restingstate'    0   8   0   ''
    
    %follow-ups
    'p0411V2_restingstate'  0   8   0   'p0411_restingstate1' %noisy
    'p0511V2_restingstate'  1   10  0   'p0511_restingstate' %noisy
    'p0311V2_restingstate'  0   8   0   'p0311_restingstate1'
    'p0211V2_restingstate'	2   16  1   'p0211_restingstate1'
    'p1811v2_restingstate'  2   20  0   'p1811_restingstate'
    'p1511v2_restingstate'  1   10  0   'p1511_restingstate'
    'p1311v2_restingstate'  0   8   0   'p1311_restingstate'
    'p0612v2_restingstate'  0   7   0   'p0612_restingstate'
    'p0611v2_restingstate'  1   11  0   'p0611_restingstate' %noisy
    'p0512v2_restingstate'  0   8   0   'p0512_restingstate' %noisy
%     'p0712v2_restingstate'  0   7   0   'p0712_restingstate'
    
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
    
    %     'jenny_restingstate'
    %     %'SaltyWater_restingstate'
    'NW_restingstate'   3  25   2   ''
    'p37_restingstate'  3  25   2     ''
    'p38_restingstate'  3  25   2     ''
    'p40_restingstate'  3  25   2     ''
    'p41_restingstate'  3  25   2     ''
    'p42_restingstate'  3  25   2     ''
    'p43_restingstate'  3  25   2     ''
    'p44_restingstate'  3  25   2     ''
    'p45_restingstate'  3  25   2     ''
    'p46_restingstate'  3  25   2     ''
    'p47_restingstate'  3  25   2     ''
    'p48_restingstate'  3  25   2     ''
    'p49_restingstate'  3  25   2     ''
    % 'p50_restingstate'
    'subj01_restingstate'  3    25   2     ''
    'subj02_restingstate'  3    25   2     ''
    'VS_restingstate'  3  25   2     ''
    'SS_restingstate'  3  25   2     ''
    'SB_restingstate'  3  25   2     ''
    'ML_restingstate'  3  25   2     ''
    'MC_restingstate'  3  25   2     ''
    'JS_restingstate'  3  25   2     ''
    % 'FD_restingstate'
    'ET_restingstate'  3  25   2     ''
    'EP_restingstate'  3  25   2     ''
    % 'CS_restingstate'  ''
    'CL_restingstate'  3  25   2     ''
    'CD_restingstate'  3  25   2     ''
    'AC_restingstate'  3  25   2     ''
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

overnight = {
    'p2_overnight1_noalpha_chunk1'  0
    'p2_overnight1_noalpha_chunk2'  0
    'p2_overnight1_noalpha_chunk3'  0
    'p2_overnight1_noalpha_chunk4'  0
    'p2_overnight1_noalpha_chunk5'  0
    'p2_overnight1_noalpha_chunk6'  0
    
    'p2_overnight2_alpha_chunk1'    1
    'p2_overnight2_alpha_chunk2'    1
    'p2_overnight2_alpha_chunk3'    1
    'p2_overnight2_alpha_chunk4'    1
    'p2_overnight2_alpha_chunk5'    1
    'p2_overnight2_alpha_chunk6'    1
    };

allsubj = cat(1,patlist,ctrllist);