
function [new_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
im = input_image;
[R, G, B] = getColorChannels(input_image);

% ligtness method
lightness = (max(im,[],3) + min(im,[],3))./2;

% average method
average = (R+G+B)./3;

% luminosity method
luminosity = 0.21.*R + 0.72.*G + 0.07.*B;

% built-in MATLAB function 
matlab_grayscale = rgb2gray(input_image);


new_image(:,:,1) = average;
new_image(:,:,2) = luminosity;
new_image(:,:,3) = matlab_grayscale;
new_image(:,:,4) = lightness;
end