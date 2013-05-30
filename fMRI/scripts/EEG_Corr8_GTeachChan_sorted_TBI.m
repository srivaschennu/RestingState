% -------------------------------------------------------------------------
% IG 22/01/13 Correlate eeg bandpower of all channels to fMRI GT measures
% -------------------------------------------------------------------------
clear all
close all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
cd(Resultsdir)
load('graphdata.mat')
load('bandpowerfmri.mat')

index = [1 2 4 6 7 8 12 13 14 16];

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
for inet = 1%:4 %1=FP 2=DMN for each Network
    patdata = GraphData(inet:4:end,:); % fMRI data for each subject
    patdata = patdata(index,:);
    for ifreq = 2%:5 %for each frequency
        for ichan = 1:91 %for each EEG channel
            for isubj = 1:16
                ichanSort = S(isubj,ichan);
                banddata(isubj,1) = bandpower(isubj,ifreq,ichanSort); % EEG data for each subject
            end % isubj
            banddata = banddata(index,:);
            for imes = 1:12 % for all the GT measures
                [r,p] = corrcoef(banddata,patdata(:,imes));
                R(imes,ichan) = r(2);
                P(imes,ichan) = p(2);
            end % imes
        end %ichan
    end %ifreq
end %inet

a = [1 2 3 4 5 6 8 9 10 11];
for iGT = 9%a %9=binary efficiency
figure; topoplot(R(iGT,:),chanlocSort); title('Correlations'); colorbar
figure; topoplot(P(iGT,:),chanlocSort); title('Significance'); colorbar;caxis([0 0.1]);
end


