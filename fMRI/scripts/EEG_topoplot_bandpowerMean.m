% IG Plot mean bandpower per frequency
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
load('bandpowerfmri.mat')

for isubj = 9
    figure; topoplot(bandpower(isubj,2,:),specinfo{isubj}.chann); colorbar;  title(['Subj' int2str(isubj)]); %caxis([-15 15]);
end


for ifreq = 1%:5
    bandsave(:,:) = bandpower(:,ifreq,:);
    banddata =  mean(bandsave,2);
    
    figure; topoplot(banddata,specinfo{isubj}.chann); colorbar;  title(['Subj' int2str(isubj)]); %caxis([-15 15]);    
    
end %ifreq