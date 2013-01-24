% IG 20/11/84 Plots Balls with wights of connections
%close all
clear all

Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
NetwFile = [Homedir filesep 'results' filesep 'networks.mat'];
WcorFile = [Homedir filesep 'results' filesep 'Wcor_168_CI.mat'];
degDistFile = [Homedir filesep 'results' filesep 'degdist.mat'];
wtDistFile = [Homedir filesep 'results' filesep 'wtdist.mat'];

load(WcorFile);
load(NetwFile)
load(degDistFile);
load(wtDistFile);

nodelocs = networks(:,[2 3 4]);
networks = networks(:,1);
plotqt = 0.97; %defined further down again
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];

%%%%% PLOT PARAMETERS
if ~exist('plotqt','var') || isempty(plotqt)
    plotqt = 0.90; %defined further down again
end

%%%%% VISUAL FEATURES

% text attributes
fontname = 'Gill Sans';
fontsize = 16;
fontweight = 'bold';

% range of line widths
lwrange = [0.1 3];

% range of point sizes
ptrange = [10 300];

%%%%%%
plotnets =  1:7
plotballs = zeros(size(networks));
for p = 1:length(plotnets)
    plotballs = plotballs + networks.*(networks == plotnets(p));
end
plotidx = logical(plotballs);

minfo = networks;
%minfo = ones(1,length(chanlocs));

for i = 6%1:length(Subj)
    clear vsize matrix plotqt
    isubj = Subj(i);
    matrixVar = Wcor(1,isubj).corrected.sorted_FDR_r;
    matrix = abs(matrixVar);
    
    plotqt = 0.97;
    origmatrix = matrix;
    
    %calculate z-scores of weights and weighted node degrees
    wtdist = wtdist(wtdist > 0);
    vsize = (mean(matrix,1) - min(degdist))/(max(degdist) - min(degdist));
    vsize(vsize < 0) = 0;
    
    matrix = (matrix - min(wtdist))/(max(wtdist) - min(wtdist));
    matrix(matrix < 0) = 0;
    
    % keep only top <plotqt> quantile of weights and rescale them to be between 0 and 1
    plotqt = quantile(nonzeros(matrix),plotqt);
    matrix(matrix < plotqt) = 0;
    
    % plot figure
    figure('Color','white','Name',mfilename);
    
    colormap(hsv);
    cmap = colormap;
    
    num_mod = max(minfo);
    vcol = cmap(round((minfo/num_mod)*size(cmap,1)),:);
    
    hScat = scatter3(nodelocs(plotidx,1),nodelocs(plotidx,2),nodelocs(plotidx,3),...
        ptrange(1)+(vsize(plotidx)*(ptrange(2)-ptrange(1))), vcol(plotidx,:), 'filled', 'MarkerEdgeColor', [0.1 0.1 0.1]);
    hAnnotation = get(hScat,'Annotation');
    hLegendEntry = get(hAnnotation,'LegendInformation');
    set(hLegendEntry,'IconDisplayStyle','off')
    
    set(gca,'Visible','off','DataAspectRatioMode','manual',...
        'XLim',([min(nodelocs(:,1)) max(nodelocs(:,1))]),...
        'YLim',([min(nodelocs(:,2)) max(nodelocs(:,2))]),...
        'ZLim',([min(nodelocs(:,3)) max(nodelocs(:,3))]));
    
    for r = 1:size(matrix,1)
        for c = 1:size(matrix,2)
            if r < c && matrix(r,c) > 0
                if plotidx(r) && plotidx(c)
                    if minfo(r) == minfo(c)
                        ecol = cmap(round((minfo(r)/num_mod)*size(cmap,1)),:);
                        hLine = line([nodelocs(r,1) nodelocs(c,1)],[nodelocs(r,2) nodelocs(c,2)],...
                            [nodelocs(r,3) nodelocs(c,3)],'Color',ecol,'LineWidth',...
                            lwrange(1)+(matrix(r,c)*(lwrange(2)-lwrange(1))),'LineStyle','-');
                    else
                        hLine = line([nodelocs(r,1) nodelocs(c,1)],[nodelocs(r,2) nodelocs(c,2)],...
                            [nodelocs(r,3) nodelocs(c,3)],'Color',[0 0 0],'LineWidth',...
                            lwrange(1)+(matrix(r,c)*(lwrange(2)-lwrange(1))),'LineStyle','-');
                    end
                    
                    if matrix(r,c) == max(nonzeros(matrix(plotidx,plotidx))) || matrix(r,c) == min(nonzeros(matrix(plotidx,plotidx)))
                        set(hLine,'DisplayName',sprintf('%.02f',origmatrix(r,c)));
                    else
                        hAnnotation = get(hLine,'Annotation');
                        hLegendEntry = get(hAnnotation,'LegendInformation');
                        set(hLegendEntry,'IconDisplayStyle','off')
                    end
                end
            end
        end
    end
    
    h_leg = legend('show');
    set(h_leg,'FontSize',18,'FontWeight','bold');
    view(270,0); %determines from which angle I see the image
    %saveas(gcf,[Homedir '\Figures\Balls\' int2str(i) '_' int2str(isubj) '.jpg'])
end %i