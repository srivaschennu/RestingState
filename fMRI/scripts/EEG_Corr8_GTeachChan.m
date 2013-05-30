% IG 22/01/13 Correlate eeg bandpower of channelgroups to fMRI GT measures
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
fidex = [Resultsdir 'Corr.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
Value2 = {'H';'I';'J';'K';'L'};
load('graphdata.mat')
load('bandpowerfmri.mat')

R = zeros(12,91);
for ichan = 1:91 %for each EEG channel
    for inet = 1%:4 %for each Network
        patdata = GraphData(inet:4:end,:); % fMRI data for each subject
        for ifreq = 1%:5 %for each frequency
            banddata(:,:) = bandpower(:,ifreq,ichan); % EEG data for each subject
            for imes = 1:12 % for all the GT measures
                [r,p] = corrcoef(banddata,patdata(:,imes));
                R(imes,ichan) = r(2);
            end % imes
        end %ifreq
    end %inet
end %icg

figure; topoplot(R(1,:),specinfo{1}.chann)

for n = 2%^:16
chanlocs = bigchanlocs{n};
[~,sortidx] = sort({chanlocs.labels});
chanlocSort = chanlocs(sortidx);
end
