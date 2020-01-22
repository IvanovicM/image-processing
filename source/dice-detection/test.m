%% Be ready
clear all;
close all;
clc;

addpath('../utils/');
addpath('diceUtils/');
   
%% Test both functions
for num = 1:1
    name = sprintf('../data/dice/dice%d.jpg', num);
    I = im2double(imread(name));
    
    [blueNumbers, redNumbers] = extractDiceScore(I);
 
    bString = sprintf(repmat('%d ', 1, length(blueNumbers)), blueNumbers);
    rString = sprintf(repmat('%d ', 1, length(redNumbers)), redNumbers);
    fprintf('| image: %2d | blue: %6s | red: %6s |\n', ...
            num, bString, rString);
end