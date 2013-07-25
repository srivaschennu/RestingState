function testmeasures(measure,bandidx)

load graphdata_allsubj_pli
randgraph = load('graphdata_allsubj_rand_pli');

weiorbin = 3;
trange = [0.6 0.2];

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

graph{end+1,1} = 'small-worldness index';
graph{end,2} = ( mean(graph{1,2},4) ./ mean(randgraph.graph{1,2},4) ) ./ ( graph{2,2} ./ randgraph.graph{2,2}) ;
graph{end,3} = ( mean(graph{1,3},4) ./ mean(randgraph.graph{1,3},4) ) ./ ( graph{2,3} ./ randgraph.graph{2,3}) ;

mid = find(strcmp(measure,graph(:,1)));
if isempty(mid)
    error('Measure not found.');
end

grp(grp == 2) = 1;
grp(grp == 3) = 2;

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

trange = (tvals <= trange(1) & tvals >= trange(2));

if strcmp(measure,'mutual information')
    testdata = squeeze(mean(mean(graph{mid,weiorbin}(:,grp == 2,bandidx,trange),4),2));
else
    testdata = squeeze(mean(mean(graph{mid,weiorbin}(:,bandidx,trange,:),4),3));
end

% test patients vs controls group difference
pval = ranksum(testdata(grp == 0 | grp == 1 & ~v2idx),testdata(grp == 2));
fprintf('%s band power patients vs controls: Mann-whitney p = %.3f.\n',bands{bandidx},pval);

testdata = testdata(grp == 0 | grp == 1);
crs = cell2mat(subjlist(:,3));
crs = crs(grp == 0 | grp == 1);
v2idx = v2idx(grp == 0 | grp == 1);

% correlate patients with crs scores
[rho, pval] = corr(crs(~v2idx),testdata(~v2idx),'type','spearman');
fprintf('Spearman rho = %.2f, p = %.3f.\n',rho,pval);

figure('Color','white');
hold all
scatter(crs(~v2idx),testdata(~v2idx));
lsline
xlabel('CRS-R score');
ylabel(sprintf('%s in %s',measure,bands{bandidx}));

% correlate follow-ups
% futable = cat(2,crs(v2idx) - crs(v1idx), testdata(v2idx) - testdata(v1idx));

futable = cat(2,testdata(v1idx), crs(v2idx)-crs(v1idx));

[rho, pval] = corr(futable(:,1),futable(:,2));
fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);

figure('Color','white');
hold all
scatter(futable(:,1),futable(:,2));
lsline
xlabel(sprintf('Change in %s in %s',measure,bands{bandidx}));
ylabel('Change in CRS-R score');
