function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
I = image;

sobel_y = [1 2 1;0 0 0;-1 -2 -1];
sobel_x = sobel_y.';


Gx = imfilter(I, sobel_x, 'conv');
Gy = imfilter(I, sobel_y, 'conv');

im_magnitude = (Gx.^2 + Gy.^2);

% direction in radians
im_direction = atan(Gy./Gx);

visualize(Gy, Gy, im_magnitude, im_direction)
end


function visualize(im1, im2, im3, im4)
figure;
subplot(2,2,1);
imshow(im1);

subplot(2,2,2);
imshow(im2);

subplot(2,2,3);
imshow(im3);

subplot(2,2,4);
imshow(im4);
end
