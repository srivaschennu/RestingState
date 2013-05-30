%IG 15/01/13 take correlation of bandpower average (over two channels?)and fMRI mean
%clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');
Resultsdir = [Homedir filesep 'results\'];
cd(Resultsdir)
fidex = [Resultsdir 'T-test.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
load('graphdata.mat')
load('bandpower.mat')

for inet = 1:4
    inet
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    for ifreq = 1:5
        bandsave(:,:) = bandpower(:,ifreq,:);
        banddata = mean(bandSort(:,82:83),2) %take mean from only two channels?
        
        [r,p] = corrcoef(banddata,patdata(:,1)) %correlation test
        
        xlswrite(fidex,p(2),4,[Value{ifreq} int2str(inet+2)]);
        xlswrite(fidex,r(2),4,[Value{ifreq} int2str(inet+7)]);
    end %ifreq
end %inet