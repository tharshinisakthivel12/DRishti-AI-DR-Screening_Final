clc;
clear;
close all;

imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

img = readimage(imds,1);

green = img(:,:,2);

green = adapthisteq(green);

% Find darkest regions
BW = imbinarize(imcomplement(green),0.8);

BW = bwareaopen(BW,100);

stats = regionprops(BW,'Centroid','Area');

figure
imshow(img)
title('Fovea Localization')
hold on

if ~isempty(stats)

    [~,idx] = max([stats.Area]);

    center = stats(idx).Centroid;

    plot(center(1),center(2),...
        'g*','MarkerSize',15)

    text(center(1)+20,...
        center(2),...
        'Fovea',...
        'Color','yellow',...
        'FontSize',12)

end