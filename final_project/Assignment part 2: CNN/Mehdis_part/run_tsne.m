% Load data
load('data/cnn_assignment-lenet/imdb-stl.mat');
all_data = imdb.images.data;
all_labels = imdb.images.labels;
test_data = all_data(:, :, :, 2501:end); % 4000 x 64
test_labels = all_labels(2501:end);

colors = zeros(length(test_labels), 1);
disp(size(colors));
% No idea with the colours don't correlate to the actual plot

for i = 1:length(test_labels)
    if test_labels(i) == 1
        colors(i) = 'r';
    elseif test_labels(i) == 2
        colors(i) = 'g';
    elseif test_labels(i) == 3
        colors(i) = 'b';        
    elseif test_labels(i) == 4
        colors(i) = 'y';
    elseif test_labels(i) == 5
        colors(i) = 'm';
    end
end


% Load model
load('data/cnn_assignment-lenet/pre_trained_model.mat');
%load('data/cnn_assignment-lenet/finetunedbatch50epoch120.mat');
net.layers = net.layers(:, 1:end-1);

X = zeros(length(test_data), 64); % 4000 x 64

for i = 1:length(test_data)
   sample_data = test_data(:, :, :, i);
   forward = vl_simplenn(net, sample_data);
   values = forward(12).x(:, :, :);
   X(i, :) = values;
end

y_data = tsne(X, [], 2, 64, 50);

scatter(y_data(:, 1), y_data(:, 2), [], colors, '.')
