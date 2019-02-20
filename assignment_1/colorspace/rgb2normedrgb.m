function [new_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
im = input_image;

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

RGB = R+G+B;

r = R./RGB;
g = G./RGB;
b = B./RGB;

new_image(:,:,1) = r;
new_image(:,:,2) = g;
new_image(:,:,3) = b;
end