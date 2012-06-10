function plotgraph2(matrix,chanlocs,degdist,wtdist,plotqt)

%%%%% PLOT PARAMETERS
if ~exist('plotqt','var') || isempty(plotqt)
plotqt = 0.90;
end

%%%%% VISUAL FEATURES
% range of line widths
lwrange = [0.1 6];
fontname = 'Gill Sans';
fontsize = 16;
fontweight = 'bold';

% percentage of top weights to plot
% range of point sizes
ptrange = [50 1000];

minfo = modularity_louvain_und(matrix);
origmatrix = matrix;

%calculate z-scores of weights and weighted node degrees
wtdist = wtdist(wtdist > 0);
vsize = (mean(matrix,1) - min(degdist))/(max(degdist) - min(degdist));
matrix = (matrix - min(wtdist))/(max(wtdist) - min(wtdist));
matrix(matrix < 0) = 0;
%wtdist = (wtdist - min(wtdist))/(max(wtdist) - min(wtdist));

% keep only top <plotqt> quantile of weights and rescale them to be between 0 and 1
plotqt = quantile(nonzeros(matrix),plotqt);
matrix(matrix < plotqt) = 0;

%re-calculate modules after deleting edges below plotqt
%minfo = modularity_louvain_und(matrix);

% plot figure
figure('Color','white','Name',mfilename);

colormap(hsv);
cmap = colormap;

% assign all modules with only one vertex the same colour
num_mod = length(unique(minfo));
% for m = 1:num_mod
%     midx = (minfo == m);
%     if sum(midx) == 1
%         minfo(midx) = num_mod+1;
%     end
% end
% num_mod = max(minfo);

vcol = cmap(round((minfo/num_mod)*size(cmap,1)),:);

hScat = scatter3(cell2mat({chanlocs.X}), cell2mat({chanlocs.Y}), cell2mat({chanlocs.Z}),...
    ptrange(1)+(vsize*(ptrange(2)-ptrange(1))), vcol, 'filled', 'MarkerEdgeColor', [0.1 0.1 0.1]);
hAnnotation = get(hScat,'Annotation');
hLegendEntry = get(hAnnotation,'LegendInformation');
set(hLegendEntry,'IconDisplayStyle','off')
                
set(gca,'Visible','off','DataAspectRatioMode','manual');
view(-90,90);

for r = 1:size(matrix,1)
    for c = 1:size(matrix,2)
        if matrix(r,c) > 0
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

for c = 1:length(chanlocs)
    text(chanlocs(c).X,chanlocs(c).Y,chanlocs(c).Z+0.5,chanlocs(c).labels,...
    'FontName',fontname,'FontWeight',fontweight,'FontSize',fontsize);
end

figpos = get(gcf,'Position');
set(gcf,'Position',[figpos(1) figpos(2) figpos(3)*2 figpos(4)*2]);
h_leg = legend('show');
set(h_leg,'FontSize',18,'FontWeight','bold');