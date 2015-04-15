function minfo = plotgraph3d(matrix,splinefile,varargin)

% matrix - NxN symmetric connectivity matrix, where N is the number of channels
% splinefile - spline file pre-generated using headplot

% OPTIONAL ARGUMENTS
% plotqt - proportion of strongest edges to plot
% minfo - 1xN module affiliation vector. Will be calculated if unspecified
% legend - whether or not to plot legend with max and min edge weights
% plotinter - whether or not to plot inter-modular edges

param = finputcheck(varargin, {
    'plotqt', 'real', [], 0.7; ...
    'minfo', 'integer', [], []; ...
    'plotinter', 'string', {'on','off'}, 'off'; ...
    'escale', 'real', [], []; ...
    'vscale', 'real', [], []; ...
    });

%%%%% VISUAL FEATURES

% range of line heights
lhfactor = 2;

%%%%%%

matrix(isnan(matrix)) = 0;

% keep only top <plotqt>% of weights
matrix = threshold_proportional(matrix,1-param.plotqt);

for c = 1:size(matrix,1)
    vsize(c) = sum(matrix(c,:))/(size(matrix,2)-1);
end

% calculate modules after thresholding edges
if isempty(param.minfo)
    minfo = modularity_louvain_und(matrix);
else
    minfo = param.minfo;
end

% rescale weights
if isempty(param.escale)
    escale(1) = min(matrix(logical(triu(matrix,1))));
    escale(2) = max(matrix(logical(triu(matrix,1))));
else
    escale = param.escale;
end
matrix = (matrix - escale(1))/(escale(2) - escale(1));
matrix(matrix < 0) = 0;

% rescale degrees
if isempty(param.vscale)
    vscale(1) = min(vsize);
    vscale(2) = max(vsize);
else
    vscale = param.vscale;
end
vsize(vsize < 0) = 0;
vsize = (vsize - vscale(1))/(vscale(2) - vscale(1));

% assign all modules with only one vertex the same colour
modsize = hist(minfo,unique(minfo));
num_mod = sum(modsize > 1);
modidx = 1;
for m = 1:length(modsize)
    if modsize(m) == 1
        minfo(minfo == m) = num_mod + 1;
    else
        minfo(minfo == m) = modidx;
        modidx = modidx + 1;
    end
end
num_mod = length(unique(minfo));

figure('Color','black','Name',mfilename);
colormap(jet);
cmap = colormap;

[~,chanlocs3d] = headplot(vsize,splinefile,'electrodes','off','maplimits',[0 1],'view','frontleft');
hold all
xlim('auto'); ylim('auto'); zlim('auto');

for r = 1:size(matrix,1)
    for c = 1:size(matrix,2)
        if r < c && matrix(r,c) > 0
            eheight = (matrix(r,c)*lhfactor)+1;
            if minfo(r) == minfo(c)
                hLine = plotarc3d(chanlocs3d([r,c],:),eheight);
                ecol = cmap(ceil((minfo(r)/num_mod)*size(cmap,1)),:);
                set(hLine,'Color',ecol,'LineWidth',0.2);
            elseif strcmp(param.plotinter,'on')
                hLine = plotarc3d(chanlocs3d([r,c],:),eheight);
                ecol = [0 0 0];
                set(hLine,'Color',ecol,'LineWidth',0.5);
            end
        end
    end
end

figpos = get(gcf,'Position');
set(gcf,'Position',[figpos(1) figpos(2) figpos(3)*2 figpos(4)*2]);