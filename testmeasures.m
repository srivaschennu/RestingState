function testmeasures(measure,bandidx)

load graphdata_allsubj_pli
randgraph = load('graphdata_allsubj_pli_rand');

weiorbin = 3;

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

trange = [0.6 0.2];
trange = (tvals <= trange(1) & tvals >= trange(2));

if strcmp(measure,'mutual information')
    testdata = squeeze(mean(mean(graph{mid,weiorbin}(:,grp == 2,bandidx,trange),4),2));
else
    testdata = squeeze(mean(mean(graph{mid,weiorbin}(:,bandidx,trange,:),4),3));
end

% for g = 0:2
%     groupvals = squeeze(mean(mean(graph{mid,3}(grp == g,freq,trange,:),4),3));
%     groupmean(1,g+1) = mean(groupvals,1);
%     groupse(1,g+1) = std(groupvals,[],1)/sqrt(size(groupvals,1));
% end

% [~,~,stats] = anova1(testdata,grp);
% multcompare(stats);

testdata = testdata(grp == 0 | grp == 1);
patlist = subjlist(grp == 0 | grp == 1,:);
crs = cell2mat(patlist(:,3));

v1idx = zeros(size(patlist,1),1);
for s = 1:size(patlist,1)
    if ~isempty(patlist{s,5})
        v1idx(s) = find(strcmp(patlist{s,5},patlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

% futable = cat(2,crs(v2idx) - crs(v1idx), testdata(v2idx) - testdata(v1idx));

futable = cat(2,testdata(v1idx),crs(v2idx) - crs(v1idx));

crs = crs(~v2idx);
testdata = testdata(~v2idx);
[rho, pval] = corr(crs,testdata,'type','spearman');
fprintf('Spearman rho = %.2f, p = %.3f.\n',rho,pval);

figure('Color','white');
hold all
scatter(crs,testdata);
lsline
scatter(crs([4 12 22]),testdata([4 12 22]),'*');
xlabel('CRS-R score');
ylabel(sprintf('%s in %s',measure,bands{bandidx}));

[rho, pval] = corr(futable(:,1),futable(:,2),'type','spearman');
fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);

figure('Color','white');
hold all
scatter(futable(:,1),futable(:,2));
lsline
xlabel(sprintf('Change in %s in %s',measure,bands{bandidx}));
ylabel('Change in CRS-R score');
