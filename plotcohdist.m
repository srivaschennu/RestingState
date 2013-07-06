function plotcohdist

load alldata_allsubj
load chanlist

chandist = chandist ./ max(chandist(:));

chandist = chandist(:);
uniqcd = unique(chandist);
uniqcd = linspace(uniqcd(1),uniqcd(end),50);

% figure;
hold all;
for g = 0:1
    groupcoh = squeeze(allcoh(grp == g,3,:,:));
    plotvals = zeros(length(uniqcd)-1,size(groupcoh,1));
    
    for u = 1:length(uniqcd)-1
        selvals = (chandist > uniqcd(u) & chandist <= uniqcd(u+1));
        for s = 1:size(groupcoh,1)
            cohmat = squeeze(groupcoh(s,:,:));
            cohmat = cohmat(:);
            cohmat = cohmat(selvals);
            plotvals(u,s) = mean(cohmat);
        end
        %plotvals(u) = plotvals(u)/(sum(selvals)*size(groupcoh,1));
        
        %         if (sum(chandist >= uniqcd(u)) <= sum(chandist < uniqcd(u)))
        %             fprintf('Median distance = %.2f.\n',uniqcd(u));
        %             break
        %         end
    end
    
    errorbar(uniqcd(1:end-1),mean(plotvals,2),std(plotvals,[],2)/sqrt(size(plotvals,2)));
end