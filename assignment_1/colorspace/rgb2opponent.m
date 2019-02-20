function [new_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[R, G, B] = getColorChannels(input_image);

O1 = (R-G)./sqrt(2);
O2 = (R+G - 2.*B)./sqrt(6);
O3 = (R+G+B)./sqrt(3);

new_image(:,:,1) = O1;
new_image(:,:,2) = O2;
new_image(:,:,3) = O3;
end