%% Be ready
clear all;
close all;
clc;

addpath('../utils/');

%% Test Einstein
I = imread('../sekvence/einstein_lc.tif');
I = double(I) / 255;
dir = '../images/dos_clhe/einstein/';

% Isprobavanje razlicitih limita.
for limit = [0, 0.001, 0.01, 0.1, 1]
    J = clhe(I, 8, limit);
    saveImage(J, dir, ['limit=', num2str(limit), '.jpg']);
end

% Najbolje - empirijski odredjeno.
J = clhe(I, 8, 0.02);

figure('Name', '[Einstein] Before'); imshow(I); saveImage(I, dir, 'before.jpg');
figure('Name', '[Einstein] After'); imshow(J); saveImage(J, dir, 'after.jpg');
f = figure('Name', '[Einstein] Hist Before'); imhist(I); saveFigure(f, dir, 'beforeHist.jpg');
f = figure('Name', '[Einstein] Hist After'); imhist(J); saveFigure(f, dir, 'afterHist.jpg');
%% Test Bristol
hdrI = hdrread('../sekvence/bristolb.hdr');
I = lin2rgb(hdrI);
dir = '../images/dos_clhe/bristol/';

% Isprobavanje razlicitih limita.
for limit = [0, 0.001, 0.01, 0.1, 1]
    [vI, vJ, J] = clhe_color(I, 16, limit);
    saveImage(J, dir, ['limit=', num2str(limit), '.jpg']);
end

% Najbolje - empirijski odredjeno.
[vI, vJ, J] = clhe_color(I, 16);

figure('Name', '[Bristol] Before Gray'); imshow(vI); saveImage(vI, dir, 'beforeGray.jpg');
figure('Name', '[Bristol] After Gray'); imshow(vJ); saveImage(vJ, dir, 'afterGray.jpg');
f = figure('Name', '[Bristol] Hist Before Gray'); imhist(vI); saveFigure(f, dir, 'beforeHist.jpg');
f = figure('Name', '[Bristol] Hist After Gray'); imhist(vJ); saveFigure(f, dir, 'afterHist.jpg');

figure('Name', '[Bristol] Before'); imshow(I); saveImage(I, dir, 'before.jpg');
figure('Name', '[Bristol] After'); imshow(J); saveImage(J, dir, 'after.jpg');