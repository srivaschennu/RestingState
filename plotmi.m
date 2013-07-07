function plotmi

load alldata_allsubj

for g = 0:3
    groupcoh = squeeze(allcoh(grp == g,3,:,:));
    nmi = zeros(size(groupcoh,1),size(groupcoh,1));
    
    for u = 1:size(groupcoh,1)
%         udeg = degrees_und(squeeze(groupcoh(u,:,:)));
        udeg = mean(squeeze(groupcoh(u,:,:)));
        for s = 1:size(groupcoh,1)
            if u < s
%                 sdeg = degrees_und(squeeze(groupcoh(s,:,:)));
                sdeg = mean(squeeze(groupcoh(s,:,:)));
%                 [~, nmi(u,s)] = minfo(udeg,sdeg);
                nmi(u,s) = corr(udeg',sdeg');
            end
        end
    end
    figure; imagesc(nmi); colorbar; caxis([-1 1]);
end