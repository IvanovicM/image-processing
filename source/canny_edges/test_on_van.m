function test_on_van()
    % Input
    I = im2double(imread('../../sekvence/van.tif'));
    if length(I) == 3
        I = rgb2gray(I);
    end

    % The best values
    std = 2; Tlow = 0.1; Thigh = 0.2;
    J = canny_edge_detection(I, std, Tlow, Thigh, '../images/van');
    figure('Name', 'Edges for Van'); imshow(J);
end