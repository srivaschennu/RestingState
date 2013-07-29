function plotpower(listname)

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
        
        subplot(size(bandpower,2),length(groups),p); hold all;
        topoplot(squeeze(mean(bandpower(grp == groups(g),bandidx,:),1)),sortedlocs,'maplimits','maxmin'); colorbar
        if g == 1
            title(bands{bandidx});
        end
        p = p+1;
    end
end
figure('Color','white');
barweb(barvals,errvals,[],bands,[],[],[],[],[],{'VS','MCS','Control'},[],[]);

figure('Color','white');
p = 1;
for g = 1:length(groups)
    subplot(1,length(groups),p);
    plot(freqbins,10*log10(squeeze(mean(spectra(grp == groups(g),:,:),1))),'LineWidth',2);
    set(gca,'XLim',[0 45],'YLim',[-25 25]); xlabel(sprintf('Group %d',groups(g))); ylabel('Power (dB)');
    p = p+1;
    
end
