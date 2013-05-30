%IG 15/01/13 take correlation of bandpower average and DMN
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
fidex = [Resultsdir 'T-test.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
load('graphdata.mat')
load('bandpower.mat')

for inet = 2%1:4
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    for ifreq = 2%1:5
        banddata = mean(bandpower(:,ifreq,:),3); % was orriginally 2 instead of three, but that was incorrect
        [r,p] = corrcoef(banddata(:,1),patdata(:,1)) %correlation test
        
        xlswrite(fidex,p(2),5,[Value{ifreq} int2str(inet+2)]);
        xlswrite(fidex,r(2),5,[Value{ifreq} int2str(inet+7)]);
    end %ifreq
end %inet