function saveFigure(F, dirPath, imageName)
    mkdir(dirPath);
    fullDestination = fullfile(dirPath, imageName);
    saveas(F, fullDestination);
end