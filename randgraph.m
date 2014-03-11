function randgraph(basename,conntype,varargin)

loadpaths

param = finputcheck(varargin, {
    'rewire', 'integer', [], 20; ...
    });

conndata = load([filepath conntype filesep basename conntype 'fdr.mat']);

distdiag = repmat(1:length(conndata.chanlocs),[length(conndata.chanlocs) 1]);
for d = 1:size(distdiag,1)
    distdiag(d,:) = abs(distdiag(d,:) - d);
end
distdiag = distdiag ./ max(distdiag(:));


conndata.randmatrix = zeros(size(conndata.matrix));
conndata.lattmatrix = zeros(size(conndata.matrix));

for f = 1:size(conndata.matrix,1)
    [conndata.randmatrix(f,:,:),eff] = randmio_und_connected(squeeze(conndata.matrix(f,:,:)),param.rewire);
    eff
%     lattmatrix(f,:,:) = latmio_und_connected(squeeze(conndata.matrix(f,:,:)),param.rewire,distdiag);
end

save([filepath conntype filesep basename conntype 'fdr.mat'],'-struct','conndata');