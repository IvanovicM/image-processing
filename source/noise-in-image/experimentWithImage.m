function allVars = experimentWithImage(I, dir, allK, toPlot)
    ISqrt = I .^ 2;
    allVars = zeros(size(allK)); varIdx = 1;
    
    for K = allK
        % Calculate
        h = fspecial('average', [K K]);
        IAvg = imfilter(I, h, 'replicate');
        IAvgSqrt = imfilter(ISqrt, h, 'replicate');
        variance = IAvgSqrt - IAvg .^ 2;

        if toPlot
            f = figure('Name', ['[Var Hist]', ' K=', num2str(K)]);
            histogram(variance); 
            saveFigure(f, dir, ['K=', num2str(K), '.jpg']);
        end
        
        % Save max from this histogram
        [counts, values] = imhist(variance);
        [~, idx] = max(counts);
        allVars(varIdx) = values(idx); varIdx = varIdx + 1;
    end
    
    f = figure('Name', 'All Variances');
    plot(allK, allVars);
    xlabel('K'); ylabel('Estimated var');
    saveFigure(f, dir, 'allVars.jpg');
end