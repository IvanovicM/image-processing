function time = getTime(I, needle, unitsPerCircle)
    middlePoint = getMiddlePoint(I);
    
    shiftedNeedleCoords = shiftNeedleCoords(needle, middlePoint);
    % plotShiftedNeedle(I, shiftedNeedleCoords, middlePoint);
        
    time = getAngle(shiftedNeedleCoords) / (2*pi) * unitsPerCircle;
end

function shifted = shiftNeedleCoords(needle, middlePoint)
    p1 = needle.point1;
    p2 = needle.point2;
    p1(1) = p1(1) - middlePoint(1);
    p1(2) = -p1(2) + middlePoint(2);
    p2(1) = p2(1) - middlePoint(1);
    p2(2) = -p2(2) + middlePoint(2);
    
    shifted = orderPoints(p1, p2);
end

function shifted = orderPoints(p1, p2)
    mqs1 = sqrt(p1(1)^2 + p1(2)^2);
    mqs2 = sqrt(p2(1)^2 + p2(2)^2);

    if mqs1 < mqs2
        shifted.point1 = p1;
        shifted.point2 = p2;
    else
        shifted.point1 = p2;
        shifted.point2 = p1;
    end
end

function angle = getAngle(needle)
    angle = atan2(needle.point2(1) - needle.point1(1), ...
                  needle.point2(2) - needle.point1(2));
    if angle < 0
        angle = 2*pi + angle;
    end
end

function plotShiftedNeedle(I, needle, middlePoint)
    figure; hold on;

    xy = [needle.point1; needle.point2];
    plot(xy(:,1),xy(:,2), 'LineWidth', 2, 'Color', 'green');
    plot(needle.point1(1), needle.point1(2), '*', 'Color', 'red');
    plot(needle.point2(1), needle.point2(2), '*', 'Color', 'blue');
    
    xlim([-middlePoint(1), middlePoint(1)]);
    ylim([-middlePoint(2), middlePoint(2)]);
    legend('Whole line', 'Closer to middle', 'Further from middle');
    hold off;
end