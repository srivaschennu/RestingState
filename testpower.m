function testpower(listname)

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

crs = crs(~v2idx);
bandpower = bandpower(~v2idx,:,:);
grp = grp(~v2idx);

groups = unique(grp);
barvals = zeros(size(bandpower,2),length(groups));
errvals = zeros(size(bandpower,2),length(groups));
figure('Color','white');
p = 1;
for bandidx = 1:size(bandpower,2)
    for g = 1:length(groups)
        barvals(bandidx,g) = mean(mean(bandpower(grp == groups(g),bandidx,:),3),1);
        errvals(bandidx,g) = std(mean(bandpower(grp == groups(g),bandidx,:),3),[],1)/sqrt(sum(grp == groups(g)));
        
        subplot(size(bandpower,2),length(groups)+1,p); hold all;
        topoplot(squeeze(mean(bandpower(grp == groups(g),bandidx,:),1)),chanlocs,'maplimits','maxmin'); colorbar
        if g == 1
            title(bands{bandidx});
        end
        if bandidx == 1
            text(0,0,num2str(groups(g)));
        end
        p = p+1;
    end
    testdata = mean(bandpower(:,bandidx,:),3);
    pval = ranksum(testdata(grp == 0 | grp == 1),testdata(grp == 2));
    fprintf('%s band power: Mann-whitney p = %.3f.\n',bands{bandidx},pval);
    
    testdata = mean(bandpower(grp == 0 | grp == 1,bandidx,:),3);
    [rho,pval] = corr(crs(grp == 0 | grp == 1),testdata,'type','spearman');
    fprintf('%s band power: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);
    
    subplot(size(bandpower,2),length(groups)+1,p); hold all;
    scatter(crs(grp == 0 | grp == 1),testdata);
    lsline
    xlabel('CRS-R score');
    ylabel(sprintf('Power in %s',bands{bandidx}));
    p = p+1;
    
%     testdata = bandpeak(grp == 0 | grp == 1,bandidx);
%     [rho,pval] = corr(crs,testdata,'type','spearman');
%     fprintf('%s band peak freq: Spearman rho = %.2f, p = %.3f.\n',bands{bandidx},rho,pval);
end
figure('Color','white');
barweb(barvals,errvals,[],bands,[],[],[],[],[],{'VS','MCS','Control'},[],[]);