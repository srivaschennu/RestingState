% IG 15/10/12 Plot Correlation Figure
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Networks = {'Cing';'FP';'DMN';'SM';'Occ';'Cer';'Thal'};
WcorFile = [Homedir filesep 'results\Wcor_168_CI.mat'];
load(WcorFile);
LoadSubjects

for isubj = [2,14]%[1,2,3,12,14];%1:21%22%:22
    Image = Wcor(1,isubj).corrected.sorted_FDR_r; % correlation with FDR correction, Balls out and sorted for Netwoks
    figure; imagesc(abs(Image));caxis([0 1]);
    x = [33,54,88,121,142,161,168];
    y = [0 169];
    
    netidx = [1 x];
    for net=1:length(netidx)-1
        netwcor = nonzeros(abs(Image (netidx(net):netidx(net+1)-1,netidx(net):netidx(net+1)-1) ));
        fprintf('%s: %f\n',Networks{net},max(netwcor(:)));
    end
    fprintf('\n');
    
    hold on
    for i = 1:6
        line([x(i) x(i)],y, 'Color','white','LineWidth',2)
        line(y,[x(i) x(i)], 'Color','white','LineWidth',2)
    end
    legend(Networks)
    colorbar; %caxis([0 1]);
    
    %saveas(gcf,[Homedir '\Figures\SortedCorrScaled\' int2str(isubj) '_' Subj{isubj} '.jpg'])
end %isubj
