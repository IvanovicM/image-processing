function [image, betterImage] = make_enigma_better()
    image = imread('../sekvence/enigma.png');
    betterImage = adaptiveMedianFilter(image);
    
    % medianAndSharp(image);
    % saveHistogram(image, betterImage);
end

function saveHistogram(I, J)
    f = figure; imhist(I); axis([-10 265 0 inf]);
    saveFigure(f, '../images/enigma/', 'histBefore.jpg');
    close(f);
    
    f = figure; imhist(J); axis([-10 265 0 inf]);
    saveFigure(f, '../images/enigma/', 'histAfter.jpg');
    close(f);
end

function J = medianAndSharp(I)
    medianFiltered = medfilt2(I, [8 8], 'symmetric');
    saveImage(medianFiltered, '../images/enigma/', 'median.jpg');
    
    w_lp = fspecial('average', 8);
    blured = imfilter(medianFiltered, w_lp, 'replicate');
    mask = medianFiltered - blured;
    J = uint8(medianFiltered + mask);
    saveImage(J, '../images/enigma/', 'medianAndSharp.jpg');
end

function J = adaptiveMedianFilter(I) 
    Smax = 9;
    I = makeBigger(I, Smax);
    J = I;
    [hight, width] = size(I);
    ll = ceil(Smax / 2);
    ul = floor(Smax / 2);
    
    % Loop over the entire image ignoring edge effects
    for row = ll : hight - ul
        for col = ll : width - ul
            window_ind = -ul : ul;        
            region = I(row + window_ind, col + window_ind);
            centerpixel = region(ll, ll);
            for s = 3 : 2 : Smax
                [rmin, rmax, rmed] = regionStats(region, Smax, s);
                if rmed > rmin && rmed < rmax
                    if centerpixel <= rmin || centerpixel >= rmax
                        J(row, col) = rmed;
                    end
                    break;
                end
            end
        end
    end
    
    J = makeSmaller(J, Smax);
end

function [rmin, rmax, rmed] = regionStats(region, Smax, s)
    ll = ceil(Smax / 2) - floor(s / 2);
    ul = ceil(Smax / 2) + floor(s / 2);
    v = ones(Smax * Smax, 1);
    count = 1;
    for i = ll:ul
        for j = ll:ul
            v(count) = region(i, j);
            count = count + 1;
        end
    end
    v = visort(v, s * s);
    rmed = v(ceil(s * s / 2));
    rmin = v(1);
    rmax = v(s * s);
end

function v = visort(v, N)
    temp = v;
    for i = 1 : N - 1 
        m = v(i);
        k = 1;
        for j = i + 1 : N
            if v(j) < m
                m = v(j);
                k = j - i + 1;
            end
        end
        for j = 1 : k - 1
            v(i + j) = temp(i + j - 1);
        end
        v(i) = m;
        for j = 1 : N
            temp(j) = v(j);
        end
    end
end

function J = makeBigger(I, Smax)
    [height, width] = size(I);
    J = zeros(height + 2*Smax, width + 2*Smax, 'uint8');
    
    % Itself
    J(Smax + 1 :  end - Smax, Smax + 1 :  end - Smax) = I;
    
    % Corners
    J(1 : Smax, 1 : Smax) = I(1, 1); 
    J(1 : Smax, end - Smax : end) = I(1, end);
    J(end - Smax : end, 1 : Smax) = I(end, 1);
    J(end - Smax : end, end - Smax : end) = I(end, end);
    
    % Borders
    for ix = 1 : Smax
        J(ix, Smax + 1 : end - Smax) = I(1, :);
        J(end - Smax + 1, Smax + 1 : end - Smax) = I(end, :);
        J(Smax + 1 : end - Smax, ix) = I(:, 1);
        J(Smax + 1 : end - Smax, end - Smax + 1) = I(:, end);
    end
end

function I = makeSmaller(J, Smax)
    I = J(Smax + 1 :  end - Smax, Smax + 1 :  end - Smax);
end













