function [hour, min, sec] = extract_time(I)
    % Get needles
    [secNeedleImage, otherNeedlesImage] = separate_needles(I);
    [minNeedle, hourNeedle] = detect_other_needles(otherNeedlesImage);
    [exist, secNeedle] = detect_sec_needle(secNeedleImage);    
        
    % Calculate time from the needle lines
    hour = floor(getTime(I, hourNeedle, 12));
    if hour == 0
        hour = 12;
    end
    min = round(getTime(I, minNeedle, 60)); % floor
    if ~exist
        sec = -1;
    else
        sec = round(getTime(I, secNeedle, 60));
    end
    
    % plotAllNeedles(I, hourNeedle, minNeedle, exist, secNeedle);
end

