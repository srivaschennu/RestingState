%IG 19/03/13 corr CRS-R with EEG GT & fMRI GT
clear all
Resultsdir = fullfile('C:','Users','Ithabi','Documents','results');
cd(Resultsdir)
fidex = [Resultsdir filesep 'Corr.xlsx']; % filename
Value = {'B';'C';'D';'E';'F'};
Value2 = {'H';'I';'J';'K';'L'};
load('graphdata.mat')
load('EEG_GraphData.mat')
load('CRS_Data.mat')
load('DOC_data.mat')

index = [1 2 4 6 7 8 12 13 14 16]; % for using only TBI patients

% for ifreq = 1:5 % frequencies
%     ifreq
%     EEGdata = EEGData(:,:,ifreq);
%     EEGdata = EEGdata(index,:);
%     for iGT = 1:12 % for all the GT measures
%         [r,p] = corrcoef(EEGdata(:,iGT),CRS(index));
%         xlswrite(fidex,p(2),8,[Value{ifreq} int2str(iGT+2)]);
%         xlswrite(fidex,r(2),8,[Value2{ifreq} int2str(iGT+2)]);
%     end % iGT
% end %ifreq

for inet = 2%1:4 % FP,DMN, SM, OCC
    inet
    patdata = GraphData(inet:4:end,:); % takes FP for each subject
    patdata = patdata(index,:);
    for iGT = 1%1:12 % for all the GT measures
%          [r,p] = corrcoef(CRS,patdata(:,iGT));
        [r,p] = corrcoef(CRS(index),patdata(:,iGT));
         R(iGT)=r(2);
        P_CRS(iGT)=p(2);
%          [r,p] = corrcoef(DOC,patdata(:,iGT));
        [r,p] = corrcoef(DOC(index),patdata(:,iGT));
        R(iGT)=r(2);
        P_DOC(iGT)=p(2);
%         xlswrite(fidex,p(2),9,[Value{inet} int2str(iGT+2)]);
%         xlswrite(fidex,r(2),9,[Value2{inet} int2str(iGT+2)]);
    end % iGT
end % inet
P_CRS
P_DOC
