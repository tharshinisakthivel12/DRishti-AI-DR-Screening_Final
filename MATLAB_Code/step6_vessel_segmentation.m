clc;
clear;
close all;

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

img = readimage(imds,1);

% Green channel gives best vessel contrast
greenChannel = img(:,:,2);

% Enhance
greenChannel = adapthisteq(greenChannel);

% Adaptive threshold
BW = imbinarize(greenChannel,'adaptive');

% Remove small noise
BW = bwareaopen(BW,50);

figure

subplot(1,2,1)
imshow(img)
title('Original Retina')

subplot(1,2,2)
imshow(BW)
title('Blood Vessel Segmentation')