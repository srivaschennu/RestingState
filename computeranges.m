function computeranges(listname,conntype)

loadpaths

load(sprintf('%s/%s/alldata_%s_%s.mat',filepath,conntype,listname,conntype));

plotqt = 0.7;



for bandidx = 1:size(allcoh,2)
    subjcoh  = squeeze(allcoh(:,bandidx,:,:));
    for s = 1:1%size(allcoh,1)
        threshcoh = threshold_proportional(squeeze(subjcoh(s,:,:)),1-plotqt);
        for c = 1:size(threshcoh,2)
            threshdeg(c) = sum(threshcoh(c,:))/(size(threshcoh,1)-1);
        end
        subjeranges(s,:) = [min(nonzeros(threshcoh(:))) max(threshcoh(:))];
        subjvranges(s,:) = [min(nonzeros(threshdeg(:))) max(threshdeg(:))];
    end
    eranges(bandidx,:) = [min(subjeranges(:,1)) max(subjeranges(:,2))];
    vranges(bandidx,:) = [min(subjvranges(:,1)) max(subjvranges(:,2))];
end

save ctrlranges.mat eranges vranges