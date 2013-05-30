% IG 15/10/12 Plot Correlation Figure
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Networks = {'Cing';'FP';'DMN';'SM';'Occ';'Cer';'Thal'};
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat'];
load(WcorFile);
LoadSubjects

for isubj = [2,14]%[1,2,3,12,14];%1:21%22%:22
Image = Wcor(1,isubj).corrected.sorted_scale3;
% Image3 = Wcor(1,isubj).corrected.sorted_pVal3;
 Image3 = Wcor(1,isubj).corrected.sorted_FDR_p;
  Image2 = Wcor(1,isubj).corrected.sorted_FDR_r;

    %figure; imagesc(abs(Image));colorbar;caxis([0 1]); 
    %figure; imagesc(Image3);colorbar;
    figure; imagesc(abs(Image2));caxis([0 1]); 
    
    hold on
    x = [33,54,88,121,142,161,168];
    y = [0 169];
    for i = 1:6
        line([x(i) x(i)],y, 'Color','white','LineWidth',2)
        line(y,[x(i) x(i)], 'Color','white','LineWidth',2)
    end
    legend(Networks)
    colorbar; %caxis([0 1]); 
    
    %saveas(gcf,[Homedir '\Figures\SortedCorrScaled\' int2str(isubj) '_' Subj{isubj} '.jpg'])
end %isubj
