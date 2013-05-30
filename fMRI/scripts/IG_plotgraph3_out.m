% IG 20/11/84 Plots Balls with wights of connections
%close all
clear all
Homedir = fullfile('C:','Users','Ithabi','Documents');%'/home/ig300/'
WcorFile = [Homedir filesep 'results' filesep 'Wcor_168_CI.mat'];
load(WcorFile);

plotqt = 0.97;
Subj = [1 2 3 5 7 8 12 14 16 19 20 21];

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
lwrange = [0.1 3];

% range of point sizes
ptrange = [10 300];

for i = 1%1:length(Subj) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear vsize matrix plotqt
    isubj = Subj(i);

NetwFile = [Homedir filesep 'Subject\redes\' int2str(isubj) '_networks.mat']
load(NetwFile)
networks = netwOut;
nodelocs = networks(:,[2 3 4]);
networks = networks(:,1);
%%%%%%
plotnets =  1:7%6 ;%
plotballs = zeros(size(networks));
for p = 1:length(plotnets)
    plotballs = plotballs + networks.*(networks == plotnets(p));
end
plotidx = logical(plotballs);

minfo = networks;
%minfo = ones(1,length(chanlocs));

%%%%%%%
matrixVar = Wcor(1,isubj).out.sorted_FDR_r;
    matrix = abs(matrixVar);
    plotqt = 0.97;
    origmatrix = matrix;
    
    for c = 1:size(nodelocs,1)
        vsize(c) = length(nonzeros(matrix(c,:)));
    end
    vsize = vsize - min(vsize);
    vsize = vsize/max(vsize);
    
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
    end
    
    h_leg = legend('show');
    set(h_leg,'FontSize',18,'FontWeight','bold');
    view(270,0); %determines from which angle I see the image
    %saveas(gcf,[Homedir '\Figures\Balls\' int2str(i) '_' int2str(isubj) '.jpg'])
end %i