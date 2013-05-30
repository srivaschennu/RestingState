% IG 12/11/12 Sort Balls to Networks
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Paoladir = 'C:\Users\Ithabi\Dropbox\Work\Scripts\Cam\Paola\';
WcorFile = [Homedir filesep 'results' filesep 'Wcor_168_CI.mat'];
load(WcorFile);
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = Subj
    isubj
    redesFile = [Homedir filesep 'Subject\redes\' int2str(isubj) '_redes'];
    load(redesFile);
    [dum sortidx]=sort(redesOut);
    
%     Wcor(1,isubj).out.sorted_scale3 = Wcor(1,isubj).out.scale3(sortidx,sortidx);
%     Wcor(1,isubj).out.sorted_pVal3 = Wcor(1,isubj).out.pVal(sortidx,sortidx);
%     Wcor(1,isubj).out.sorted_FDR_p = Wcor(1,isubj).out.FDR_p(sortidx,sortidx);
%     Wcor(1,isubj).out.sorted_FDR_r = Wcor(1,isubj).out.FDR_r(sortidx,sortidx);
%     

    % calculate the indexes for networks
    % default: y = [0 169]; x = [33,54,88,121,142]; %only do 4 Networks
    y = [0 size(dum,1)];
    a = find(dum==2);
    b = find(dum==4);
    c = find(dum==6);
    x = [a(1),a(end)+1,b(1),b(end)+1,c(1)];
    Wcor(1,isubj).out.x = x;
    Wcor(1,isubj).out.y = y;   
end %isubj
save(WcorFile,'Wcor')