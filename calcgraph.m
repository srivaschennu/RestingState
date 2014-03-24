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

% load(savename);

allQ = zeros(param.heuristic,1);
allms = zeros(param.heuristic,1);
allpc = zeros(param.heuristic,length(sortedlocs));

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    
    fprintf('Processing %s',basename);
    
    load([filepath conntype filesep basename conntype 'fdr.mat']);
    
    [sortedchan,sortidx] = sort({chanlocs.labels});
    if ~strcmp(chanlist,cell2mat(sortedchan))
        error('Channel names do not match!');
    end
    matrix = matrix(:,sortidx,sortidx);
    %     pval = pval(:,sortidx,sortidx);
    
    chanlocs = chanlocs(sortidx);
    %     chanXYZ = [cell2mat({chanlocs.X})' cell2mat({chanlocs.Y})' cell2mat({chanlocs.Z})'];
    
    for f = 1:3%size(matrix,1)
        cohmat = squeeze(matrix(f,:,:));
        cohmat(isnan(cohmat)) = 0;
        
        for thresh = 1:length(tvals)
            fprintf('.');
            %             fprintf(' %.2f',tvals(thresh));
            weicoh = threshold_proportional(cohmat,tvals(thresh));
            bincoh = double(threshold_proportional(cohmat,tvals(thresh)) ~= 0);
            
            for iter = 1:numruns
                if strcmp(param.randomise,'on')
                    %randomisation
                    randweicoh = null_model_und_sign(weicoh);
                    randbincoh = null_model_und_sign(bincoh);
                elseif strcmp(param.latticise,'on')
                    randweicoh = latmio_und_connected(weicoh,param.rewire,distdiag);
                    randbincoh = latmio_und_connected(bincoh,param.rewire,distdiag);
                else
                    randweicoh = weicoh;
                    randbincoh = bincoh;
                end
                
                %%%%%%  WEIGHTED %%%%%%%%%
                
                for i = 1:param.heuristic
                    [Ci, allQ(i)] = modularity_louvain_und(randweicoh);
                    
                    modspan = zeros(1,max(Ci));
                    for m = 1:max(Ci)
                        if sum(Ci == m) > 1
                            distmat = chandist(Ci == m,Ci == m) .* randweicoh(Ci == m,Ci == m);
                            distmat = nonzeros(triu(distmat,1));
                            modspan(m) = sum(distmat)/sum(Ci == m);
                        end
                    end
                    allms(i) = max(nonzeros(modspan));
                    
                    allpc(i,:) = participation_coef(randweicoh,Ci);
                end
                
                %clustering coeffcient
                graph{1,2}(s,f,thresh,iter,1:length(chanlocs)) = mean(clustering_coef_wu(randweicoh));
                
                %characteristic path length
                graph{2,2}(s,f,thresh,iter) = charpath(distance_wei(1./randweicoh));
                
                %global efficiency
                graph{3,2}(s,f,thresh,iter) = efficiency_wei(randweicoh);
                
                % modularity
                graph{4,2}(s,f,thresh,iter) = mean(allQ);
                
                % community structure
                graph{5,2}(s,f,thresh,iter,1:length(chanlocs)) = Ci;
                
                %betweenness centrality
                graph{6,2}(s,f,thresh,iter,1:length(chanlocs)) = betweenness_wei(1./randweicoh);
                
                %modular span
                graph{7,2}(s,f,thresh,iter) = mean(allms);
                
                %participation coefficient
                graph{8,2}(s,f,thresh,iter,1:length(chanlocs)) = mean(allpc);
                
                %connection density
                graph{9,2}(s,f,thresh,iter) = density_und(randweicoh);
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %BINARY
                
                for i = 1:param.heuristic
                    [Ci, allQ(i)] = modularity_louvain_und(randbincoh);
                    
                    modspan = zeros(1,max(Ci));
                    for m = 1:max(Ci)
                        if sum(Ci == m) > 1
                            distmat = chandist(Ci == m,Ci == m) .* randbincoh(Ci == m,Ci == m);
                            distmat = nonzeros(triu(distmat,1));
                            modspan(m) = sum(distmat)/sum(Ci == m);
                        end
                    end
                    allms(i) = max(nonzeros(modspan));
                    
                    allpc(i,:) = participation_coef(randbincoh,Ci);
                end
                
                %clustering coefficient
                graph{1,3}(s,f,thresh,iter,1:length(chanlocs)) = clustering_coef_bu(randbincoh);
                
                %characteristic path length
                graph{2,3}(s,f,thresh,iter) = charpath(distance_bin(randbincoh));
                
                %global efficiency
                graph{3,3}(s,f,thresh,iter) = efficiency_bin(randbincoh);
                
                %modularity
                graph{4,3}(s,f,thresh,iter) = mean(allQ);
                
                %community structure
                graph{5,3}(s,f,thresh,iter,1:length(chanlocs)) = Ci;
                
                %betweenness centrality
                graph{6,3}(s,f,thresh,iter,1:length(chanlocs)) = betweenness_bin(randbincoh);
                
                %modular span
                graph{7,3}(s,f,thresh,iter) = mean(allms);
                
                %participation coefficient
                graph{8,3}(s,f,thresh,iter,1:length(chanlocs)) = mean(allpc);
                
                %connection density
                graph{9,3}(s,f,thresh,iter) = density_und(randbincoh);
                
                %             %rentian scaling
                %             [N, E] = rentian_scaling(randbincoh,chanXYZ,5000);
                %             E = E(N<size(randbincoh,1)/2);
                %             N = N(N<size(randbincoh,1)/2);
                %             b = robustfit(log10(N),log10(E));
                %             graph{9,3}(s,f,thresh) = b(2);
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
    end
    fprintf('\n');
    grp(s,1) = subjlist{s,2};
    save(savename, 'graph', 'grp', 'tvals', 'subjlist');
end
