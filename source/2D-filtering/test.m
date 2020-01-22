%% Be ready
clear all;
close all;
clc;

addpath('../utils/');
addpath('notchFilter/');

%% Girl Ht
[girlBefore, girlAfter] = filter_image();
figure('Name', '[Girl] Before');
imshow(girlBefore);
figure('Name', '[Girl] After');
imshow(girlAfter);

saveImage(girlBefore, '../images/girl/', 'before.jpg');
saveImage(girlAfter, '../images/girl/', 'after.jpg');
