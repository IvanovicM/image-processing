function J = clhe(I, bit_depth, limit)
    % CLHE  Enhance contrast using histogram equalization with clip
    %   limit and number of quantisation levels limit.
    %
    %   J = clhe(I) transforms the intensity image I so that the
    %   histogram of the output image J is approximately uniform.
    %
    %   J = clhe(I, bit_depth) transforms the intensity image I so that
    %   the histogram of the output image J is approximately uniform.
    %   Number of quantisation levels is 2^bit_depth.
    %
    %   J = clhe(I, bit_depth, limit) transforms the intensity image I
    %   so that the histogram of the output image J is approximately
    %   uniform. Number of quantisation levels is 2^bit_depth. The
    %   histogram of the input image is clipped to limit.
    %
    %   Note
    %   ----
    %   I can be 2-dimensional image. The values in matrix
    %   must be of type double.
    %   
    %   bit_depth must be a scalar of type integer, more than 0. If not
    %   provided the default value is 8.
    %
    %   limit must be a scalar of type double, in range [0, 1]. If not
    %   provided the default value is 0.01.
    %
    %   Example 1
    %   ---------
    %   Enhance the contrast of an intensity image using histogram
    %   equalization.
    %   
    %       I = imread('tire.tif');
    %       J = clhe(I, 6, 0.02);
    %       figure
    %       subplot(1, 2, 1);
    %       imshow(I);
    %       subplot(1, 2, 2);
    %       imshow(J);
    %
    %   See also HISTEQ, IMHIST.
    switch nargin
        case 1
            J = clhe(I, 8, 0.01);
        case 2
            J = clhe(I, bit_depth, 0.01);
        case 3
            validateInputArguments(I, bit_depth, limit);
            L = pow2(bit_depth);
            J = apply_clhe(transformImage(I, L), L, limit);
        otherwise
            error('Number of input arguments must be between 1 and 3.');
    end
end

function validateInputArguments(I, bit_depth, limit)
    % Validate image.
    imageSize = size(I);
    if length(imageSize) ~= 2
        error('Image must be 2D.');
    end
    if isa(I, 'double') == 0
        error('Elements in the image must be of type double.');
    end
    
    % Validate bit_depth.
    if isscalar(bit_depth) == 0
        error('Input argument bit_depth must be a scalar.');
    end
    if isinteger(int8(bit_depth)) == 0
        error('Input argument bit_depth must be of type integer.');
    end
    if bit_depth < 1 || bit_depth > 16
        error('Input argument bit_depth must be between 1 and 16.');
    end
    
    % Validate limit.
    if isscalar(limit) == 0
        error('Input argument limit must be a scalar.');
    end
    if isa(limit, 'double') == 0
        error('Input argument limit must be of type double.');
    end
    if limit < 0 || limit > 1
        error('Input argument bit_depth must be between 0 and 1.');
    end
end

function J = transformImage(I, L)
    J = round(I .* (L - 1));
end