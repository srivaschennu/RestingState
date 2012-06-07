subjlist = {
%     'subj01_restingstate'
%     'subj02_restingstate'
%     'p37_restingstate'
%     'p38_restingstate'
%     'p40_restingstate'
%     'p41_restingstate'
%     'p42_restingstate'
%     'p43_restingstate'
%     'p44_restingstate'
%     'p45_restingstate'
%     'p46_restingstate'
%     'p47_restingstate'
%     'p48_restingstate'
%     'p49_restingstate'
%     'p50_restingstate'
%     'p0211_restingstate1'
%     'p0211_restingstate2'
%     'p0211_restingstate1'
%     'p0311_restingstate2'
%     'p0411_restingstate1'
%     'p0411_restingstate2'
%     'p0511_restingstate'
%     'p0611_restingstate'
%     'p0711_restingstate'
%     'p0811_restingstate'
%     'p0911_restingstate'
%     'p1011_restingstate'
%     'p1511_restingstate'
%     'p1611_restingstate'
%     'p0510v2_restingstate'
%     'p0710v2_restingstate'
    
    'p1711_restingstate'
    'p1811_restingstate'
    'p1911_restingstate'
    'p0411V2_restingstate'
    'p0710v2_restingstate'
    };

for subjidx = 1:length(subjlist)
    subjname = subjlist{subjidx};
    
    dataimport(subjname);
    preprocess(subjname);
    computeic(subjname);
end