function numbers = get_dice_numbers(I, exist, components)
    if ~exist
        numbers = [];
    else
        L = length(components);
        numbers = zeros(1, L);

        for compNum = 1:L 
            com = components(compNum);

            imagePart = I(com.up : com.down, com.left : com.right, :);
            numbers(compNum) = getNumberOnImage(imagePart);
        end
    end
end

function number = getNumberOnImage(I, toFindCircles)
    J = preprocessImage(I);
    [J, number] = numberOfRelevantComponents(J);
    
    if nargin > 1 && toFindCircles
        findAndPlotCircles(J);
    end
end

function J = preprocessImage(I)
    grayImagePart = rgb2gray(I);
    segmentedPart = segmentImage(grayImagePart);

    se = strel('line', 7, 7);
    dil = imdilate(segmentedPart, se);
    J = imerode(dil, se);
end

function [J, number] = numberOfRelevantComponents(I)
    [height, width] = size(I);
    cc = bwconncomp(1 - I);
    number = cc.NumObjects;
    J = I;

    for com = 1:cc.NumObjects
        allIdx = cc.PixelIdxList{com};
        [row, col] = ind2sub(size(I), allIdx);
        if min(row) == 1 || max(row) == height || ...
           min(col) == 1 || max(col) == width
            number = number - 1;
            J(allIdx) = 1;
        end
    end
end

function J = segmentImage(I)
    [T, ~] = graythresh(I);
    J = I > T;
end

function findAndPlotCircles(I)
    E = edge(I, 'canny');
    [center, radius] = imfindcircles(E, [4, 20]);

    figure; imshow(I);
    viscircles(center, radius, 'Color', 'green');
end