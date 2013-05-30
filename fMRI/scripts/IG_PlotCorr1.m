% IG 15/10/12 Plot Correlation Figure
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
Networks = {'Cing';'FP';'DMN';'SM';'Occ';'Cer';'Thal'};
Paoladir = [Homedir filesep 'scripts/Cam/Paola'];
redes=load(fullfile(Paoladir,'6redes_168rois.txt'));

for isubj = 1%:3
    % plot unsorted correlations
    %     figure
    %     imagesc(Wcor(1,isubj).scale3)

    % plot sorted correlations
    
    [dum sortidx]=sort(redes);
    sortedWcor = Wcor(1,isubj).scale3(sortidx,sortidx);
%     sortedpVal = Wcor(1,isubj).pVal(sortidx,sortidx);

    figure
    imagesc(sortedWcor)
%     sortedWcor(sortedpVal >= 0.05) = 0;
%     figure
%     imagesc(sortedWcor)

    %     figure
    %     imagesc(sortedpVal);

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
