function [descriptors] = feature_extraction(X)

% densely sampled regions
% help vl_dsift: input image must be of class SINGLE and grayscale.
descriptors=[];
stepPixels=1;
descriptorGeometry=[4 4 8];
for i=1:length(X)
    [~,d]=vl_dsift(rgb2gray(im2single(squeeze(X(i,:,:,:)))), 'step', stepPixels, 'geometry', descriptorGeometry);
    descriptors=[descriptors,double(d(:,:))'];
end
% key points

% grayscale SIFT

% RGB-SIFT
descriptors2=[];
for i=1:length(X)
    [~,d]=vl_phow(im2single(squeeze(X(i,:,:,:))), 'Color','rgb');
    descriptors2=[descriptors2,double(d(:,:))'];
end

% opponent-SIFT
descriptors3=[];
for i=1:length(X)
    [~,d]=vl_phow(im2single(squeeze(X(i,:,:,:))), 'Color','opponent');
    descriptors3=[descriptors3,double(d(:,:))'];
end

end