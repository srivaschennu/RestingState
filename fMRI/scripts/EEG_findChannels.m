% find a string in cell array
a = {chanlocSort.labels}
b = 'E11'
c = ismember(a,b)
d = find(c==1)
a(d)

% O1=82 O2=83
% F1=E19=24 F2=E4=39