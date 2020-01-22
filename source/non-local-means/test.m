%% Be ready
clear all;
close all;
clc;

addpath('../utils/');

%% Init Lena
dir = '../images/non_local/';
var = 0.0078;
h = 0.05;

I = im2double(imread('../../sekvence/lena_noise.tif'));
Iref = im2double(imread('../../sekvence/lena.tif'));

saveImage(I, dir, 'before.jpg');
saveImage(Iref, dir, 'reference.jpg');

%% Test for various values.
K = [3, 5, 9];
S = [15, 33, 51];
psnrStats = zeros(length(K), length(S));
timeStats = zeros(length(K), length(S));

for ix = 1 : length(K)
    for jx = 1 : length(S)
        disp(['Calculating for K = ', num2str(K(ix)), ...
              ', S = ', num2str(S(jx)), ' ...']);

        % Filter and save image. Save Time stats.
        tic;
        J = non_local_means(I, K(ix), S(jx), var, h);
        timeStats(ix, jx) = toc;
        saveImage(J, dir, ['K=', num2str(K(ix)), ';S=', num2str(S(jx)) '.jpg']);

        % Save PSNR stats.
        psnrStats(ix, jx) = psnr(J, Iref);
    end
end
plot_and_save_stats(psnrStats, timeStats, K, S, dir);