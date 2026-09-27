clc;
clear;
close all;

load('DR_Model_ResNet18.mat')

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

img = readimage(imds,1);

inputSize = trainedNet.Layers(1).InputSize;

imgResized = imresize(img,inputSize(1:2));

[label,scores] = classify(trainedNet,imgResized);

figure
imshow(img)
title(['Prediction: ',char(label)])

disp(label)
disp(max(scores))