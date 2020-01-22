function J = dos_non_local_means (I, K, S, var, h)
    % DOS_NON_LOCAL_MEANS  Non-local means filtering of the image
    %
    %   J = dos_non_local_means(I, K, S, var, h) applies a non-local
    %   means-based filter to the image I and returns the resulting image
    %   in J. The dimension of local window search is SxS. The structural
    %   similarity search window size is KxK. The estimated noise variance
    %   is var and h is the degree of smoothing.
    %
    %   Note
    %   ----
    %   I can be 2-dimensional image. The values in matrix should be of the type
    %   double.
    %
    %   Example 1
    %   ---------
    %   Non-local means filtering of the image
    %   
    %       I = imread('tire.tif');
    %       J = dos_non_local_means(I, 5, 10, 0.001, 0.0001);
    %       figure
    %       subplot(1, 2, 1);
    %       imshow(I);
    %       subplot(1, 2, 2);
    %       imshow(J);
    %
    %   See also IMBILATFILT.
    
    % Padd image.
    [height, width] = size(I);
    padding = floor(K / 2) + floor(S / 2);
    paddedI = padarray(I, [padding, padding], 'symmetric'); 
    
    % Calculate output value for every pixel.
    J = zeros(height, width);
    for ix = 1 : height
        if mod(ix, 20) == 0
            disp(['Processing row ', ...
                  num2str(ix), ' / ', num2str(height), '...']);
        end

        for jx = 1 : width
            J(ix, jx) = localMean(...
                localAreaAroundPixel(paddedI, padding, ix, jx), ...
                S, ...
                K, ...
                var, ...
                h ...
            );
        end
    end
end

function filteredPixel = localMean(localPixels, S, K, var, h)
    g = pixelsToCompareTo(localPixels, S, K);
    w = localWeights(localPixels, S, K, var, h);
    k = scalingFactor(w);
    result = g .* w;
    filteredPixel = sum(result(:)) / k;
end

function g = pixelsToCompareTo(localPixels, S, K)
    outside = floor(K / 2);
    g = localPixels(outside + 1 : outside + S, outside + 1 : outside + S);
end

function w = localWeights(localPixels, S, K, var, h)
    padding = floor(K / 2) + floor(S / 2);
    Bp = similarityArea(1 + padding, 1 + padding, localPixels, K);

    w = zeros(S, S);
    for ix = 1 : S
        for jx = 1 : S
            Bq = similarityArea(...
                floor(K / 2) + ix, floor(K / 2) + jx, localPixels, K);
            diff = localSimilarity(Bp, Bq, K);
            w(ix, jx) = exp(-max(diff - 2 * var, 0) / h ^ 2);
        end
    end
end

function diff = localSimilarity(Bp, Bq, K)
    quadraticError = (Bp - Bq) .^ 2;
    scalingFactor = K * K;
    diff = sum(quadraticError(:)) / scalingFactor;
end

function B = similarityArea(ix, jx, localPixels, K)
    around = floor(K / 2);
    B = localPixels(ix - around : ix + around, jx - around : jx + around);
end

function k = scalingFactor(w)
    k = sum(w(:));
end

function area = localAreaAroundPixel(paddedI, padding, ix, jx)
    area = paddedI(ix : ix + 2*padding, jx : jx + 2*padding);
end
