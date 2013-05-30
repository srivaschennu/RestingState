% IG 12/11/12 Sort Balls to Networks
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Paoladir = 'C:\Users\Ithabi\Dropbox\Work\Scripts\Cam\Paola\';
%Resultsdir = [Homedir filesep 'results\PropRest_'];
Resultsdir = [Homedir filesep 'results\'];
WcorFile = [Resultsdir 'Wcor_CI.mat'];
redes=load(fullfile(Paoladir,'6redes_168rois.txt'));
load(WcorFile);
load('sortBallsThal');
% [dum sortidx]=sort(redes);
% Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = 1:length(Wcor) %Subj%
    isubj
    %      Wcor(1,isubj).sorted.scale3 =  Wcor(1,isubj).scale3(sortidx,sortidx);
    %      Wcor(1,isubj).sorted.pVal3 = Wcor(1,isubj).pVal(sortidx,sortidx);
%     Wcor(1,isubj).sorted.FDR_p = Wcor(1,isubj).FDR_p(sortidx,sortidx);
%     Wcor(1,isubj).sorted.FDR_r = Wcor(1,isubj).FDR_r(sortidx,sortidx);
    %     %Wcor(1,isubj).sorted.fdr3 = sortedp_fdr;
    
%   timeseries_168(isubj).timeseries_sorted = timeseries_168(isubj).timeseries(:,sortidx);
    
        Wcor(1,isubj).corrected.sorted_scale3 = Wcor(1,isubj).corrected.scale3(sortidxThal,sortidxThal);
        Wcor(1,isubj).corrected.sorted_pVal3 = Wcor(1,isubj).corrected.pVal(sortidxThal,sortidxThal);
        Wcor(1,isubj).corrected.sorted_FDR_p = Wcor(1,isubj).corrected.FDR_p(sortidxThal,sortidxThal);
        Wcor(1,isubj).corrected.sorted_FDR_r = Wcor(1,isubj).corrected.FDR_r(sortidxThal,sortidxThal);
    %     Wcor(1,isubj).out.sorted_scale3 = Wcor(1,isubj).corrected.scale3(sortidx,sortidx);
    %     Wcor(1,isubj).out.sorted_pVal3 = Wcor(1,isubj).corrected.pVal(sortidx,sortidx);
    %     Wcor(1,isubj).out.sorted_FDR_p = Wcor(1,isubj).corrected.FDR_p(sortidx,sortidx);
    %     Wcor(1,isubj).out.sorted_FDR_r = Wcor(1,isubj).corrected.FDR_r(sortidx,sortidx);
%             Wcor(1,isubj).sorted_scale3 = Wcor(1,isubj).scale3(sortidx,sortidx);
%         Wcor(1,isubj).sorted_pVal3 = Wcor(1,isubj).pVal(sortidx,sortidx);
%         Wcor(1,isubj).sorted_FDR_p = Wcor(1,isubj).FDR_p(sortidx,sortidx);
%         Wcor(1,isubj).sorted_FDR_r = Wcor(1,isubj).FDR_r(sortidx,sortidx);
end %isubj
save(WcorFile,'Wcor')
% save('timeseries_168_N16.mat','timeseries_168')