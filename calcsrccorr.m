function calcsrccorr(listname)

loadsubj
loadpaths
brainstormdbpath = '/Users/chennu/Data/brainstorm_db/';
studyname = 'RestingState';
condname = 'restingstate';

subjlist = eval(listname);

bandpassdata = [];
for s = 1:size(subjlist,1)
    fprintf('Processing %s.\n',subjlist{s});
    datapath = sprintf('%s%s/data/%s/%s/',brainstormdbpath,studyname,subjlist{s},condname);
    filelist = dir(sprintf('%s/*_bandpass.mat',datapath));
    filelist = sort({filelist.name});
    for f = 1:length(filelist)
        load(sprintf('%s%s',datapath,filelist{f}),'ImageGridAmp');
        bandpassdata = cat(2,bandpassdata,ImageGridAmp);
    end
end

[corrmat, corrp] = corr(bandpassdata');

tmp_pvals = corrp(logical(triu(ones(size(corrp)),1)));
tmp_coh = corrmat(logical(triu(ones(size(corrmat)),1)));

alpha = 0.05;
[~, p_masked]= fdr(tmp_pvals,alpha);
tmp_pvals(~p_masked) = 1;
tmp_coh(tmp_pvals >= alpha) = 0;

corrmat = zeros(size(corrmat));
corrmat(logical(triu(ones(size(corrmat)),1))) = tmp_coh;
corrmat = triu(corrmat,1)+triu(corrmat,1)';

corrp = zeros(size(corrp));
corrp(logical(triu(ones(size(corrp)),1))) = tmp_pvals;
corrp = triu(corrp,1)+triu(corrp,1)';

save allcorr.mat corrmat corrp