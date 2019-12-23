function lines = getLines(I, linesNum)
    edges = edge(I, 'Canny');
    
    [H, theta, ro] = hough(edges);
    peaks = houghpeaks(H, linesNum, 'Threshold', 0.3*max(H(:)));
    lines = houghlines(edges, theta, ro, peaks);
end