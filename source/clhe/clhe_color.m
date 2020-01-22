function [vI, vJ, J] = clhe_color(I, bit_depth, limit)
    hsvI = rgb2hsv(I);
    vI = hsvI(:, :, 3); vI = double(vI);
    
    switch nargin
        case 1
            vJ = clhe(vI);
        case 2
            vJ = clhe(vI, bit_depth);
        case 3
            vJ = clhe(vI, bit_depth, limit);
        otherwise
            error('Number of input arguments must be between 1 and 3.');
    end

    hsvJ = hsvI; hsvJ(:, :, 3) = vJ;
    J = hsv2rgb(hsvJ);
end