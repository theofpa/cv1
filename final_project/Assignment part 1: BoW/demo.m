clear
% assuming the location of the vlfeat library is this
run('~/Downloads/vlfeat-0.9.21/toolbox/vl_setup')

% load images for training
load_data

% extract SIFT descriptors
tic
sift_descriptors=feature_extraction(Xvoc);
toc
% build visual vocabulary
tic
[c, ~]=vl_kmeans(sift_descriptors, 400);
toc
% encode features using visual vocabulary
tic
encodedX=encoding_histogram(Xhist,c);
toc
% represent images by frequencies of words
histograms=bow_frequency;

% classification