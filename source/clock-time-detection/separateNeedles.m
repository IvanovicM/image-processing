function [secNeedle, otherNeedles] = separateNeedles(I)
    Isegmented = segmentImage(rgb2gray(I));
    IwithoutBorder = removeNotRelevantComponents(Isegmented, 'border');
    
    redNeedle = extractSecNeedle(I);
    [secNeedle, otherNeedles] = separateSecOtherNeedles(...
        IwithoutBorder, redNeedle);
    otherNeedles = removeNotRelevantComponents(otherNeedles, 'numbers');
end

function [secNeedle, otherNeedles] = separateSecOtherNeedles(I, redNeedle)
    noRedNeedle = I + redNeedle;
    se = strel('line', 3, 3);
    otherNeedles = imdilate(noRedNeedle, se);
    secNeedle = imerode(otherNeedles, se) - I;
end

function secNeedle = extractSecNeedle(I)
    redPart = imsubtract(max(0, I(:,:,1) - 0.1), rgb2gray(I)); 
    secNeedle = segmentImage(redPart);
end

function J = segmentImage(I)
    [T, ~] = graythresh(I);
    J = I > T;
end

function J = removeNotRelevantComponents(I, mode)
    [height, width] = size(I);
    J = I;
    cc = bwconncomp(1 - I);
    
    % Iterate throught all components and remove not relevant ones.
    for com = 1:cc.NumObjects
        allIdx = cc.PixelIdxList{com};
        [row, col] = ind2sub(size(J), allIdx);

        heightDiff = max(row) - min(row);
        widthDiff = max(col) - min(col);
        if shouldRemove(height, width, heightDiff, widthDiff, mode)
            J(allIdx) = 1;
        end
    end
end

function remove = shouldRemove(height, width, heightDiff, widthDiff, mode)
    remove = false;
    if strcmp(mode, 'numbers') || strcmp(mode, 'border&numbers')
        if heightDiff < height/5 && widthDiff < width/5
            remove = true;
        end
    end
    if strcmp(mode, 'border') || strcmp(mode, 'border&numbers')
        if heightDiff > 2/3*height && widthDiff > 2/3*width
            remove = true;
        end   
    end
end