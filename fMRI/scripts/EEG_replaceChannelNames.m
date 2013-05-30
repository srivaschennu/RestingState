for chan = 1:length(idx1020)
    chanidx = find(strcmp(sprintf('E%d',idx1020(chan)),{chanlocs.labels}));
    if ~isempty(chanidx)
        chanlocs(chanidx).labels = name1020{chan};
        fprintf('Replaced %d with %s.\n',idx1020(chan),name1020{chan});
    end
end
