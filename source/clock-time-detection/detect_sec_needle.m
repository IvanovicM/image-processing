function [exist, secNeedle] = detect_sec_needle(I)
    lines = getLines(I, 1);    
    % plotLines(I, lines);
    if length(lines) == 1
        exist = true;
        secNeedle = lines(1);
    else
        exist = false;
        secNeedle = -1;
    end
end