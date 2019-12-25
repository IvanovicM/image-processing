function plotAllNeedles(I, hourNeedle, minNeedle, secExist, secNeedle)
    middlePoint = getMiddlePoint(I);
    figure(); imshow(I), hold on;
    
    % Plot
    plot([hourNeedle.point1(1), hourNeedle.point2(1)], ...
         [hourNeedle.point1(2), hourNeedle.point2(2)], ...
         'LineWidth', 4, 'Color', 'blue');
    plot([minNeedle.point1(1), minNeedle.point2(1)], ...
         [minNeedle.point1(2), minNeedle.point2(2)], ...
         'LineWidth', 4, 'Color', 'green');
    if secExist
        plot([secNeedle.point1(1), secNeedle.point2(1)], ...
             [secNeedle.point1(2), secNeedle.point2(2)], ...
             'LineWidth', 4, 'Color', 'red');
    end
    plot(middlePoint(1), middlePoint(2), ...
         '*', 'LineWidth', 4, 'Color', 'magenta');

    % Format
    if secExist
        legend('hour', 'minute', 'second', 'middle point');
    else
        legend('hour', 'minute', 'middle point');
    end
    hold off;
end