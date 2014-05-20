for s = 1:size(allsubj,1)
    data1 = load([filepath 'wpli-ploscompbio/' allsubj{s,1} 'wplifdr.mat'],'matrix');
    data2 = load([filepath 'wpli/' allsubj{s,1} 'wplifdr.mat'],'matrix');
    for f = 1:size(data1.matrix,1)
        if find(abs(data1.matrix(f,:)) ~= abs(data2.matrix(f,:)))
            fprintf('%s: %d not equal\n',allsubj{s,1},f)
        end
    end
end