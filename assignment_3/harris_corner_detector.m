function [H, r, c] = harris_corner_detector(I, threshold, rot_angle, bool_plot)
% Detects corners in an image using the cornerness formula, the two
% eighenvalues lambda1 and lambda2

% parameters:
%  image I on which should find the corners
%  threshold alpha for the local maximum

% returns:
%  cornerness (H matrix)
%  rows r of the detected corner points
%  columns c of the detected corner points

% plots 3 figures:
%  computed image derivatives I_x and I_y
%  the original images with the corner points plotted on it

I = imrotate(imread(I), rot_angle);

% compute the elements of Q. To do that, you need to
% calculate I_x , which is the smoothed derivative of the image
% That can be obtained by convolving the first order Gaussian derivative
% with the image I along the x-direction
[gaussian_x, gaussian_y] = gradient(fspecial('gaussian', [5 5], 4));
I_x = conv2(rgb2gray(I), gaussian_x);
I_y = conv2(rgb2gray(I), gaussian_y);

% A can be obtained by squaring I_x, and then convolving it with a Gaussian
% Similarly B and C, ex C is I_y squared
A = conv2(I_x .* I_x, fspecial('gaussian', [5 5], 4));
B = conv2(I_x .* I_y, fspecial('gaussian', [5 5], 4));
C = conv2(I_y .* I_y, fspecial('gaussian', [5 5], 4));

% Use formula 12 to compute the cornerness
H = (A .* C - (B .^2)) -threshold * (A + C).^2;
[r, c] = find(H > threshold); %rows and columns of corners

if bool_plot == 1
    % Plot original image I_x, I_y, I and corners
    figure
    subplot(131), (imshow(I_x));
    subplot(132), imshow(I_y);
    subplot(133), imshow(I);
    hold on;
    plot(c, r, 'r+','MarkerSize',8);
end

end