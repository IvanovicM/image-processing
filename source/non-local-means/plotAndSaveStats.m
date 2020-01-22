function plotAndSaveStats(psnrStats, timeStats, K, S, dir)
    plotAndSavePsnrStats(psnrStats, K, S, dir);
    plotAndSaveTimeStats(timeStats, K, S, dir);
end

function plotAndSavePsnrStats(psnrStats, K, S, dir)
    % Display
    fprintf('%5s | %5s | %12s\n', 'K', 'S', 'PSNR');
    for ix = 1 : length(K)
        for jx = 1 : length(S)
            fprintf('%5d | %5d | %12.2f\n', K(ix), S(jx), psnrStats(ix, jx));
        end
    end

    % Plot
    X = repelem(K, length(S));
    Y = repmat(S, [1 length(K)]);
    Z = reshape(psnrStats, [1, length(K) * length(S)]);
    
    f = figure('Name', '[Non-local] PSNR');    
    stem3(X, Y, Z); hold all;
    mesh(K, S, psnrStats); view(30, 15); 
    
    xlabel('K'); ylabel('S'); zlabel('PSNR');
    xlim([min(X) - 1, max(X) + 1]);
    ylim([min(Y) - 1, max(Y) + 1]);
    
    saveFigure(f, dir, 'psnr.jpg');
end

function plotAndSaveTimeStats(timeStats, K, S, dir)
    % Display
    fprintf('%5s | %5s | %12s\n', 'K', 'S', 'Time [s]');
    for ix = 1 : length(K)
        for jx = 1 : length(S)
            fprintf('%5d | %5d | %12.2f\n', K(ix), S(jx), timeStats(ix, jx));
        end
    end

    % Plot
    X = repelem(K, length(S));
    Y = repmat(S, [1 length(K)]);
    Z = reshape(timeStats, [1, length(K) * length(S)]);
    
    f = figure('Name', '[Non-local] Time');
    stem3(X, Y, Z); hold all;
    mesh(K, S, timeStats); 
    
    xlabel('K'); ylabel('S'); zlabel('Time [s]');
    xlim([min(X) - 1, max(X) + 1]);
    ylim([min(Y) - 1, max(Y) + 1]);
    zlim([min(Z) - 1, max(Z) + 1]);
    
    saveFigure(f, dir, 'time.jpg');
end