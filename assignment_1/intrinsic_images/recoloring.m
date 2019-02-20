% recoloring.m
% This file shows three images: the green albedo image, the original image,
% and the reconstructed image from the green albedo image
% 
% The green albedo image is constructed by setting the red and blue values
% to 0. Afterwards the green values bigger than 0 (which were 141) are
% set to 255 since it should be green.
%
% The image is reconstructed similarly to iid_image_formation.m

original = imread('ball.png');
albedo = imread('ball_albedo.png');
shading = imread('ball_shading.png');

G = albedo(:, :, 2);
[h, w] = size(G);

green_albedo = albedo;
green_albedo(:, :, 1) = zeros(266, 480);
green_albedo(:, :, 3) = zeros(266, 480);

for xdim=1:h
    for ydim=1:w
        if G(xdim, ydim) > 0
           green_albedo(xdim, ydim, 2) = 255;
        end
    end
end

% Reconstruct using the green albedo
albedo2 = im2double(green_albedo);
shading2 = im2double(shading);
R = albedo2(:, :, 1);
G = albedo2(:, :, 2);
B = albedo2(:, :, 3);
reconstructed = albedo2;
reconstructed(:, :, 1) = R.*(shading2);
reconstructed(:, :, 2) = G.*(shading2);
reconstructed(:, :, 3) = B.*(shading2);

% Show green albedo, original and reconstruction using the green albedo
subplot(2,2,1), imshow(green_albedo);
subplot(2,2,2), imshow(shading);
subplot(2,2,3), imshow(original);
subplot(2,2,4), imshow(reconstructed); 

% To check the colour values in a range from 0-255
reconstructed_values = im2uint8(reconstructed);