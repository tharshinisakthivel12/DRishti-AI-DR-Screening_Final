clc;
clear;
close all;

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

img = readimage(imds,1);

gray = rgb2gray(img);

enhanced = adapthisteq(gray);

figure

subplot(1,2,1)
imshow(gray)
title("Original Image")

subplot(1,2,2)
imshow(enhanced)
title("CLAHE Enhanced Image")