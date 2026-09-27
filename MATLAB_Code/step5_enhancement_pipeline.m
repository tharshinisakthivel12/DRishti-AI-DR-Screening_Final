clc;
clear;
close all;

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

img = readimage(imds,1);

gray = rgb2gray(img);

% CLAHE
claheImg = adapthisteq(gray);

% Denoising
denoiseImg = imbilatfilt(claheImg);

% Illumination Normalization
background = imopen(denoiseImg, strel('disk',30));
normalizedImg = imsubtract(denoiseImg, background);

figure

subplot(2,2,1)
imshow(gray)
title('Original')

subplot(2,2,2)
imshow(claheImg)
title('CLAHE')

subplot(2,2,3)
imshow(denoiseImg)
title('Denoised')

subplot(2,2,4)
imshow(normalizedImg)
title('Illumination Normalized')