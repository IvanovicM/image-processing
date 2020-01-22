function [image, betterImage] = make_giraffe_better()
    image = imread('../sekvence/giraff.jpg');
    % plotAndSaveExperiments(image);

    betterImage = imresize(imadjust(image), 2, 'bicubic');
end

function plotAndSaveExperiments(image)
    % A few differnet for CLAHE
    f = figure('Name', 'CLAHE');
    for limit = 0.01 : 0.01 : 0.04
        adaptImage = adapthisteq(image, ...
                                 'clipLimit', limit, ...
                                 'NumTiles', [8 8]);
        subplot(2, 2, limit / 0.01);
        imshow(adaptImage);
    end
    saveFigure(f, '../images/giraffe/', 'diffLimits.jpg');
    close(f);
    
    % Adaptive and regular equalizastion
    imageHistEq = histeq(image);
    saveImage(imageHistEq, '../images/giraffe/', 'regularHistEq.jpg');
    
    adHist = adapthisteq(image, 'clipLimit', 0.02, 'NumTiles', [8 8]);
    saveImage(adHist, '../images/giraffe/', 'adaptiveHistEq.jpg');
    
    % Original and final histograms
    f = figure; imhist(image);
    saveFigure(f, '../images/giraffe/', 'beforeHist.jpg');
    close(f);
    
    f = figure; imhist(adHist);
    saveFigure(f, '../images/giraffe/', 'afterHist.jpg');
    close(f);
end