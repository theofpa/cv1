clear
% assuming the location of the vlfeat library is this
run('~/Downloads/vlfeat-0.9.21/toolbox/vl_setup')

% load images for training
load_data

% extract SIFT descriptors
sift_descriptors=feature_extraction(X);

% build visual vocabulary
[idx, c]=kmeans(sift_descriptors, 400);

% encode features using visual vocabulary
encoded=encoding;

% represent images by frequencies of words
histograms=bow_frequency;

% classification