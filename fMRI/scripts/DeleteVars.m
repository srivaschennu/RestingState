% IG 11/12/12 Sort Balls to Networks
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\PropRest_'];
WcorFile = [Resultsdir 'Wcor_168_CI.mat'];
load(WcorFile);

Wcor =  rmfield(Wcor, 'sorted');

save(WcorFile,'Wcor')