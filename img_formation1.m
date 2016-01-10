%===================================================
% Computer Vision Programming Assignment 1
% @Zhigang Zhu, 2003-2009
% City College of New York
% Brandon Chin, ID (Last Four Digits): 2938
%===================================================

% ------------------ PART 1A ------------------------
% Read in a color image and display it

InputImage = 'IDPicture.bmp';

C1 = imread(InputImage);    % C1 is an array containing the image data
[ROWS, COLS, CHANNELS] = size(C1);   

No1 = figure;
image(C1);  % display the image from array C1
suptitle('Original Image');

% ------------------ PART 1B ------------------------
% Display the images of the three color components R(x,y), G(x,y), B(x,y),
% seperately.  You should display three grayscale-like images.

CR1 =uint8(zeros(ROWS, COLS, CHANNELS));    % generates a blank image

% "uinit8" will give you an image of unsigned 8-bit integer pixels 
% (Matlab will generate everything as double by default).

% "zeros()" initializes all values to 0.

% Assigns the Red band of the color image C1 into each band of the 
% three-band grayscale image CR1
for band = 1 : CHANNELS,
    CR1(:,:,band) = C1(:,:,1);
end

% Do the same thing for the Green band
CG1 =uint8(zeros(ROWS, COLS, CHANNELS));
for band = 1 : CHANNELS,
    CG1(:,:,band) = (C1(:,:,2));
end

% and for the Blue band
CB1 =uint8(zeros(ROWS, COLS, CHANNELS));
for band = 1 : CHANNELS,
    CB1(:,:,band) = (C1(:,:,3));
end

No2 = figure;

subplot(2,2,1);
imshow(C1);
title('Original Image');

subplot(2,2,2);
imshow(CR1);
title('Red Band Image');

subplot(2,2,3);
imshow(CG1);
title('Green Band Image');

subplot(2,2,4);
imshow(CB1);
title('Blue Band Image');

% "subplot(m,n,p)" divides the Figure window into an mxn matrix and selects
% the p-th axes for the current plot

suptitle('Color Band Images');

% ------------------- PART 1C ------------------------
% Generate an intensity image I(x,y) and display it.  Use the equation
% I=0.299R+0.587G+0.0.114B (the NTSC standard for luminance).

I1 = uint8(zeros(ROWS,COLS,CHANNELS));

for band = 1 : CHANNELS,
    I1(:,:,band) = C1(:,:,1)*0.299 + C1(:,:,2)*0.587 + C1(:,:,3)*0.114;
end

No3 = figure;
image(I1);
suptitle('Intensity Image');

% ------------------- PART 1D ------------------------
% Uniformly quantize the original intensity image into K levels (with K=4,
% 16, 32, 64).  Display the four quantized images with four different K
% levels.

No4 = figure;
K = [4, 16, 32, 64];

for level = 1:length(K)
    
    quantizedImg = I1;
    
    div = round(linspace(0, 255, K(level)+1));
    
    for i = 1:length(div)-1
        quantizedImg(quantizedImg < div(i+1) & quantizedImg >= div(i)) = div(i);
    end
    
    subplot(2,2,level);
    imshow(quantizedImg);
    str = sprintf('K = %i', K(level));
    title(str);
end

% "round(X)" rounds the element(s) of X to the nearest integer(s).

% "linspace(X1, X2, N)" generates a row vector of N equally spaced points
% between X1 and X2.

suptitle('Intensity Image Quantization');

% ------------------- PART 1E ------------------------
% Quantize the original three-band color image C1 into K level color images
% CK with uniform intervals and display them. 

No5 = figure;
K = [2, 4];

for level = 1:length(K)
    
    quantizedColorImg = C1;
    redBand = quantizedColorImg(:,:,1);
    greenBand = quantizedColorImg(:,:,2);
    blueBand = quantizedColorImg(:,:,3);
    
    div = round(linspace(0, 255, K(level)+1));
    
    for i = 1:length(div)-1
        redBand(redBand >= div(i) & redBand < div(i+1)) = div(i);
        greenBand(greenBand >= div(i) & greenBand < div(i+1)) = div(i);
        blueBand(blueBand >= div(i) & blueBand < div(i+1)) = div(i);
    end
    
    quantizedColorImg = cat(3, redBand, greenBand, blueBand);
    subplot(1,2,level);
    imshow(quantizedColorImg);
    str = sprintf('K = %i', K(level));
    title(str);
end

suptitle('Color Image Quantization');

% ------------------- PART 1F ------------------------
% Quantize the original three-band color image C1 into a color image CL
% with a logarithmic function and display it.  

No6 = figure('units','normalize','outerposition',[0,0,1,1]);

logImg = C1;
originalRedBand = double(logImg(:,:,1));
originalGreenBand = double(logImg(:,:,2));
originalBlueBand = double(logImg(:,:,3));

% double(X) converts X to double precision

a = 0.15;       % 'a' can be any constant

redBandLog = a.*log(originalRedBand + 1);
greenBandLog = a.*log(originalGreenBand + 1);
blueBandLog = a.*log(originalBlueBand + 1);

logImg = cat(3, redBandLog, greenBandLog, blueBandLog);

% original image
subplot(2,4,1);
imshow(C1);
title('Original Image');

% logarithmic image
subplot(2,4,5);
imshow(logImg);
title('Logarithmic Image');

% original red band image
subplot(2,4,2);
imshow(originalRedBand, []);
title('Original Red Band Image');

% logarithmic red band image
subplot(2,4,6);
imshow(redBandLog);
title('Logarithmic Red Band Image');

% original green band image
subplot(2,4,3);
imshow(originalGreenBand, []);
title('Original Green Band Image');

% logarithmic green band image
subplot(2,4,7);
imshow(greenBandLog);
title('Logarithmic Green Band Image');

% original blue band image
subplot(2,4,4);
imshow(originalBlueBand, []);
title('Original Blue Band Image');

% logarithmic blue band image
subplot(2,4,8);
imshow(blueBandLog);
title('Logarithmic Blue Band Image');

suptitle('Quantization Using Log Function');