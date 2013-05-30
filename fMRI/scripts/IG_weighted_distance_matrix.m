% IG 22/03/13 calculate weighted distances between the balls
load('ROI_coordinates_sorted.mat')

for iballs = 1:size(ROI_coordinates_sorted,1)
    for iballs2 = 1:size(ROI_coordinates_sorted,1)
        if iballs ~= iballs2
        distMat(iballs,iballs2) = pdist(ROI_coordinates_sorted([iballs,iballs2],:));
        end
    end
end
distMat = distMat/max(distMat(:)); %for normalizing
save('distMat','distMat')

