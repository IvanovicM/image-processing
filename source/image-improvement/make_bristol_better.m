function [image, betterImage, grayImage] = make_bristol_better()
    linImage = hdrread('../sekvence/bristolb.hdr');
    image = lin2rgb(linImage);
    
    hsvImage = rgb2hsv(image);
    v = hsvImage(:, :, 3);
    vEq = histeq(v);
    hsvImage(:, :, 3) = vEq;
    
    betterImage = hsv2rgb(hsvImage);
    grayImage = vEq;
    
    % plotAndSaveExperiments(sRGBImage, v, vEq);
end

function plotAndSaveExperiments(sRGB, v, vEq)
    saveImage(sRGB, '../images/bristol/', 'sRGB.jpg');
    
    f = figure; imhist(v);
    saveFigure(f, '../images/bristol/', 'vHist.jpg');
    close(f);
    
    f = figure; imhist(vEq);
    saveFigure(f, '../images/bristol/', 'vEqHist.jpg');
    close(f);
end