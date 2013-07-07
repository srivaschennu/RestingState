function [b,stat] = plotdeg(group)

load alldata_allsubj

normdeg = zeros(1,91);
groupcoh = squeeze(allcoh(grp == 3,3,:,:));
for s = 1:size(groupcoh,1)
    normdeg = normdeg + + mean(squeeze(groupcoh(s,:,:)),1);%degrees_und(squeeze(groupcoh(s,:,:))); %
end
normdeg = normdeg / size(groupcoh,1);

figure; hold all
for g = group
    groupcoh = squeeze(allcoh(grp == g,3,:,:));
    b = zeros(size(groupcoh,1),2);
    stat = zeros(size(groupcoh,1),4);
    for s = 1:size(groupcoh,1)
        inddeg = mean(squeeze(groupcoh(s,:,:)),1); %degrees_und(squeeze(groupcoh(s,:,:)));%
        scatter(normdeg,inddeg-normdeg);
        lsline
        [b(s,:),~,~,~,stat(s,:)] = regress(inddeg'-normdeg',[normdeg' ones(91,1)]);
    end
end