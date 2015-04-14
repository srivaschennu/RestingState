function pipeline(basename)

dataimport(basename);
epochdata(basename);
rejartifacts2([basename '_epochs'],1,4);
computeic([basename '_epochs']);
rejectic(basename);
rejartifacts2(basename,2,3);
calcftspec(basename);
