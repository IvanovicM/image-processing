function E = canny_edge_detection(I, std, Tlow, Thigh, dir)
    Ifiltered = filterImage(I, std);
    [Gmag, Gdir] = findGradient(Ifiltered);
    GdirQuant = quantizeDirection(Gdir);
    localMaxEdges = keepLocalMaximums(Gmag, GdirQuant);
    [strongEdges, weakEdges] = mapEdges(localMaxEdges, Tlow, Thigh);
    
    visited = false(size(strongEdges));
    [E, ~, ~] = connectComponents(strongEdges, weakEdges, visited);
    
    if nargin == 5
        saveAll(Gmag, Gdir, localMaxEdges, strongEdges, weakEdges, E, dir);
    end
end

function J = filterImage(I, std)
    filterSize = ceil(6 * std);
    if mod(filterSize, 2) == 0
        filterSize = filterSize + 1;
    end
    J = imgaussfilt(I, std, 'FilterSize', filterSize);
end

function [Gmag, Gdir] = findGradient(I)
    hx = [-1 -2 -1; 0 0 0; 1 2 1];
    hy = hx';
    Gx = imfilter(I, hx, 'replicate', 'same');
    Gy = imfilter(I, hy, 'replicate', 'same');
    
    Gmag = (Gx .^ 2 + Gy .^ 2) .^ 0.5;
    Gdir = atan(Gy ./ Gx);
    Gdir(Gx == 0) = 0;
end

function GQuant = quantizeDirection(G)
    [h, w] = size(G);
    GQuant = zeros(size(G));
    for ix = 1:h
        for jx = 1:w
           GQuant(ix, jx) = quantizeValue(G(ix, jx));
        end
    end
end

function quantValue = quantizeValue(value)
    value = value * 180 / pi;
    if (value >= 22.5 && value < 67.5) || (value >= -157.5 && value < -112.5)
        quantValue = -pi/4;
    elseif (value >= 67.5 && value < 112.5) || (value >= -112.5 && value < -67.5)
        quantValue = pi/2;
    elseif (value >= 112.5 && value < 157.5) || (value >= -67.5 && value < -22.5)
        quantValue = pi/4;
    else
        quantValue = 0;
    end
end


function localMaximums = keepLocalMaximums(Gmag, Gdir)
    [h, w] = size(Gmag);
    Gpadded = padarray(Gmag, [1 1], 'symmetric');
    localMaximums = Gmag;
    for ix = 1:h
        for jx = 1:w
            part = Gpadded(ix : ix + 2, jx : jx + 2);
            if findLocalMax(part, Gdir(ix, jx)) ~= Gmag(ix, jx)
                localMaximums(ix, jx) = 0;
            end
        end
    end
end

function localMax = findLocalMax(part, direction)
    if direction == -pi/4
        h = [1 0 0; 0 1 0; 0 0 1];
    elseif direction == pi/2
        h = [0 0 0; 1 1 1; 0 1 0];
    elseif direction == pi/4
        h = [0 0 1; 0 1 0; 1 0 0];
    else
        h = [0 1 0; 0 1 0; 0 1 0];
    end
    
    relevantValues = part .* h;
    localMax = max(relevantValues(:));
end

function [strongEdges, weakEdges] = mapEdges(localMaxEdges, Tlow, Thigh)
    moreThanHigh = localMaxEdges > Thigh;
    moreThanLow = localMaxEdges > Tlow;
    strongEdges = moreThanHigh;
    weakEdges = moreThanLow & (~moreThanHigh);
end

function [strong, weak, visited] = connectComponents(strong, weak, visited)
    [h, w] = size(visited);
    for ix = 1:h
        for jx = 1:w
            if strong(ix, jx) && ~visited(ix, jx)
                [strong, weak, visited] = dfs(strong, weak, visited, ix, jx);
            end
        end
    end
end

function [strong, weak, visited] = dfs(strong, weak, visited, ix, jx)
    [h, w] = size(visited);
    if ix >= 1 && jx >= 1 && ix <= h && jx <=w
        if ~visited(ix, jx)
            if strong(ix, jx)
                visited(ix, jx) = true;
                idxDiff = [-1 0 1];
                
                % Visit others
                for newIx = ix + idxDiff
                    for newJx = jx + idxDiff
                        [strong, weak, visited] = ...
                            dfs(strong, weak, visited, newIx, newJx);
                    end
                end
            elseif weak(ix, jx)
                strong(ix, jx) = true;
                [strong, weak, visited] = ...
                    dfs(strong, weak, visited, ix, jx);
            end
        end
    end
end

function saveAll(Gmag, Gdir, localMaxEdges, strongEdges, weakEdges, E, dir)
    saveImage(Gmag, dir, 'Gmag.png');
    saveImage(Gdir, dir, 'Gdir.png');
    saveImage(localMaxEdges, dir, 'localMaxEdges.png');
    saveImage(strongEdges, dir, 'strongEdges.png');
    saveImage(weakEdges, dir, 'weakEdges.png');
    saveImage(E, dir, 'E.png');
end
