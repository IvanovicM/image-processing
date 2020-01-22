function test_on_house()
    % Input
    I = im2double(imread('../../sekvence/house.tif'));
    if length(I) == 3
        I = rgb2gray(I);
    end

    % The best values
    std = 0.5; Tlow = 0.1; Thigh = 0.4;
    J = canny_edge_detection(I, std, Tlow, Thigh, '../images/house');
    figure('Name', 'Edges for House'); imshow(J);
end