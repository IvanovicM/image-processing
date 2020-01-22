%% Be ready
clear all;
close all;
clc;

addpath('../utils/');

%% Etf Image
[etfBefore, etfAfter] = makeEtfBetter('../images/etf/');
figure('Name', '[ETF] Before');
imshow(etfBefore);
figure('Name', '[ETF] After');
imshow(etfAfter);

saveImage(etfBefore, '../images/etf/', 'before.jpg');
saveImage(etfAfter, '../images/etf/', 'after.jpg');
