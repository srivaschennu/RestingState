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
L=0;

changroups = {{'O1' 'O2'} {'E19' 'E4'}};

banddata = zeros(length(specinfo),length(changroups));
for inet = 1:4
    inet
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    
    for ifreq = 1:5
        for icg = 1%1:length(changroups)
            for isubj = 1:length(specinfo)
                changroup = changroups{icg};
                [~,chanidx] = ismember(changroup,{specinfo{isubj}.chann.labels});
                banddata(isubj,icg,ifreq) = mean(bandpower(isubj,ifreq,chanidx),3);
            end %isubj
            %[r,p] = corrcoef(banddata,patdata(:,1))
        end %icg
    end %ifreq
end %inet