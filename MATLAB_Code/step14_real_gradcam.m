clc;
clear;
close all;

load('DR_Model_ResNet18.mat')

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

%% Select Image

img = readimage(imds,1);

inputSize = trainedNet.Layers(1).InputSize;

imgResized = imresize(img,inputSize(1:2));

%% Predict

[label,scores] = classify(trainedNet,imgResized);

%% Generate Grad-CAM

scoreMap = gradCAM( ...
    trainedNet,...
    imgResized,...
    label);

%% Display

figure

subplot(1,2,1)
imshow(img)
title("Original Fundus Image")

subplot(1,2,2)
imshow(imgResized)
hold on

imagesc(scoreMap,...
    'AlphaData',0.5)

colormap jet
colorbar

title(sprintf( ...
    'Grad-CAM\n%s\nConfidence = %.2f%%', ...
    char(label), ...
    max(scores)*100))