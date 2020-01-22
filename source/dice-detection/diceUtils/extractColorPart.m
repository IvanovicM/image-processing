function colorPart = extractColorPart(I, color)
    if strcmp(color, 'red')
        colorPart = imsubtract(I(:, :, 1), rgb2gray(I));
    elseif strcmp(color, 'blue')
        colorPart = imsubtract(I(:, :, 3), rgb2gray(I));
    else
        colorPart = -1;
    end
end