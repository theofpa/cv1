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
%descriptors=[];
%for i=1:size(img,1)
%    [~,d]=vl_phow(im2single(squeeze(img(i,:,:,:))), 'Color','rgb');
%    descriptors=[descriptors,double(d(:,:))'];
%end

% opponent-SIFT
%descriptors=[];
%for i=1:size(img,1)
%    [~,d]=vl_phow(im2single(squeeze(img(i,:,:,:))), 'Color','opponent');
%    descriptors=[descriptors,double(d(:,:))'];
%end

end