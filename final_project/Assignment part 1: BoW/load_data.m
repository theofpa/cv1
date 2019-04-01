% assuming the stl10 dataset is extracted in this directory
% returns 5000 images' class_names, fold_indices, X and y
load("stl10_matlab/train.mat")

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

% reshape images to the 96x96 representation
X=reshape(X,2500,96,96,3);

% limit the size for faster execution
X=datasample(X,500);