function matrix = applythresh(matrix,thresh)

matrix(matrix < thresh) = 0;