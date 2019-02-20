
function [new_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
im = input_image;
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% ligtness method
lightness = (max(im,[],3) + min(im,[],3))./2;

% average method
average = (R+G+B)./3;

% luminosity method
luminosity = 0.21.*R + 0.72.*G + 0.07.*B;

% built-in MATLAB function 
matlab_grayscale = rgb2gray(input_image);

ax1 = subplot(2,2,1);
imshow(lightness)

ax2 = subplot(2,2,2);
imshow(average)

ax3 = subplot(2,2,3);
imshow(luminosity)

ax4 = subplot(2,2,4);
imshow(matlab_grayscale)

new_image = input_image;
end