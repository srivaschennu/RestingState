function batchrun

subjlist = {
    'p0212_restingstate'
    'p0312_restingstate'
    %'p0512_restingstate' %bad
    'p1811v2_restingstate'
    };

for s = 1:length(subjlist)
    basename = subjlist{s};
    
    fprintf('Processing %s.\n',basename);
    
    %dataimport(basename);
    %epochdata(basename);
    
    % rejartifacts2([basename '_epochs'],1,4);
    
    % computeic([basename '_epochs']);
    
    %rejectic(basename);
    %rejartifacts2(basename,2,1);
    
    calcspectra(basename);
end