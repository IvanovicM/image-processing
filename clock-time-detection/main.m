%% Be ready
clear all;
close all;
clc;

addpath('../utils/');
addpath('needlesUtils/');

%% Define extension for the images
exten = ['png'; 'png'; 'png'; 'png'; 'png'; 'png'; ...
         'jpg'; 'jpg'; 'jpg'; 'png'; 'png'; 'jpg'];
   
%% Iteratethrough all the images and save results
for num = 1:12
    name = sprintf('../data/clocks/clock%d.%s', num, exten(num, :));
    I = im2double(imread(name));
    
    [hour, min, sec] = extractTime(I);
    fprintf('| clock: %2d | hour: %7.2f | min: %7.2f | sec: %7.2f |\n', ...
            num, hour, min, sec);
end
