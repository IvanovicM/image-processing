function middlePoint = getMiddlePoint(I)
    [height, width] = size(rgb2gray(I));
    middlePoint(1) = width/2;
    middlePoint(2) = height/2;
end