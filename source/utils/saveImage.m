function saveImage(I, dirPath, imageName)
    mkdir(dirPath);
    fullDestination = fullfile(dirPath, imageName);
    imwrite(I, fullDestination);
end