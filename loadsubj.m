subjlist = {
    'p0612_restingstate'
    'p0812_restingstate1'
    'p0812_restingstate2'
    'p0912_restingstate'
    'p0113_restingstate'
    'p0213_restingstate'
    'p0612v2_restingstate'
    'p0611v2_restingstate' %noisy
    'p0313_restingstate' %noisy
    'p0512v2_restingstate' %noisy
    };

ctrllist = {
    %     controls
    
    %     'jenny_restingstate'
    %     %'SaltyWater_restingstate'
    'NW_restingstate'  3  25  ''
    'p37_restingstate'  3  25  ''
    'p38_restingstate'  3  25  ''
    'p40_restingstate'  3  25  ''
    'p41_restingstate'  3  25  ''
    'p42_restingstate'  3  25  ''
    'p43_restingstate'  3  25  ''
    'p44_restingstate'  3  25  ''
    'p45_restingstate'  3  25  ''
    'p46_restingstate'  3  25  ''
    'p47_restingstate'  3  25  ''
    'p48_restingstate'  3  25  ''
    'p49_restingstate'  3  25  ''
    % 'p50_restingstate'
    'subj01_restingstate'  3    25  ''
    'subj02_restingstate'  3    25  ''
    'VS_restingstate'  3  25  ''
    'SS_restingstate'  3  25  ''
    'SB_restingstate'  3  25  ''
    'ML_restingstate'  3  25  ''
    'MC_restingstate'  3  25  ''
    'JS_restingstate'  3  25  ''
    % 'FD_restingstate'
    'ET_restingstate'  3  25  ''
    'EP_restingstate'  3  25  ''
    % 'CS_restingstate'  ''
    'CL_restingstate'  3  25  ''
    'CD_restingstate'  3  25  ''
    'AC_restingstate'  3  25  ''
    };

patlist = {
    %
    % patients
    
    'p0211_restingstate1'   1   12  ''
    'p0311_restingstate1'   0   6  ''
    'p0411_restingstate1'   0   6  ''
    'p0611_restingstate'    0   8  '' %tennis 4
    'p0710V2_restingstate'  2   14  ''
    'p0711_restingstate'    2   15  ''
    'p0811_restingstate'    1   10  ''
    'p0911_restingstate'    1   11  ''
    'p1011_restingstate'    1   10  ''
    'p1311_restingstate'    0   8  ''
    'p1511_restingstate'    1   10  ''
    'p1611_restingstate'    0   7  ''
    'p0510V2_restingstate'  0   6  ''
    'p1711_restingstate'    2   17   ''%severely disabled
    'p1811_restingstate'    1   12  ''
    'p1911_restingstate'    1   9  ''
    'p2011_restingstate'    0   7  ''
    'p0311V2_restingstate'  0   8   'p0311_restingstate1'
    'p0211V2_restingstate'	2   16  'p0211_restingstate1'
    'p0112_restingstate'	1   9  ''
    'p0212_restingstate'    1   12  ''
    'p0312_restingstate'    0   8  '' %tennis 22
    'p0512_restingstate'    1   8  ''
    'p1811v2_restingstate'  2   20  'p1811_restingstate'
    'p0612_restingstate'    0   8  ''
    'p1511v2_restingstate'  1   10  'p1511_restingstate'
    'p71v3_restingstate'    0   8  ''
    'p0712_restingstate'    0   7  ''
    'p0812_restingstate1'   1   7  ''
    'p1012_restingstate'    2   13  ''
    'p1311v2_restingstate'  0   8   'p1311_restingstate'
    'p0113_restingstate'    0   7  ''
    'p0213_restingstate'    2   18  ''
    'p0612v2_restingstate'  0   7   'p0612_restingstate'
    'p0611v2_restingstate'  1   11  'p0611_restingstate'
    'p0313_restingstate'    0   7  ''
    'p0512v2_restingstate'  0   8   'p0512_restingstate'

    % p0211_restingstate2'   2   14 duplicate
    %'p0311_restingstate2'   0   7 duplicate
    %'p0411_restingstate2'   0   7 duplicate

%     'p0511_restingstate'    1   10 %noisy
%     'p0511V2_restingstate'  1   10 %noisy
%     'p0411V2_restingstate'  1   8 %noisy
%     'p2111_restingstate'    1   10 %noisy


    %'p66v4_restingstate' %no data
    %'p0412_restingstate' %no data
    %'p0712v2_restingstate' %no data
    %'p0812v2_restingstate'  0   0 %no data
    
        %'p0912_restingstate' severely disabled
    };

fmrilist = {
    'p0211_restingstate2'   2   14
    'p1711_restingstate'    2   19
    'p0112_restingstate'	1   9
    'p0711_restingstate'    2   15
    %    'p0211V2_restingstate'	2   16
    'p0311_restingstate2'   0   7
    'p0911_restingstate'    1   10
    'p1311_restingstate'    0   8
    'p1611_restingstate'    0   7
    'p1911_restingstate'    1   9
    'p2011_restingstate'    1   8
    'p0312_restingstate'    1   8
    'p0512_restingstate'    0   0
    'p1511v2_restingstate'  0   0
    'p71v3_restingstate'    0   0
    'p0712_restingstate'    0   0
    'p1012_restingstate'    0   0
    %    'p1311v2_restingstate'  0   0
    };

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