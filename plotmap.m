function plotmap(basename,conntype,bandidx,varargin)

loadpaths

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

param = finputcheck(varargin, {
    'plotqt', 'real', [], []; ...
    'caxis', 'real', [], []; ...
    });

load(sprintf('%s%s/%s%sfdr.mat',filepath,conntype,basename,conntype));

cohmat = squeeze(matrix(bandidx,:,:));
if ~isempty(param.plotqt)
    cohmat = threshold_proportional(cohmat,1-param.plotqt);
end

figure('Color','white');
imagesc(cohmat);
set(gca,'XTick',[],'YTick',[]);

cax = caxis;

if ~isempty(param.caxis)
    if length(param.caxis) == 1
        caxis([param.caxis cax(2)]);
    elseif isnan(param.caxis(1))
        caxis([cax(1) param.caxis(2)]);
    else
        caxis(param.caxis);
    end
end

export_fig(gcf,sprintf('figures/%s_%smap.tif',basename,bands{bandidx}));
close(gcf);

