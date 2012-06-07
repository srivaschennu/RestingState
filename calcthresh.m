function [matrix thresh] = calcthresh(matrix)

thresh = 0;
stepsize = 0.01;

while mean(degrees_und(applythresh(matrix,thresh))) > log(size(matrix,1))
    thresh = thresh+stepsize;
end

thresh = thresh-stepsize;
matrix = applythresh(matrix,thresh);