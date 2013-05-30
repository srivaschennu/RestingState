% -------------------------------------------------------------------------
% IG 22/01/13 Correlate eeg bandpower of all channels to fMRI GT measures
% -------------------------------------------------------------------------
clear all
close all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
cd(Resultsdir)
load('graphdata.mat')
load('bandpowerfmri.mat')
GT = {'mean';'std';'clustering';'efficiency';'modularity';'Nr of modules';'centrality';'clustering';'efficiency';'modularity';'Nr of modules';'centrality'};

% sort channel locations for each subject individually
% -------------------------------------------------------------------------
S = zeros(16,91);
for n = 1:16
    chanlocs = specinfo{n}.chann;
    [~,sortidx] = sort({chanlocs.labels});
    S(n,:) = sortidx;
    chanlocSort = chanlocs(sortidx);
end

% calculate correlations
% -------------------------------------------------------------------------
R = zeros(12,91);
P = zeros(12,91);
banddata = zeros(16,1);
for inet = 2%:4 %2=DMN for each Network
    patdata = GraphData(inet:4:end,:); % fMRI data for each subject
    for ifreq = 3%:5 %3=alpha for each frequency
        for ichan = 1:91 %for each EEG channel
            for isubj = 1:16
                ichanSort = S(isubj,ichan);
                banddata(isubj,1) = bandpower(isubj,ifreq,ichanSort); % EEG data for each subject
            end % isubj
            for imes = 1:12 % for all the GT measures
                [r,p] = corrcoef(banddata,patdata(:,imes));
                R(imes,ichan) = r(2);
                P(imes,ichan) = p(2);
            end % imes
        end %ichan
    end %ifreq
end %inet

% % FDR correction
% % -------------------------------------------------------------------------
% alpha = 0.05;
% [pthresh, p_masked]= fdr(P(1:6,:),alpha);%make vector from matrix
% max(p_masked(:))

% Make Topoplots
% -------------------------------------------------------------------------
a = [1 3 4 5 6 8 9 10 11];
for iGT = 9%a
figure; topoplot(R(iGT,:),chanlocSort); colorbar; set(gcf,'name',GT{iGT})% title('Correlations');
figure; topoplot(P(iGT,:),chanlocSort); title('Significance'); colorbar;caxis([0 0.1]);set(gcf,'name',GT{iGT})
end


