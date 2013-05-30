% IG 15/10/12 Plot Correlation Figure
clear all
close all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
load([Homedir filesep 'results\Wcor_168_CI.mat']);
Networks = {'Cing';'FP';'DMN';'SM';'Occ';'Cer';'Thal'};
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];
for isubj = 3%:3
    sortedWcor = Wcor(1,isubj).sorted.scale3;
    sortedpVal = Wcor(1,isubj).sorted.pVal3;
    sortedFDR = Wcor(1,isubj).sorted.fdr3;
    
    % plot unsorted correlations
    %     figure
    %     imagesc(Wcor(1,isubj).scale3)

    % plot sorted correlations
    figure
    imagesc(sortedWcor); colorbar; title('sortedWcor')
    
    sortedWcorP = sortedWcor;
    sortedWcorP(sortedpVal >= 0.05) = 0;
    figure
    imagesc(sortedWcorP); colorbar; title('PVal Threshold')
    
    sortedWcorFDR = sortedWcor;
    sortedWcorFDR(sortedFDR >= 0.05) = 0;
    figure
    imagesc(sortedWcorFDR); colorbar; title('FDR Threshold')

    %     figure
    %     imagesc(sortedFDR); colorbar

    % put in network info
    hold on
    x = [33,54,88,121,142,161,168];
    y = [0 169];
    for i = 1:6
        line([x(i) x(i)],y)
        line(y,[x(i) x(i)])
    end
    legend(Networks)
    colorbar
end %isubj
