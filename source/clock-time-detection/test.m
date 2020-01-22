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
fprintf('| clock | hour  |  min  |  sec  |\n');
for num = 1:12
    name = sprintf('../data/clocks/clock%d.%s', num, exten(num, :));
    I = im2double(imread(name));
    
    [hour, min, sec] = extract_time(I);
    fprintf('| %5d | %5.2f | %5.2f | %5.2f |\n', num, hour, min, sec);
end
