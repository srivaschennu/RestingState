function pipeline(basename)

dataimport(basename);
epochdata(basename);
rejartifacts2([basename '_epochs'],1,4);
computeic([basename '_epochs']);
rejectic(basename);
rejartifacts2(basename,2,1);
calcftspec(basename);
ftcoherence(basename);

