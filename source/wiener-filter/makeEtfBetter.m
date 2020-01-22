function [image, betterImage] = makeEtfBetter(dir)
    image = im2double(imread('../../sekvence/etf_blur.tif'));
    h = im2double(imread('../../sekvence/kernel.tif'));
    saveImage(h, dir, 'kernel.jpg');
    h = h ./ sum(h(:));

    saveExperiments(image, h, dir);
    betterImage = deconvwnr(image, h, 0.001);    
end

function saveExperiments(I, h, dir)
    for NSR = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 0]
        J = deconvwnr(I, h, NSR); 
        saveImage(J, dir, ['NSR=', num2str(NSR), '.jpg']);
    end
end
