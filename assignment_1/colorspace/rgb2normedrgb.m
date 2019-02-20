function [new_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[R, G, B] = getColorChannels(input_image);

RGB = R+G+B;

r = R./RGB;
g = G./RGB;
b = B./RGB;

new_image(:,:,1) = r;
new_image(:,:,2) = g;
new_image(:,:,3) = b;
end