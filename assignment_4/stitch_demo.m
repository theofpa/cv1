im1 = rgb2gray(imread('left.jpg'));
im2 = rgb2gray(imread('right.jpg'));

[stiched] = stitch(im1, im2, 50, 40);

figure;
subplot(131);
imshow(im1);
title('im1');
subplot(132);
imshow(im2);
title('im2');
subplot(133);
imshow(stiched);
title('stitched');