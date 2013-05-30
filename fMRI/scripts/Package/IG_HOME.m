% IG 11/12/12 Script to call all functions
close all
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\PropRest_'];
WcorFile = [Resultsdir 'Wcor_168_CI.mat'];
load(WcorFile);

%Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = 1:length(Wcor)
    IG_PlotCorrFig(Homedir,Wcor, isubj)
end %isubj