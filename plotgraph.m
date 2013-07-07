function plotgraph(matrix,chanlocs,plotqt,minfo)

%%%%% PLOT PARAMETERS
if ~exist('plotqt','var') || isempty(plotqt)
    plotqt = 0.90;
end

%%%%% VISUAL FEATURES

% text attributes
fontname = 'Gill Sans';
fontsize = 16;
fontweight = 'bold';

% range of line widths
lwrange = [0.1 6];

% range of point sizes
ptrange = [10 600];

matrix = zeromean(matrix);
if ~exist('minfo','var') || isempty(minfo)
    minfo = modularity_louvain_und(matrix);
end

% keep only top <plotqt>% of weights and rescale them to be between 0 and 1
origmatrix = matrix;
allval = sort(nonzeros(matrix),'descend');
plotthresh = quantile(allval,plotqt);
matrix = matrix - plotthresh;
matrix(matrix < 0) = 0;
matrix = matrix / max(max(matrix));

figure('Color','white','Name',mfilename);

colormap(hsv);
cmap = colormap;
num_mod = length(unique(minfo));
vcol = cmap(round((minfo/num_mod)*size(cmap,1)),:);

for c = 1:length(chanlocs)
    vsize(c) = length(nonzeros(matrix(c,:)));
end
vsize = vsize - min(vsize);
vsize = vsize/max(vsize);

hScat = scatter3(cell2mat({chanlocs.X}), cell2mat({chanlocs.Y}), cell2mat({chanlocs.Z}),...
    ptrange(1)+(vsize*(ptrange(2)-ptrange(1))), vcol, 'filled', 'MarkerEdgeColor', [0.1 0.1 0.1]);
hAnnotation = get(hScat,'Annotation');
hLegendEntry = get(hAnnotation,'LegendInformation');
set(hLegendEntry,'IconDisplayStyle','off')
                
set(gca,'Visible','off','DataAspectRatioMode','manual');
view(-90,90);

for r = 1:size(matrix,1)
    for c = 1:size(matrix,2)
        if r < c && matrix(r,c) > 0
            if minfo(r) == minfo(c)
                ecol = cmap(round((minfo(r)/num_mod)*size(cmap,1)),:);
                hLine = line([chanlocs(r).X chanlocs(c).X],[chanlocs(r).Y chanlocs(c).Y],...
                    [chanlocs(r).Z chanlocs(c).Z],'Color',ecol,'LineWidth',...
                    lwrange(1)+(matrix(r,c)*(lwrange(2)-lwrange(1))),'LineStyle','-');
            else
                hLine = line([chanlocs(r).X chanlocs(c).X],[chanlocs(r).Y chanlocs(c).Y],...
                    [chanlocs(r).Z chanlocs(c).Z],'Color',[0 0 0],'LineWidth',...
                    lwrange(1)+(matrix(r,c)*(lwrange(2)-lwrange(1))),'LineStyle','-');
            end
            
            if matrix(r,c) == max(nonzeros(matrix)) || matrix(r,c) == min(nonzeros(matrix))
                set(hLine,'DisplayName',sprintf('%.02f',origmatrix(r,c)));
            else
                hAnnotation = get(hLine,'Annotation');
                hLegendEntry = get(hAnnotation,'LegendInformation');
                set(hLegendEntry,'IconDisplayStyle','off')
            end
            
        end
    end
end

% for c = 1:length(chanlocs)
%     text(chanlocs(c).X,chanlocs(c).Y,chanlocs(c).Z+0.5,chanlocs(c).labels,...
%     'FontName',fontname,'FontWeight',fontweight,'FontSize',fontsize);
% end

figpos = get(gcf,'Position');
set(gcf,'Position',[figpos(1) figpos(2) figpos(3)*2 figpos(4)*2]);
legend('show');