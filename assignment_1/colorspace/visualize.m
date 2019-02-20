function visualize(new_image)
figure;

imSize = size(new_image);

if imSize(3) > 3
    first = new_image(:,:,4);
else
    first = new_image;
end

subplot(2,2,1);
imshow(first);

subplot(2,2,2);
imshow(new_image(:,:,1));

subplot(2,2,3);
imshow(new_image(:,:,2));

subplot(2,2,4);
imshow(new_image(:,:,3))
end