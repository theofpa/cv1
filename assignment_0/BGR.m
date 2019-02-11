function [] = BGR(img1)

img2=cat(3,img1(:,:,3),img1(:,:,2),img1(:,:,1));

subplot(2,1,1), imshow(img1);

subplot(2,1,2), imshow(img2);

end

