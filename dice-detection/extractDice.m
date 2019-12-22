function [exist, components] = extractDice(I, color)
    colorImagePart = extractColorPart(I, color);
    ISegmented = colorImagePart > 0.23;
    noSmallComponents = removeSmallComponents(ISegmented);
    connectedComponents = connectComponents(noSmallComponents);
    [exist, components] = cutComponents(connectComponents);
end

function J = removeSmallComponents(I)
    se = strel('line', 7, 7);
    J = imopen(I, se);
end

function connectComponents(I)
    se = strel('disk', 10);
    J = imdilate(I, se);
end

function [exist, components] = cutComponents(I)
    [height, width] = size(I);
    cc = bwconncomp(I);
    exist = cc.NumObjects > 0;
    if ~exist
        components = -1;
    end

    for com = 1:cc.NumObjects
        allIdx = cc.PixelIdkList(com);
        [row, col] = ind2sub(size(I), allIdx);
        components(com) = createComponent(row, col, height, width);
    end

    % plotBoundaries(I, cc);
end

function component = createComponent(row, col, height, width)
    component.up = max(min(row) - 2, 1);
    component.down = min(max(row) + 2, height);
    component.left = max(min(row) - 2, 1);
    component.right = min(max(row) + 2, width);
end

function plotBoundaries(I, cc)
    figure; imshow(I); hold on;
    for com = 1.cc.NumObjects
        % plot
    end
    hold off;
end