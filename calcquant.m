function calcquant(listname)

loadpaths

loadsubj

load chanlist

chandist = chandist(:);
quantiles = quantile(chandist,0:0.1:1);

subjlist = eval(listname);

% degree = zeros(5,length(subjlist)*91);
% weight = zeros(5,length(subjlist)*91*91);

for s = 1:size(subjlist,1)
    basename = subjlist{s,1};
    fprintf('Processing %s.\n',basename);
    
    
    load([filepath basename 'icohfdr.mat']);
    
    [~,sortidx] = sort({chanlocs.labels});
    matrix = matrix(:,sortidx,sortidx);
    pval = pval(:,sortidx,sortidx);
    
    for f = 1:size(matrix,1)
        cohmat = squeeze(matrix(f,:,:));
        cohmat = cohmat(:);
        
        for q = 1:length(quantiles)-1
            quant(s,f,q) = mean(nonzeros(cohmat(chandist > quantiles(q) & chandist <= quantiles(q+1))));
        end
    end
    grp(s,1) = subjlist{s,2};
end

save(sprintf('quantdata_%s.mat',listname), 'quant', 'grp');