%IG 15/01/13 take correlation of bandpower average and DMN
clear all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
cd(Resultsdir)
fidex = [Resultsdir filesep 'Corr.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
load('graphdata.mat')
load('bandpowerfmri.mat')
load('CRS_data.mat')
load('DOC_data.mat')
for ifreq = 1:5
    banddata = mean(bandpower(:,ifreq,:),3); % was orriginally 2 instead of three, but that was incorrect
    [r,p] = corrcoef(banddata(:,1),DOC); %correlation test
    R1(ifreq) = r(2);
    P1(ifreq) = p(2);
%     xlswrite(fidex,p(2),6,[Value{ifreq} 2]);
%     xlswrite(fidex,r(2),6,[Value{ifreq} 7]);
end %ifreq
for inet = 1:4
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    [r,p] = corrcoef(DOC,patdata(:,1)); %correlation test
    R(inet) = r(2);
    P(inet) = p(2);
%     xlswrite(fidex,p(2),7,int2str(inet+2));
%     xlswrite(fidex,r(2),7,int2str(inet+7));
end %inet