function plotmi(bandidx)

load graphdata_allsubj_pli

grp(grp == 2) = 1;
grp(grp == 3) = 2;

groups = unique(grp);

weiorbin = 3;

modinfo = graph{strcmp('modules',graph(:,1)),weiorbin};

for g = 1:length(groups)
    groupmod = modinfo(grp == groups(g),:,:,:);
    for t = 1:size(groupmod,3)
        for s1 = 1:size(groupmod,1)
            for s2 = 1:size(groupmod,1)
                if s1 < s2
                    [~, mutinfo(g,t,s1,s2)] = partition_distance(squeeze(groupmod(s1,bandidx,t,:)),squeeze(groupmod(s2,bandidx,t,:)));
                elseif s1 > s2
                    mutinfo(g,t,s1,s2) = mutinfo(g,t,s2,s1);
                elseif s1 == s2
                    mutinfo(g,t,s1,s2) = 0;
                end
            end
        end
    end
end

figure; hold all
for g = 1:length(groups)
    errorbar(1-tvals,mean(mean(mutinfo(g,:,:,:),3),4),...
        std(mean(mutinfo(g,:,:,:),3),[],4)/sqrt(size(mutinfo,4)),...
        'DisplayName',num2str(groups(g)));
end
set(gca,'XLim',1-[tvals(1) tvals(end)]);
legend('show');
