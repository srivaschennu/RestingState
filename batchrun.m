function batchrun

subjlist = {
'p0512_restingstate'
'p1511v2_restingstate'
'p71v3_restingstate'
'p0712_restingstate'
'p1012_restingstate'
'p1311v2_restingstate'
    };

for s = 1:length(subjlist)
    basename = subjlist{s};
    
    fprintf('Processing %s.\n',basename);
    
%     dataimport(basename);
%     epochdata(basename);
    
%    rejartifacts2([basename '_epochs'],1,4);
    
%     computeic([basename '_epochs']);
    
%     rejectic(basename);
%     rejartifacts2(basename,2,1);
    
    %calcspectra(basename);
    plotspec(basename);
    close(gcf);
end