function calcgraph(listname,conntype,varargin)

loadpaths
loadsubj

param = finputcheck(varargin, {
    'randomise', 'string', {'on','off'}, 'off'; ...
    'latticise', 'string', {'on','off'}, 'off'; ...
    'numrand', 'integer', [], 50; ...
    'rewire', 'integer', [], 50; ...
    'heuristic', 'integer', [], 50; ...
    });

load chanlist
chandist = chandist / max(chandist(:));

subjlist = eval(listname);

tvals = 0.5:-0.025:0.1;

if strcmp(param.randomise,'on')
    savename = sprintf('%s/%s/graphdata_%s_rand_%s.mat',filepath,conntype,listname,conntype);
    numruns = param.numrand;
elseif strcmp(param.latticise,'on')
    distdiag = repmat(1:length(sortedlocs),[length(sortedlocs) 1]);
    for d = 1:size(distdiag,1)
        distdiag(d,:) = abs(distdiag(d,:) - d);
    end
    distdiag = distdiag ./ max(distdiag(:));
    savename = sprintf('%s/%s/graphdata_%s_latt_%s.mat',filepath,conntype,listname,conntype);
    numruns = param.numrand;
else
    savename = sprintf('%s/%s/graphdata_%s_%s.mat',filepath,conntype,listname,conntype);
    numruns = 1;
end

graph{1,1} = 'clustering';
graph{2,1} = 'characteristic path length';
graph{3,1} = 'global efficiency';
graph{4,1} = 'modularity';
graph{5,1} = 'modules';
graph{6,1} = 'centrality';
graph{7,1} = 'modular span';
graph{8,1} = 'participation coefficient';
graph{9,1} = 'connection density';
graph{10,1} = 'mutual information';

%load(savename);

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};

    fprintf('Processing %s',basename);
    
    load([filepath conntype filesep basename conntype 'fdr.mat']);
    
    [sortedchan,sortidx] = sort({chanlocs.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    matrix = matrix(:,sortidx,sortidx);
    if strcmp(param.randomise,'on')
        bootmat = bootmat(:,sortidx,sortidx,:);
    end
    %     pval = pval(:,sortidx,sortidx);
    
    chanlocs = chanlocs(sortidx);
    %     chanXYZ = [cell2mat({chanlocs.X})' cell2mat({chanlocs.Y})' cell2mat({chanlocs.Z})'];
    
    for f = 1:size(matrix,1)
        for iter = 1:numruns
            fprintf(' %d',iter);
            if strcmp(param.randomise,'on')
                %randomisation
                cohmat = squeeze(bootmat(f,:,:,iter));
            else
                cohmat = squeeze(matrix(f,:,:));
            end
            cohmat(isnan(cohmat)) = 0;
            cohmat = abs(cohmat);
            
            for thresh = 1:length(tvals)
                %             fprintf(' %.2f',tvals(thresh));
                weicoh = threshold_proportional(cohmat,tvals(thresh));
%                 bincoh = double(threshold_proportional(cohmat,tvals(thresh)) ~= 0);
                
                %%%%%%  WEIGHTED %%%%%%%%%
                
                allcc{iter}(thresh,:) = clustering_coef_wu(weicoh);
                allcp{iter}(thresh) = charpath(distance_wei(weight_conversion(weicoh,'lengths')));
                alleff{iter}(thresh) = efficiency_wei(weicoh);
                allbet{iter}(thresh,:) = betweenness_wei(weight_conversion(weicoh,'lengths'));
                allden{iter}(thresh) = density_und(weicoh);
                
                for i = 1:param.heuristic
                    [Ci, allQ{iter}(thresh,i)] = modularity_louvain_und(weicoh);
                    
                    allCi{iter}(thresh,i,:) = Ci;
                    
                    modspan = zeros(1,max(Ci));
                    for m = 1:max(Ci)
                        if sum(Ci == m) > 1
                            distmat = chandist(Ci == m,Ci == m) .* weicoh(Ci == m,Ci == m);
                            distmat = nonzeros(triu(distmat,1));
                            modspan(m) = sum(distmat)/sum(Ci == m);
                        end
                    end
                    allms{iter}(thresh,i) = max(nonzeros(modspan));
                    
                    allpc{iter}(thresh,i,:) = participation_coef(weicoh,Ci);
                end
            end
        end
        
        for iter = 1:numruns
            for thresh = 1:length(tvals)
                %clustering coeffcient
                graph{1,2}(s,f,thresh,1:length(chanlocs),iter) = allcc{iter}(thresh,:);
                
                %characteristic path length
                graph{2,2}(s,f,thresh,iter) = allcp{iter}(thresh);
                
                %global efficiency
                graph{3,2}(s,f,thresh,iter) = alleff{iter}(thresh);
                
                % modularity
                graph{4,2}(s,f,thresh,iter) = mean(allQ{iter}(thresh,:));
                
                % community structure
                graph{5,2}(s,f,thresh,1:length(chanlocs),iter) = squeeze(allCi{iter}(thresh,1,:));
                
                %betweenness centrality
                graph{6,2}(s,f,thresh,1:length(chanlocs),iter) = allbet{iter}(thresh,:);
                
                %modular span
                graph{7,2}(s,f,thresh,iter) = mean(allms{iter}(thresh,:));
                
                %participation coefficient
                graph{8,2}(s,f,thresh,1:length(chanlocs),iter) = mean(squeeze(allpc{iter}(thresh,:,:)));
                
                %connection density
                graph{9,2}(s,f,thresh,iter) = allden{iter}(thresh);
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %                 %BINARY
                %
                %                 for i = 1:param.heuristic
                %                     [Ci, allQ(i)] = modularity_louvain_und(bincoh);
                %
                %                     modspan = zeros(1,max(Ci));
                %                     for m = 1:max(Ci)
                %                         if sum(Ci == m) > 1
                %                             distmat = chandist(Ci == m,Ci == m) .* bincoh(Ci == m,Ci == m);
                %                             distmat = nonzeros(triu(distmat,1));
                %                             modspan(m) = sum(distmat)/sum(Ci == m);
                %                         end
                %                     end
                %                     allms(i) = max(nonzeros(modspan));
                %
                %                     allpc(i,:) = participation_coef(bincoh,Ci);
                %                 end
                %
                %                 %clustering coefficient
                %                 graph{1,3}(s,f,thresh,1:length(chanlocs),iter) = clustering_coef_bu(bincoh);
                %
                %                 %characteristic path length
                %                 graph{2,3}(s,f,thresh,iter) = charpath(distance_bin(bincoh));
                %
                %                 %global efficiency
                %                 graph{3,3}(s,f,thresh,iter) = efficiency_bin(bincoh);
                %
                %                 %modularity
                %                 graph{4,3}(s,f,thresh,iter) = mean(allQ);
                %
                %                 %community structure
                %                 graph{5,3}(s,f,thresh,1:length(chanlocs),iter) = Ci;
                %
                %                 %betweenness centrality
                %                 graph{6,3}(s,f,thresh,1:length(chanlocs),iter) = betweenness_bin(bincoh);
                %
                %                 %modular span
                %                 graph{7,3}(s,f,thresh,iter) = mean(allms);
                %
                %                 %participation coefficient
                %                 graph{8,3}(s,f,thresh,1:length(chanlocs),iter) = mean(allpc);
                %
                %                 %connection density
                %                 graph{9,3}(s,f,thresh,iter) = density_und(bincoh);
                %
                %                 %             %rentian scaling
                %                 %             [N, E] = rentian_scaling(bincoh,chanXYZ,5000);
                %                 %             E = E(N<size(bincoh,1)/2);
                %                 %             N = N(N<size(bincoh,1)/2);
                %                 %             b = robustfit(log10(N),log10(E));
                %                 %             graph{9,3}(s,f,thresh) = b(2);
                %
                %
                %                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
    end
    fprintf('\n');
    grp(s,1) = subjlist{s,2};
    save(savename, 'graph', 'grp', 'tvals', 'subjlist');
end
