function [minNeedle, hourNeedle] = detectOtherNeedles(I)
    lines = getLines(I, 2);    
    % plotLines(I, lines, num, dir);
    [minNeedle, hourNeedle] = extractMinHourNeedle(lines);
    % plotMinHour(I, minNeedle, hourNeedle);
end

function [minNeedle, hourNeedle] = extractMinHourNeedle(lines)
    if length(lines) == 1
        minNeedle = lines(1);
        hourNeedle = lines(1);
    else
        length1 = lineLength(lines(1));
        length2 = lineLength(lines(2));
        if length1 > length2 
            minNeedle = lines(1);
            hourNeedle = lines(2);
        else
            minNeedle = lines(2);
            hourNeedle = lines(1);
        end
    end
end

function l = lineLength(line)
    x1 = line.point1(1);
    x2 = line.point2(1);
    y1 = line.point1(2);
    y2 = line.point2(2);
    l = sqrt((x1 - x2)^2 + (y1 - y2)^2);
end

function plotMinHour(I, minNeedle, hourNeedle, num, dir)
    f = figure(num); imshow(I), hold on;

    xy = [minNeedle.point1; minNeedle.point2];
    plot(xy(:,1),xy(:,2), 'LineWidth', 2, 'Color', 'green');
    xy = [hourNeedle.point1; hourNeedle.point2];
    plot(xy(:,1),xy(:,2), 'LineWidth', 2, 'Color', 'blue');
    
    legend('minute', 'hour');
    hold off;
    
    saveFigure(f, dir, 'minHourDetected.jpg');
end