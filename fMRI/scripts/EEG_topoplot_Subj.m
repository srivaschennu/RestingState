% IG Plot bandpower of individual Subjects
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
load('bandpowerfmri.mat')

for isubj = [5,9]%1:16
figure; topoplot(bandpower(isubj,3,:),specinfo{isubj}.chann); colorbar;  caxis([-15 15]);
%figure; topoplot(bandpower(isubj,2,:),specinfo{isubj}.chann,'electrodes','labels'); colorbar;  title(['Subj' int2str(isubj)]); %caxis([-15 15]);
end

