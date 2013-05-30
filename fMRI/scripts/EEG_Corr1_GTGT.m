%IG 15/01/13 save t-test EEG GT & fMRI GT
clear all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
cd(Resultsdir)
fidex = [Resultsdir filesep 'Corr.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
Value2 = {'H';'I';'J';'K';'L'};
load('graphdata.mat')
load('EEG_GraphData.mat')
L=0;

for inet = 1%:4 % FP,DMN, SM, OCC
    inet
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    for ifreq = 1:5 % frequencies
        ifreq
        EEGdata = EEGData(:,:,ifreq);
        for iGT = 1:12 % for all the GT measures
            [r,p] = corrcoef(EEGdata(:,iGT),patdata(:,iGT));
            %xlswrite(fidex,h,2,[Value{k} int2str(iGT+2+L)]);
            xlswrite(fidex,p(2),7,[Value{ifreq} int2str(iGT+2+L)]);
            xlswrite(fidex,r(2),7,[Value2{ifreq} int2str(iGT+2+L)]);
        end % iGT
    end %ifreq
    L=L+14;
end % inet
