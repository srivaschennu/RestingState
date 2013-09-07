function plotmi(listname,bandidx)

fontname = 'Helvetica';
fontsize = 28;

load(sprintf('graphdata_%s_pli.mat',listname));

weiorbin = 3;
trange = [0.5 0.1];
trange = (tvals <= trange(1) & tvals >= trange(2));

bands = {
    'Delta'
    'Theta'
    'Alpha'
    'Beta'
    'Gamma'
    };

mutinfo = graph{strcmpi('mutual information',graph(:,1)),weiorbin};

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);
mutinfo = mutinfo(~v2idx,~v2idx,:,:);
grp = grp(~v2idx);

groups = unique(grp);

figure('Color','white'); hold all
plotdata = mean(mutinfo(:,:,bandidx,trange),4);
imagesc(plotdata);

for g = 1:length(groups)-1
    groupedge = find(grp == groups(g),1,'last');
    line([groupedge+0.5 groupedge+0.5],ylim,'Color','black','Linewidth',4);
    line(xlim,[groupedge+0.5 groupedge+0.5],'Color','black','Linewidth',4);
end
% colorbar
set(gca,'FontName',fontname,'FontSize',fontsize,'XTick',[],'YTick',[],...
    'XLim',[0.5 size(plotdata,1)+0.5],'YLim',[0.5 size(plotdata,2)+0.5],'YDir','reverse');

% export_fig(gcf,sprintf('figures/NMImap_%s.eps',bands{bandidx}));

export_fig(gcf,sprintf('figures/NMImap_%s.eps',bands{bandidx}),'-opengl');

close(gcf);