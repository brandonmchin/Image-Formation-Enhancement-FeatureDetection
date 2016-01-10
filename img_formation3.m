%===================================================
% Computer Vision Programming Assignment 1
% @Zhigang Zhu, 2003-2009
% City College of New York
% Brandon Chin, ID (Last Four Digits): 2938
%===================================================

% ------------------- PART 3 ------------------------
% Apply the 1x2 operator and Sobel operator to the image and analyze the
% results of the gradient magnitude images.  Generate edge maps of the
% above two combined gradient maps. 
InputImage = 'IDPicture.bmp';

C1 = imread(InputImage);

% 1x2 operator
No1 = figure;

A1 = rgb2gray(C1);
B1 = double(A1);
[rows, cols] = size(B1);
thresh = 20;

for i=1:cols
    for j=1:rows
        if (i == 1 || j == 1 || i == cols || j == rows)
            B1(j, i) = 255;
        else
            sx = (-(B1(j, i)) + B1(j + 1, i));
            sy = (-(B1(j, i)) + B1(j, i + 1));
            
            M = sqrt(sx.^2 + sy.^2);
            
            if (M < thresh)
                B1(j, i) = 0;
            else
                B1(j, i) = 255;
            end
        end
    end
end

subplot(1,2,1);
imshow(B1);
title('1x2 Operator');

% Sobel gradient 

A2 = rgb2gray(C1);
B2 = double(A2);

for i = 1:size(B2,1)-2
    for j = 1:size(B2,2)-2
        
        % horizontal-direction
        gradientX = ((2*B2(i+2,j+1)+B2(i+2,j)+B2(i+2,j+2))-(2*B2(i,j+1)+B2(i,j)+B2(i,j+2)));
                
        % vertical-direction
        gradientY = ((2*B2(i+1,j+2)+B2(i,j+2)+B2(i+2,j+2))-(2*B2(i+1,j)+B2(i,j)+B2(i+2,j)));
        
        % combined gradient
        A2(i,j) = sqrt(gradientX.^2 + gradientY.^2);
    end
end

subplot(1,2,2);
imshow(A2);
title('Sobel Operator');

suptitle('Gradient Maps');

% Edge maps

No2 = figure;

thresh = 100;

% 1x2 gradient edge map
edge1 = max(B1,thresh);
edge1(edge1 == round(thresh)) = 0;
edge1 = uint8(edge1);

subplot(1,2,1);
imshow(~edge1);
title('1x2 Gradient Edge Map');

% Sobel gradient edge map
edge2 = max(A2,thresh);
edge2(edge2 == round(thresh)) = 0;
edge2 = uint8(edge2);

subplot(1,2,2);
imshow(~edge2);
title('Sobel Gradient Edge Map');

suptitle('Edge Detected Image');