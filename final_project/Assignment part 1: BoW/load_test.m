% assuming the stl10 dataset is extracted in this directory
% returns 5000 images' class_names, fold_indices, X and y
load("stl10_matlab/test.mat")

% airplaines 1
% birds 2
% ships 9
% horses 7
% cars 3
labels=[1,2,9,7,3];

% find the indices of the labels in scope
idx=[];
for i=1:5
    idx=[idx;find(y==labels(i))];
end

% filter images and labels to the labels in scope
X=X([idx],:);
y=y([idx],:);
