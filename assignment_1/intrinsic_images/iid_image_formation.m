% iid_image_formation.m
% This file shows four images: the original image, the albedo image,
% the shading image and the reconstructed image from the albedo and shading
%
% This is done by multiplying the shading by the colours, since the shading
% shows the amount of light falling on a certain spot

original = imread('ball.png');
albedo = imread('ball_albedo.png');
shading = imread('ball_shading.png');

% im2double transorms int values to double values between 0 and 1
albedo2 = im2double(albedo);
shading2 = im2double(shading);

% Seperate RGB values to individually elementwise multiplicate with shading
R = albedo2(:, :, 1);
G = albedo2(:, :, 2);
B = albedo2(:, :, 3);
reconstructed = albedo2;
reconstructed(:, :, 1) = R.*(shading2);
reconstructed(:, :, 2) = G.*(shading2);
reconstructed(:, :, 3) = B.*(shading2);

% Show all four images
subplot(2,2,1), imshow(albedo);
subplot(2,2,2), imshow(shading);
subplot(2,2,3), imshow(original);
subplot(2,2,4), imshow(reconstructed); 