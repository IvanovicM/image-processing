function numbers = getDiceNumbers(I, exist, components)
    if ~exist
        numbers = [];
    else
        L = length(components);
        numbers = zeros(1, L);

        for num = 1:L 
            com = components(num);

            imagePart = I(com.up : com.down, com.left, com.right);
            numbers(num) = getNumberOnImage(imagePart);
        end
    end
end

function number = getNumberOnImage(I)
    J = preprocessImage(I);
    number = numberOfRelevantComponents(J);
end

function J = preprocessImage(I, toPlot)
    grayImagePart = rgb2gray(I);
    segmentedPart = segmentImage(grayImagePart);

    se = strel('line', 7, 7);
    dil = imdilate(segmentedPart, se);
    J = imerode(dil, se);

    if nargin == 2 && toPlot = true
        figure;
        suplot(2, 2, 1); imshow(grayImagePart);
        suplot(2, 2, 2); imshow(segmentedPart);
        suplot(2, 2, 3); imshow(dil);
        suplot(2, 2, 4); imshow(J);
    end
end

function numberOfRelevantComponents(I)
    [height, width] = size(I);
    cc = bwconncomp(1 - I);
    number = cc.NumObjects;

    for com = 1:cc.NumObjects
        allIdx = cc.PixelIdxList(com);
        [row, col] = ind2sub(size(I), allIdx);
        if min(row) == 1 || max(row) == height || ...
           min(col) == 1 || min(col) == width
            number = number - 1;
        end
    end
end

function J = segmentImage(I)
    [T, ~] = graythresh(I);
    J = I > T;
end