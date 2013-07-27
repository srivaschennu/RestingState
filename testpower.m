function testpower(listname,bandidx)

load(sprintf('alldata_%s.mat',listname));
load chanlist

bands = {
    'delta'
    'theta'
    'alpha'
    'beta'
    'gamma'
    };

grp(grp == 2) = 1;
grp(grp == 3) = 2;

crs = cell2mat(subjlist(:,3));

v1idx = zeros(size(subjlist,1),1);
for s = 1:size(subjlist,1)
    if ~isempty(subjlist{s,5})
        v1idx(s) = find(strcmp(subjlist{s,5},subjlist(:,1)));
    end
end
v2idx = logical(v1idx);
v1idx = nonzeros(v1idx);

groups = unique(grp);

testdata = mean(bandpower(:,bandidx,:),3);
[pval,~,stats] = ranksum(testdata(grp == 0 | grp == 1 & ~v2idx),testdata(grp == 2 & ~v2idx));
fprintf('%s band power: Mann-whitney U = %.2f, p = %.3f.\n',bands{bandidx},stats.ranksum,pval);
    
testdata = mean(bandpower(grp == 0 | grp == 1 & ~v2idx,bandidx,:),3);
[rho,pval] = corr(crs(grp == 0 | grp == 1 & ~v2idx),testdata,'type','spearman');
fprintf('%s band power: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);
    
figure('Color','white'); hold all
scatter(crs(grp == 0 | grp == 1 & ~v2idx),testdata);
xlabel('CRS-R score');
ylabel(sprintf('Power in %s',bands{bandidx}));
    
futable = cat(2,testdata(v1idx),crs(v2idx));

[rho, pval] = corr(futable(:,1),futable(:,2));
fprintf('Follow-up: Spearman rho = %.2f, p = %.3f.\n',rho,pval);

% [b,stats] = robustfit(futable(:,1),futable(:,2));
% fprintf('Robust fit b = %.2f, p = %.3f.\n',b(2),stats.p(2));

figure('Color','white');
hold all
scatter(futable(:,1),futable(:,2));
% plot(sort(futable(:,1)),b(1)+b(2)*sort(futable(:,1)));
xlabel(sprintf('Power in %s',bands{bandidx}));
ylabel('Follow-up CRS-R score');

