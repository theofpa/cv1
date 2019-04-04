function [descriptors] = feature_extraction(img)

% densely sampled regions
% help vl_dsift: input image must be of class SINGLE and grayscale.
descriptors=[];
stepPixels=4;
sizePixels=5;
descriptorGeometry=[4 4 8];
for i=1:size(img,1)
    [~,d]=vl_dsift(...
        rgb2gray(im2single(reshape(squeeze(img(i,:)),96,96,3))),...
        'step', stepPixels,...
        'geometry', descriptorGeometry,...
        'size', sizePixels);
    descriptors=[descriptors,double(d(:,:))'];
end
% key points

% grayscale SIFT

% RGB-SIFT
%descriptors2=[];
%for i=1:length(X)
%    [~,d]=vl_phow(im2single(squeeze(X(i,:,:,:))), 'Color','rgb');
%    descriptors2=[descriptors2,double(d(:,:))'];
%end

% opponent-SIFT
%descriptors3=[];
%for i=1:length(X)
%    [~,d]=vl_phow(im2single(squeeze(X(i,:,:,:))), 'Color','opponent');
%    descriptors3=[descriptors3,double(d(:,:))'];
%end

end