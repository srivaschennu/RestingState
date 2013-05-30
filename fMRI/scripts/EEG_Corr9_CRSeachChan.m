% -------------------------------------------------------------------------
% IG 19/03/13 make corr topoplot of CRS & bandpower
% -------------------------------------------------------------------------
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
load('bandpowerfmri.mat')
load('CRS_data.mat')
Freq = {'delta','theta','alpha','beta','gamma'};

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
R = zeros(1,91);
P = zeros(1,91);
banddata = zeros(16,1);
for ifreq = 2:5 %for each frequency
    for ichan = 1:91 %for each EEG channel
        for isubj = 1:16
            ichanSort = S(isubj,ichan);
            banddata(isubj,1) = bandpower(isubj,ifreq,ichanSort); % EEG data for each subject
        end % isubj
        [r,p] = corrcoef(banddata,CRS);
        R(ichan) = r(2);
        P(ichan) = p(2);
    end %ichan
    figure; topoplot(R,chanlocSort); title('Correlations'); colorbar
    saveas (gcf,[Homedir filesep 'Figures' filesep 'CRS_topo' filesep Freq{ifreq} '_Corr.fig'])
    figure; topoplot(P,chanlocSort); title('Significance'); colorbar;caxis([0 0.05]);
    saveas (gcf,[Homedir filesep 'Figures' filesep 'CRS_topo' filesep Freq{ifreq} '_Sig.fig'])
end %ifreq


