function pipeline(basename)

dataimport(basename);
epochdata(basename);
rejartifacts([basename '_epochs'],1,4);
computeic([basename '_epochs']);
rejectic(basename);
rejartifacts([basename '_clean'],2,4);
rereference([basename '_clean'],1);
calcftspec(basename);
ftcoherence(basename);
plothead(basename,3);
plotmetric(basename,'median',3);