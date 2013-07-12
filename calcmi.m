function calcmi

load graphdata_allsubj_pli_rand graph

graph{end+1,1} = 'mutual information';

for weiorbin = 2:3
    modinfo = graph{strcmp('modules',graph(:,1)),weiorbin};
    mutinfo = zeros(size(modinfo,1),size(modinfo,1),size(modinfo,2),size(modinfo,3));
    
    for bandidx = 1:size(modinfo,2)
        for t = 1:size(modinfo,3)
            for s1 = 1:size(modinfo,1)
                for s2 = 1:size(modinfo,1)
                    if s1 < s2
                        [~, mutinfo(s1,s2,bandidx,t)] = ...
                            partition_distance(squeeze(modinfo(s1,bandidx,t,:)),squeeze(modinfo(s2,bandidx,t,:)));
                    elseif s1 > s2
                        mutinfo(s1,s2,bandidx,t) = mutinfo(s2,s1,bandidx,t);
                    elseif s1 == s2
                        mutinfo(s1,s2,bandidx,t) = 0;
                    end
                end
            end
        end
    end
    graph{end,weiorbin} = mutinfo;
end

save graphdata_allsubj_pli_rand graph -append
