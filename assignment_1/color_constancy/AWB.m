
function [img1, img2] = AWB(image)

img1 = imread(image);

r = img1(:,:,1); % red channel
g = img1(:,:,2); % green channel
b = img1(:,:,3); % blue channel

meanR = mean(r); % red average
meanG = mean(g); % green average
meanB = mean(b); % blue average

% Color adjustment Von Kries
gray = (meanR+meanG+meanB)/3;

R = (gray/meanR)*r;
G = (gray/meanG)*g;
B = (gray/meanB)*b;

img2 = cat(3,R,G,B);

subplot(2,1,1), imshow(img1);

subplot(2,1,2), imshow(img2);

end

% run AWB('awb.jpg')