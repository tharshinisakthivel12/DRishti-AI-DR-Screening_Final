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

fprintf('\n===== DR SCREENING REPORT =====\n');

fprintf('Prediction : %s\n',char(label));
fprintf('Confidence : %.2f %%\n',max(scores)*100);

if strcmp(char(label),'No Diabetic Retinopathy')
    fprintf('Recommendation : Routine Follow-Up\n');
else
    fprintf('Recommendation : Refer To Ophthalmologist\n');
end

fprintf('Status : Analysis Complete\n');
fprintf('==============================\n');