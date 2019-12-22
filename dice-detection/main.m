%% Be ready
clear all;
close all;
clc;

addpath('../utils/');
   
%% Iteratethrough all the images and save results
for num = 1:12
    name = sprintf('../data/dices/dice%d.jpg', num);
    I = im2double(imread(name));
    
    extract_dice_score(I, num);
end