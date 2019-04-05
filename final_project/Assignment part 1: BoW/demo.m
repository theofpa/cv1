clear
clc
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
%[c, ~]=vl_kmeans(sift_descriptors, 400);
[c, ~]=vl_kmeans(sift_descriptors, 1000);
%[c, ~]=vl_kmeans(sift_descriptors, 4000);
toc
% encode features using visual vocabulary
tic
encodedX=encoding_histogram(Xhist,c);
toc

% classification
preprocess
for i=labels
    classifier{i}=fitcsvm(encodedX, ysplit{i}, 'KernelFunction', 'rbf');
end

% evaluation
load_test

tic
encodedX=encoding_histogram(X,c);
toc

k=1;
acc=[];
for j=1:5
    [testlabels{labels(j)}, scores{labels(j)}]=predict(classifier{labels(j)}, encodedX);
    lidx=find(testlabels{labels(j)}==1);
    %size(lidx)
    for i=1:5
        subplot(5,5,k);
        imshow(reshape(X(lidx(i),:), 96, 96, 3));
        k=k+1;
    end
    [precision,recall,accuracy]=precision_recall(y==labels(j),testlabels{labels(j)});
    acc=[acc; accuracy];
end
mean(acc)
