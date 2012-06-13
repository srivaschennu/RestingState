alpha = 0.05;
pvals = zeros(91,91);
for f = 3
    for c1 = 1:91
        for c2 = 1:91
            if c1 < c2
                pvals(c1,c2) = ranksum(bigmat(grp ~= 3,f,c1,c2),bigmat(grp == 3,f,c1,c2));
            end
        end
    end
end

tmp_pvals = pvals(logical(triu(ones(size(pvals)),1)));
[~,pmask] = fdr(tmp_pvals,alpha);
tmp_pvals(pmask ~= 1) = 1;
pvals(logical(triu(ones(size(pvals)),1))) = tmp_pvals;
pvals = triu(pvals,1) + triu(pvals,1)';

meanmat_pat = squeeze(mean(bigmat(grp ~= 3,f,:,:),1));
meanmat_ctrl = squeeze(mean(bigmat(grp == 3,f,:,:),1));

meanmat_pat(pvals >= alpha) = 0;
meanmat_ctrl(pvals >= alpha) = 0;