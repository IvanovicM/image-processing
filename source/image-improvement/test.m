%% Be ready
clear all;
close all;
clc;

addpath('../utils/');

%% Disney
[disneyBefore, disneyAfter, disneyGray] = make_disney_better();
figure('Name', '[Disney] Before');
imshow(disneyBefore);
figure('Name', '[Disney] After');
imshow(disneyAfter);
figure('Name', '[Disney] Gray After');
imshow(disneyGray);

saveImage(disneyBefore, '../images/disney/', 'before.jpg');
saveImage(disneyAfter, '../images/disney/', 'after.jpg');
saveImage(disneyGray, '../images/disney/', 'afterGray.jpg');

%% Bristol
[bristolBefore, bristolAfter, bristolGray] = make_bristol_better();
figure('Name', '[Bristol] Before');
imshow(bristolBefore);
figure('Name', '[Bristol] After');
imshow(bristolAfter);
figure('Name', '[Bristol] Gray After');
imshow(bristolGray);

saveImage(bristolBefore, '../images/bristol/', 'before.jpg');
saveImage(bristolAfter, '../images/bristol/', 'after.jpg');
saveImage(bristolGray, '../images/bristol/', 'afterGray.jpg');

%% Giraffe
[giraffeBefore, giraffeAfter] = make_giraffe_better();
figure('Name', '[Giraffe] Before');
imshow(giraffeBefore);
figure('Name', '[Giraffe] After');
imshow(giraffeAfter);

saveImage(giraffeBefore, '../images/giraffe/', 'before.jpg');
saveImage(giraffeAfter, '../images/giraffe/', 'after.jpg');

%% Enigma
[enigmaBefore, enigmaAfter] = make_enigma_better();
figure('Name', '[Enigma] Before');
imshow(enigmaBefore);
figure('Name', '[Enigma] After');
imshow(enigmaAfter);

saveImage(enigmaBefore, '../images/enigma/', 'before.jpg');
saveImage(enigmaAfter, '../images/enigma/', 'after.jpg');

