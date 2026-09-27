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

%% Referable DR
referableClasses = [ ...
    "Moderate Diabetic Retinopathy", ...
    "Severe Diabetic Retinopathy", ...
    "Proliferative Diabetic Retinopathy"];

ActualReferable = ismember(string(YTest),referableClasses);
PredReferable   = ismember(string(YPred),referableClasses);

TP = sum( ActualReferable & PredReferable );
TN = sum(~ActualReferable & ~PredReferable);
FP = sum(~ActualReferable & PredReferable);
FN = sum( ActualReferable & ~PredReferable);

Sensitivity = TP/(TP+FN);
Specificity = TN/(TN+FP);
Accuracy = (TP+TN)/(TP+TN+FP+FN);

fprintf('\n===== REFERABLE DR METRICS =====\n');
fprintf('Sensitivity = %.2f %%\n',Sensitivity*100);
fprintf('Specificity = %.2f %%\n',Specificity*100);
fprintf('Accuracy    = %.2f %%\n',Accuracy*100);

fprintf('\nTP = %d\n',TP);
fprintf('TN = %d\n',TN);
fprintf('FP = %d\n',FP);
fprintf('FN = %d\n',FN);

fprintf('================================\n');