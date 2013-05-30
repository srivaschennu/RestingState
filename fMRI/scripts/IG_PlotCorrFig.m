% IG 15/10/12 Plot Correlation Figure
% close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results' filesep 'Wcor_CI.mat'];
%WcorFile = [Homedir filesep 'results' filesep 'PropRest_Wcor_168_CI.mat'];
load(WcorFile);

Networks = {'Cing';'FP';'DMN';'SM';'Occ';'Cer';'Thal'};
% LoadSubjects
%Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = 14%:length(Wcor)%[1,2,3,12,14];%1:21%22%:22
%     Image1 = Wcor(1,isubj).out.sorted_scale3; ImName1 = 'Corr.scale3';
 % Image1 = Wcor(1,isubj).corrected.sorted_scale3; ImName1 = 'Corr.scale3';
%   Image = Wcor(1,isubj).corrected.sorted_pVal3;ImName = 'Corr.pVal3';
      Image1 = Wcor(1,isubj).corrected.sorted_FDR_p;ImName1 = 'Corr.FDR_p';
%     Image1 = Wcor(1,isubj).corrected.sorted_FDR_r;ImName1 = 'Corr.FDR_r';
% Image1 = Wcor(1,isubj).sorted.scale3; ImName1 = 'scale3';
%   Image1 = Wcor(1,isubj).sorted.pVal3; ImName1 = 'pVal3';
%       Image2 = Wcor(1,isubj).sorted.FDR_p;ImName2 = 'FDR_p';
% Image2 = Wcor(1,isubj).sorted.FDR_r;ImName2 = 'FDR_r';
%   Image2 = Wcor(1,isubj).FDR_p;ImName2 = 'FDR_p';
%    Image1 = Wcor(1,isubj).corrected.FDR_p;ImName1 = 'Corr.FDR_p';
       
       
    figure; imagesc(Image1); title(ImName1); hold on %subplot(2,2,1)
    x = [33,54,88,121,142,161,168]; y = [0 169];
    for i = 1:6
        line([x(i) x(i)],y,'color','white','LineWidth',2)
        line(y,[x(i) x(i)],'color','white','LineWidth',2)
    end
    legend(Networks);caxis([0 1]); colorbar; caxis([0 1]); 
    
%     subplot(2,2,2); imagesc(Image2); title(ImName2); hold on
%     x = [33,54,88,121,142,161,168]; y = [0 169];
%     for i = 1:6
%         line([x(i) x(i)],y,'color','black','LineWidth',2)
%         line(y,[x(i) x(i)],'color','black','LineWidth',2)
%     end
%     legend(Networks);caxis([0 1]); colorbar; caxis([0 1]); 
    
 %   saveas(gcf,[Homedir '\Figures\PropRestCorr\' int2str(isubj) '.jpg'])
%saveas(gcf,[Homedir '\Figures\SortedCorrScaled\' int2str(isubj) '_' Subj{isubj} '.jpg'])
end %isubj
