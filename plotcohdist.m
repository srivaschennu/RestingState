function plotcohdist(listname)

load(sprintf('alldata_%s.mat',listname));
load chanlist

fontsize = 16;

grp(grp == 2) = 1;
grp(grp == 3) = 2;
allcoh = squeeze(mean(allcoh,3));

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

grp = grp(~v2idx);
allcoh = allcoh(~v2idx,:,:,:);

groups = unique(grp)';

chandist = chandist ./ max(chandist(:));

chandist = chandist(:);
uniqcd = unique(chandist);
uniqcd = linspace(uniqcd(1),uniqcd(end),10);

figure;

for bandidx = 1:size(allcoh,2)
    subplot(1,size(allcoh,2),bandidx); hold all;
    for g = groups
        groupcoh = squeeze(allcoh(grp == g,bandidx,:,:));
        plotvals = zeros(length(uniqcd)-1,size(groupcoh,1));
        
        for u = 1:length(uniqcd)-1
            selvals = (chandist > uniqcd(u) & chandist <= uniqcd(u+1));
            for s = 1:size(groupcoh,1)
                cohmat = squeeze(groupcoh(s,:,:));
                cohmat = cohmat(:);
                cohmat = cohmat(selvals);
                plotvals(u,s) = mean(cohmat);
            end
        end
        errorbar(uniqcd(1:end-1),mean(plotvals,2),std(plotvals,[],2)/sqrt(size(plotvals,2)),...
            'DisplayName',sprintf('%s (%d)',num2str(g),size(groupcoh,1)));
    end
    set(gca,'XLim',[uniqcd(1) uniqcd(end-1)],'FontSize',fontsize);
end

xlabel('Normalised inter-electrode distance','FontSize',fontsize);
ylabel('Phase lag index','FontSize',fontsize);
legend('show');
set(gcf,'Color','white')