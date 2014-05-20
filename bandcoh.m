function [cohval, sigval, bootcoh] = bandcoh(freq1,freq2,cohall,cohbootall,freqsout)

[~, minidx] = min(abs(freqsout-freq1));
a=minidx;
[~, minidx] = min(abs(freqsout-freq2));
b=minidx;

cohall = cohall(a:b,:);
cohbootall = cohbootall(:,a:b,:);

[maxcoh, maxidx] = max(max(cohall,[],2));
[mincoh, minidx] = min(min(cohall,[],2));

if abs(maxcoh) > abs(mincoh)
    cohval = maxcoh;
    bootcoh = max(max(cohbootall,[],3),[],2);
    sigval = sum(bootcoh >= cohval)/length(bootcoh);
    
else
    cohval = mincoh;
    bootcoh = min(min(cohbootall,[],3),[],2);
    sigval = sum(bootcoh <= cohval)/length(bootcoh);
end