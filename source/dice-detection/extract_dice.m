function [exist, components] = extract_dice(I, color, toPlotBoundaries)
    colorImagePart = extractColorPart(I, color);
    ISegmented = colorImagePart > 0.23;
    noSmallComponents = removeSmallComponents(ISegmented);
    connectedComponents = connectComponents(noSmallComponents);
    [exist, components] = cutComponents(connectedComponents);

    if exist && nargin > 2 && toPlotBoundaries
        plotBoundaries(I, components);
    end
end

function J = removeSmallComponents(I)
    se = strel('line', 7, 7);
    J = imopen(I, se);
end

function J = connectComponents(I)
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
        allIdx = cc.PixelIdxList{com};
        [row, col] = ind2sub(size(I), allIdx);
        components(com) = createComponent(row, col, height, width);
    end
end

function component = createComponent(row, col, height, width)
    component.up = max(min(row) - 2, 1);
    component.down = min(max(row) + 2, height);
    component.left = max(min(col) - 2, 1);
    component.right = min(max(col) + 2, width);
end

function plotBoundaries(I, components)
    figure; imshow(I); hold on;
    for com = components
        x = [com.left, com.right, com.right, com.left, com.left];
        y = [com.up, com.up, com.down, com.down, com.up];
        plot(x, y, 'LineWidth', 2, 'Color', 'black');
    end
    hold off;
end