function plotcohdistfu(listname)

load(sprintf('alldata_%s.mat',listname));
load chanlist
loadsubj

allcoh = allcoh(grp < 3,:,:,:);

fontsize = 16;

chandist = chandist ./ max(chandist(:));

chandist = chandist(:);
uniqcd = unique(chandist);
uniqcd = linspace(uniqcd(1),uniqcd(end),10);

fuinfo = zeros(size(patlist,1),1);
for subj = 1:size(patlist,1)
    if ~isempty(patlist{subj,4})
        fprintf('%s\n',patlist{subj,1});
        figure; hold all
        fuinfo(subj) = find(strcmp(patlist{subj,4},patlist(:,1)));
        groups = [fuinfo(subj) subj];
        for bandidx = 1:3
            subplot(1,3,bandidx); hold all;
            for g = groups
                cohmat = squeeze(allcoh(g,bandidx,:,:));
                cohmat = cohmat(:);
                plotvals = zeros(length(uniqcd)-1,1);
                
                for u = 1:length(uniqcd)-1
                    selvals = (chandist > uniqcd(u) & chandist <= uniqcd(u+1));
                    plotvals(u) = mean(cohmat(selvals));
                end
                plot(uniqcd(1:end-1),plotvals);
            end
            set(gca,'XLim',[uniqcd(1) uniqcd(end-1)],'FontSize',fontsize);
        end
        
        xlabel('Normalised inter-electrode distance','FontSize',fontsize);
        ylabel('Phase lag index','FontSize',fontsize);
        title(sprintf('%d',patlist{subj,3}-patlist{fuinfo(subj),3}));
        set(gcf,'Color','white')
    end
end