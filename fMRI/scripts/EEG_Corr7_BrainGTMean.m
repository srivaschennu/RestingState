%IG 15/01/13 take correlation of bandpower average and DMN
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
fidex = [Resultsdir 'T-test.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
Value2 = {'H';'I';'J';'K';'L'};
load('bandpower.mat')
load('GraphWholeBrain.mat')
load('EEG_GD.mat')
L=0;
%patdata = GraphData(inet:4:end,:); % takes FP for each subject
patdata = graphdata;
for ifreq = 1:5
    EEGdata = EEGData(:,:,ifreq);
    %         bandsave(:,:) = bandpower(:,ifreq,:);
    %         banddata = mean(bandsave,2);
    for imes = 1:12 % for all the GT measures
        [r,p] = corrcoef(EEGdata(:,imes),patdata(:,imes));
        
        %[r,p] = corrcoef(banddata,patdata(:,imes));
        xlswrite(fidex,p(2),10,[Value{ifreq} int2str(imes+2+L)]);
        xlswrite(fidex,r(2),10,[Value2{ifreq} int2str(imes+2+L)]);
    end % imes
end %ifreq
L=L+14;

