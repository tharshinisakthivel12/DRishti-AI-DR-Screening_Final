clc;
clear;
close all;

% Load Dataset
imds = imageDatastore( ...
    "Diabetic_Retinopathy_Dataset", ...
    "IncludeSubfolders", true, ...
    "LabelSource", "foldernames");

% Read Image
img = readimage(imds,1);

% Extract Green Channel
green = img(:,:,2);

% Enhance Contrast
greenEq = adapthisteq(green);

% Smooth Image
greenSmooth = imgaussfilt(greenEq,2);

% Find Bright Regions
threshold = prctile(greenSmooth(:),99);

BW = greenSmooth > threshold;

% Remove Small Objects
BW = bwareaopen(BW,50);

% Fill Holes
BW = imfill(BW,'holes');

% Measure Regions
stats = regionprops(BW,...
    'Area',...
    'Centroid',...
    'BoundingBox');

% Display Result
figure

subplot(1,2,1)
imshow(img)
title('Original Retinal Image')

subplot(1,2,2)
imshow(img)
title('Optic Disc Localization')
hold on

if ~isempty(stats)

    [~,idx] = max([stats.Area]);

    center = stats(idx).Centroid;
    box = stats(idx).BoundingBox;

    rectangle( ...
        'Position',box,...
        'EdgeColor','g',...
        'LineWidth',2);

    plot(center(1),center(2),...
        'r*',...
        'MarkerSize',20,...
        'LineWidth',2);

    text(center(1)+20,...
        center(2),...
        'Optic Disc',...
        'Color','yellow',...
        'FontSize',12,...
        'FontWeight','bold');

    fprintf('Optic Disc Found\n');
    fprintf('X = %.2f\n',center(1));
    fprintf('Y = %.2f\n',center(2));

else

    fprintf('Optic Disc Not Detected\n');

end