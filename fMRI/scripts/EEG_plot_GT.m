% plot EEG correlation matrices

Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
load('bigmatfmri.mat')

%sort channels
for n = 1:16
chanlocs = bigchanlocs{n};
[~,sortidx] = sort({chanlocs.labels});
chanlocs = chanlocs(sortidx);
end

load('bigmat')
for isubj = 1%:12
CorrMat(:,:) = bigmat(isubj,3,:,:);
imagesc(CorrMat)
%saveas(gcf,[Homedir '\Figures\EEG_Corr_alpha\' int2str(isubj) '.jpg'])
end %isubj