clear chanlocs
i =91
for n = 1:12
chanlocs = bigchanlocs{n};
[~,sortidx] = sort({chanlocs.labels});
SortID(n,:) = sortidx
chanlocSort = chanlocs(sortidx);
a{n}=chanlocs(1,i).labels;
%b{n}=chanlocSort(1,i).labels;
specinfo{1,n}.chanlocSort = chanlocSort;


%%%%%%%%%%%%%
A = bandsave(n,:);
bandSort(n,:) = A(sortidx);

end
a
b
%save bandpower.mat specinfo -append
% save bigmat.mat bigchanlocs -append

save A.mat bandSort

chanlocs = bigchanlocs{1};
c = sort({chanlocs.labels});
chanlocs = bigchanlocs{12};
d = sort({chanlocs.labels});