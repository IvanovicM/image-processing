function J = apply_clhe(I, L, limit)
    h = imageHistogram(I, L);
    hLimited = limitHistogram(h, limit);
    p = imageDistributionFunction(hLimited, size(I));
    s = imageCumulativeDistributionFunction(p, L);
    J = mapImageValues(I, s) / (L - 1);
end

function h = imageHistogram(I, L)
    h = zeros(1, L);
    [height, width] = size(I);
    
    for ix = 1 : height
        for jx = 1 : width
            h(I(ix, jx) + 1) = h(I(ix, jx) + 1) + 1;
        end
    end   
end

function hLimited = limitHistogram(h, limit)
    scaledLimit = limit * sum(h);
    overLimit = sum(h(h > scaledLimit) - scaledLimit);
    h(h > scaledLimit) = scaledLimit;
    hLimited = h + overLimit / length(h);
end

function p = imageDistributionFunction(h, imageSize)
    p = h ./ (imageSize(1) * imageSize(2));
end

function s = imageCumulativeDistributionFunction(p, L)
    s = zeros(1, L);
    s(1) = p(1);
    for ix = 2 : L
        s(ix) = s(ix - 1) + p(ix);
    end
    s = round(s .* (L - 1));
end

function J = mapImageValues(I, mapFunction)
    J = zeros(size(I));
    [height, width] = size(I);
    
    for ix = 1 : height
        for jx = 1 : width
            J(ix, jx) = mapFunction(I(ix, jx) + 1);
        end
    end  
end