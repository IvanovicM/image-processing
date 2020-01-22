function test_on_camerman()
    % Input
    I = im2double(imread('../../sekvence/camerman.tif'));
    if length(I) == 3
        I = rgb2gray(I);
    end

    % The best values
    std = 1; Tlow = 0.5; Thigh = 0.8;
    J = canny_edge_detection(I, std, Tlow, Thigh, '../images/camerman');
    figure('Name', 'Edges for Camerman'); imshow(J);
end