function [descriptors] = feature_extraction(X)

% densely sampled regions
% help vl_dsift: input image must be of class SINGLE and grayscale.
descriptors=[];
for i=1:length(X)
    [~,d]=vl_dsift(rgb2gray(im2single(squeeze(X(i,:,:,:)))));
    descriptors=[descriptors,double(d(:,:))'];
end
% key points

% grayscale SIFT

% RGB-SIFT

% opponent-SIFT