function [] = imgPieces(img1)

x=size(img1,1)
y=size(img1,2)
subplot(2,2,1), imshow(img1(1:x/2,y/2:end,:))
subplot(2,2,3), imshow(img1(x/2:end,y/2:end,:))
subplot(2,2,2), imshow(img1(1:x/2,1:y/2,:))
subplot(2,2,4), imshow(img1(x/2:end,1:y/2,:))

end

