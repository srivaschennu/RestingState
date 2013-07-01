function plotcohdist

load alldata
load chanlist

chandist = chandist ./ max(chandist(:));

uniqcd = unique(chandist(:));
uniqcd = linspace(uniqcd(1),uniqcd(end),100);

figure; hold all;
for g = 0:2
    for u = 1:length(uniqcd)-1
        selvals = find(chandist(:) >= uniqcd(u) & chandist(:) <= uniqcd(u+1));
        cohvals = allcoh(grp == g,3,selvals);
        plotvals(u) = mean(cohvals(:));
    end
    
    plot(uniqcd(1:end-1),plotvals);
end
