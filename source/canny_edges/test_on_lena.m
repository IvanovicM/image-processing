function test_on_lena(saveExperiments)
    % Input
    I = im2double(imread('../../sekvence/lena.tif'));
    if length(I) == 3
        I = rgb2gray(I);
    end

    % Try various values
    if saveExperiments
        experimentWithParameters(I);
    end

    % The best values
    std = 1; Tlow = 0.25; Thigh = 0.35;
    J = canny_edge_detection(I, std, Tlow, Thigh, '../images/lena/result');
    figure('Name', 'Edges for Lena'); imshow(J);
end

function experimentWithParameters(I)
    for std = 0.2 : 0.2 : 2
        for Tlow = 0.1 : 0.1 : 1
            for Thigh = Tlow + 0.1 : 0.1 : 0.5
                fprintf('Processing: %.1f-%.1f-%.1f\n', std, Tlow, Thigh);
                dir = sprintf('../images/lena/%.1f/%.1f/%.1f', std, Tlow, Thigh);
                J = canny_edge_detection(I, std, Tlow, Thigh, dir);
            end
        end
    end
end