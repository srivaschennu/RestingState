function testmeasures(measure,bandidx)

loadsubj

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

trange = [0.6 0.25];
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
crs = cell2mat(patlist(:,3));

fuinfo = zeros(size(patlist,1),1);
for s = 1:size(patlist,1)
    if ~isempty(patlist{s,4})
        fuinfo(s) = find(strcmp(patlist{s,4},patlist(:,1)));
    end
end

% futable = cat(2,crs(logical(fuinfo)) - crs(nonzeros(fuinfo)), ...
%     testdata(logical(fuinfo)) - testdata(nonzeros(fuinfo)));

crs = crs(~logical(fuinfo));
testdata = testdata(~logical(fuinfo));
[rho, pval] = corr(crs,testdata,'type','spearman');
fprintf('Spearman rho = %.2f, p = %.3f.\n',rho,pval);

figure('Color','white');
hold all
scatter(crs,testdata);
lsline
xlabel('CRS-R score');
ylabel(sprintf('%s in %s',measure,bands{bandidx}));

% [rho, pval] = corr(futable(:,1),futable(:,2),'type','spearman');
% fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);
% 
% figure('Color','white');
% hold all
% scatter(futable(:,1),futable(:,2));
% lsline
% xlabel('Change in CRS-R score');
% ylabel(sprintf('Change in %s in %s',measure,bands{bandidx}));
