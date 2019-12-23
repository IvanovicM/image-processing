function [hour, min, sec] = extractTime(I)
    % Get needles
    [secNeedleImage, otherNeedlesImage] = separateNeedles(I);
    [minNeedle, hourNeedle] = detectOtherNeedles(otherNeedlesImage);
    [exist, secNeedle] = detectSecNeedle(secNeedleImage);
    
    % Calculate time from the needle lines
    hour = getTime(I, hourNeedle, 12);
    min = getTime(I, minNeedle, 60); % floor
    if ~exist
        sec = -1;
    else
        sec = getTime(I, secNeedle, 60);
    end
end

