function [image, betterImage, grayImage] = make_disney_better()
    image = imread('../sekvence/disney.png');
    
    hsvImage = rgb2hsv(image);
    v = hsvImage(:, :, 3);
    vEq = histeq(v);
    hsvImage(:, :, 3) = vEq;
    
    betterImage = hsv2rgb(hsvImage);
    grayImage = rgb2gray(betterImage);
    
    % plotAndSaveExperiments(v, vEq);
end

function plotAndSaveExperiments(v, vEq)    
    f = figure; imhist(v);
    saveFigure(f, '../images/disney/', 'vHist.jpg');
    close(f);
    
    f = figure; imhist(vEq);
    saveFigure(f, '../images/disney/', 'vEqHist.jpg');
    close(f);
end