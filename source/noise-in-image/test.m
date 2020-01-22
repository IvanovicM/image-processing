%% Be ready
clear all;
close all;
clc;

addpath('../utils/');

%% Read images
I = im2double(imread('../../sekvence/lena_noise.tif'));
Iref = im2double(imread('../../sekvence/lena.tif'));

%% Experiment only with image.
dir = '../images/lena/';
allVars = experiment_for_noise_var(I, dir, 2 : 500, false);
fprintf('Estimated noise var for K = 10 is %.4f.\n', allVars(9));