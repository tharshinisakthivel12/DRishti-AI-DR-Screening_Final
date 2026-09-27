clc;
clear;
close all;

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

img = readimage(imds,1);

figure
imshow(img)
title("Original Retinal Image")

gray = rgb2gray(img);

focusScore = std2(del2(double(gray)));

brightnessScore = mean(gray(:));

contrastScore = std(double(gray(:)));

fprintf("Focus Score     : %.2f\n",focusScore);
fprintf("Brightness      : %.2f\n",brightnessScore);
fprintf("Contrast Score  : %.2f\n",contrastScore);