%===================================================
% Computer Vision Programming Assignment 1
% @Zhigang Zhu, 2003-2009
% City College of New York
% Brandon Chin, ID (Last Four Digits): 2938
%===================================================

% ------------------- PART 2 ------------------------
% Generate the histogram of the intensity image and display it.
% Then perform histogram operations such as contrast enhancement,
% thresholding, and equalization to make the image visually better for both
% viewing and processing.

% Image thresholding is a way of partitioning an image into a foreground 
% and background.  It isolates objects by converting grayscale images into
% binary images.
InputImage = 'IDPicture.bmp';

C1 = imread(InputImage);

No1 = figure;

img_thresh = rgb2gray(C1);

threshold = 100;
img_thresh(img_thresh < threshold) = 0;
img_thresh(img_thresh > threshold) = 255;

imshow(img_thresh);
suptitle('Threshold Image');

% Histogram equalization enhances the contrast of images by transforming
% the values of an intensity image.
No2 = figure;

I = rgb2gray(C1);   % original intensity image
subplot(2,2,1);
imshow(I);
title('Original Image');

subplot(2,2,2);
imhist(I);     % display histogram

enhancedImg = histeq(I);    % apply histogram equalization
subplot(2,2,3)
imshow(enhancedImg);
title('Histogram Equalization Applied');

subplot(2,2,4);
imhist(enhancedImg);    % display histogram

suptitle('Histogram Equalization');