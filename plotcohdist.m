function plotcohdist

load alldata
load chanlist

chandist = chandist ./ max(chandist(:));

chandist = chandist(:);
uniqcd = unique(chandist);
uniqcd = linspace(uniqcd(1),uniqcd(end),75);

figure; hold all;
for g = 0:2
    groupcoh = squeeze(allcoh(grp == g,3,:,:));
    plotvals = zeros(1,length(uniqcd)-1);
    
    for u = 1:length(uniqcd)-1
        selvals = (chandist > uniqcd(u) & chandist <= uniqcd(u+1));
        for s = 1:size(groupcoh,1)
            cohmat = squeeze(groupcoh(s,:,:));
            cohmat = cohmat(:);
            cohmat = cohmat(selvals);
            plotvals(u) = plotvals(u) + sum(cohmat);
        end
        plotvals(u) = plotvals(u)/(sum(selvals)*size(groupcoh,1));
        
        %         if (sum(chandist >= uniqcd(u)) <= sum(chandist < uniqcd(u)))
        %             fprintf('Median distance = %.2f.\n',uniqcd(u));
        %             break
        %         end
    end
    
    plot(uniqcd(1:end-1),plotvals);
end
