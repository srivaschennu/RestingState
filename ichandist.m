function chandist = ichandist(chanlocs)

chanlocs = cat(2,cell2mat({chanlocs.X})',cell2mat({chanlocs.Y})',cell2mat({chanlocs.Z})');
[THETA PHI] = cart2sph(chanlocs(:,1),chanlocs(:,2),chanlocs(:,3));
chanlocs = radtodeg([PHI THETA]);

chandist = zeros(size(chanlocs,1),size(chanlocs,2));
for c1 = 1:size(chanlocs,1)
    for c2 = 1:size(chanlocs,1)
        chandist(c1,c2) = distance(chanlocs(c1,:),chanlocs(c2,:));
    end
end
