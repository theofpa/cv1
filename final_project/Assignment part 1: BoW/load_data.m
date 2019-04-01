% returns class_names, fold_indices, X and y
load("stl10_matlab/train.mat")

% airplaines 1
% birds 2
% ships 9
% horses 7
% cars 3
labels=[1,2,9,7,3];

% find the indices of the labels in scope
for i=1:5
    idx(i,:)=find(y==labels(i));
end

