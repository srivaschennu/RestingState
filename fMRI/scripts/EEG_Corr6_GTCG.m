% IG 22/01/13 Correlate eeg bandpower of channelgroups to fMRI GT measures
%clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
fidex = [Resultsdir 'Corr.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
Value2 = {'H';'I';'J';'K';'L'};
load('graphdata.mat')
load('bandpowerfmri.mat')
L=0;

for icg = 1%1:2 %1=O1O2 2=F1F2
    for inet = 1:4
        inet
        patdata = GraphData(inet:4:end,:); % takes FP for each subject
        for ifreq = 1:5
            for imes = 1:12 % for all the GT measures
                [r,p] = corrcoef(banddata(:,icg,ifreq),patdata(:,imes));
%                 xlswrite(fidex,p(2),icg+6,[Value{ifreq} int2str(imes+2+L)]);
%                 xlswrite(fidex,r(2),icg+6,[Value2{ifreq} int2str(imes+2+L)]);
xlswrite(fidex,p(2),4,[Value{ifreq} int2str(imes+2+L)]);
                xlswrite(fidex,r(2),4,[Value2{ifreq} int2str(imes+2+L)]);
            end % imes
        end %ifreq
        L=L+14;
    end %inet
end %icg