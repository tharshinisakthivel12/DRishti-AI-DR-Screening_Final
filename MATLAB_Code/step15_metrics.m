clc;
clear;
close all;

load('DR_Model_ResNet18.mat')

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

[~,~,imdsTest] = splitEachLabel( ...
    imds,...
    0.7,...
    0.15,...
    0.15,...
    "randomized");

inputSize = trainedNet.Layers(1).InputSize;

augTest = augmentedImageDatastore( ...
    inputSize(1:2), ...
    imdsTest);

YPred = classify(trainedNet,augTest);
YTest = imdsTest.Labels;

cm = confusionmat(YTest,YPred);

disp("Confusion Matrix")
disp(cm)

accuracy = sum(diag(cm))/sum(cm(:));

fprintf("Accuracy = %.2f %%\n",accuracy*100);