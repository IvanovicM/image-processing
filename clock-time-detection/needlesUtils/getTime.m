function time = getTime(I, needle, unitsPerCircle)
    middlePoint = getMiddlePoint(I);
    
    shiftedNeedleCoords = shiftNeedleCoords(needle, middlePoint);
    %plotShiftedNeedle(I, shiftedNeedleCoords, middlePoint); input('X:');
        
    time = getAngle(shiftedNeedleCoords) / (2*pi) * unitsPerCircle;
end

function middlePoint = getMiddlePoint(I)
    [height, width] = size(rgb2gray(I));
    middlePoint(1) = width/2;
    middlePoint(2) = height/2;
end

function shifted = shiftNeedleCoords(needle, middlePoint)
    p1 = needle.point1;
    p2 = needle.point2;
    p1(1) = p1(1) - middlePoint(1);
    p1(2) = -p1(2) + middlePoint(2);
    p2(1) = p2(1) - middlePoint(1);
    p2(2) = -p2(2) + middlePoint(2);
    
    shifted.point1 = p1;
    shifted.point2 = p2;
end

function angle = getAngle(needle)
    angle = atan2(needle.point1(1) - needle.point2(1), ...
                  needle.point1(2) - needle.point2(2));
end

function plotShiftedNeedle(I, needle, middlePoint)
    figure(); hold on;

    xy = [needle.point1; needle.point2];
    plot(xy(:,1),xy(:,2), 'LineWidth', 2, 'Color', 'green');
    
    xlim([-middlePoint(1), middlePoint(1)]);
    ylim([-middlePoint(2), middlePoint(2)]);
    hold off;
end