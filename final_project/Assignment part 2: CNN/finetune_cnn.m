classdef finetune_cnn < handle
   
   properties
   end
   
   methods(Static)

function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
 'libs' , 'matconvnet-1.0-beta25', 'matlab', 'vl_setupnn.m')) ;


opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = []; %[0]; % GPU



%% update model

net = update_model();

%% TODO: Implement getIMDB function below

%if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
%else
%  imdb = getIMDB() ;
%  mkdir(opts.expDir) ;
%  save(opts.imdbPath, '-struct', 'imdb') ;
%end

%%
net.meta.classes.name = imdb.imdb.meta.classes(:)' ;

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
disp(batch);
labels = imdb.images.labels(1,batch) ;
% labels = imdb.images.labels(batch,1) ;

if rand > 0.5, images=fliplr(images) ; end

end

function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end
% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb.imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
% function fn = getBatch(opts)
% % -------------------------------------------------------------------------
% switch lower(opts.networkType)
%   case 'simplenn'
%     fn = @(x,y) getSimpleNNBatch(x,y) ;
%   case 'dagnn'
%     bopts = struct('numGpus', numel(opts.train.gpus)) ;
%     fn = @(x,y) getDagNNBatch(bopts,x,y) ;
% end
% 
% end

% function [images, labels] = getSimpleNNBatch(imdb, batch)
% % -------------------------------------------------------------------------
% images = imdb.images.data(:,:,:,batch) ;
% disp(batch);
% labels = imdb.images.labels(1,batch) ;
% if rand > 0.5, images=fliplr(images) ; end
% 
% end

% -------------------------------------------------------------------------
function [imdb] = getIMDB()
    
load('train.mat')
TrainX = X;
TrainY = y;
TrainSet = single(ones(length(TrainY)));
load('test.mat')
TestX = X;
TestY = y;
TestSet = single(2*ones(length(TestY)));

x = [TrainX;TestX];
y = [TrainY;TestY];
type = [TrainSet(1,:),TestSet(1,:)];
disp(type(1:10))
% ------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image
index = zeros(length(y));
for i = 1:length(y)
if y(i,1) == 4
index(i,1) = i;
elseif y(i,1) == 5
index(i,1) = i;
elseif y(i,1) == 6
index(i,1) = i;
elseif y(i,1) == 8
index(i,1) = i;
elseif y(i,1) == 10
index(i,1) = i;
else
index(i,1) = 0;
end
end


for i = 1:length(y)
   if index(i,1) == 0
       New_X(i,:) = x(i,:);
       New_Y(i,:) = y(i,:);
       disp(type(i)) 
       disp(i)
       New_Set(i) = type(i);
   end
end

New_X(~any(New_X,2),:) = [];
New_Y(~any(New_Y,2),:) = [];
New_Set(~any(New_Set,2),:) = [];


%Pre allocation
data = single(zeros(32,32,3,length(New_Y)));
% labels = single(zeros(length(New_Y),1));
labels = single(zeros(1,length(New_Y)));

% set = single(zeros(length(New_Y),1));
set = single(zeros(1,length(New_Y)));

for i = 1 : length(New_Y)
    % Handle images
    img = reshape(New_X(i,:),[96,96,3]);
    img = imresize(img,[32,32]);
    data(:,:,:,i) = img;
    % Handle labels
    if New_Y(i,1) == 3
%         labels(i,1) = 5;
        labels(1,i) = 5;
    elseif New_Y(i,1) == 9
%         labels(i,1) = 3;
        labels(1,i) = 3;
    elseif New_Y(i,1) == 7
%         labels(i,1) = 4;
        labels(1,i) = 4;

    else
%         labels(i,1) = New_Y(i,1);
        labels(1,i) = New_Y(i,1);      
    end
    % Handle sets
%     set(i,1) = New_Set(i);
    set(1,i) = New_Set(i);

end



%%
% subtract mean
dataMean = single(mean(data(:, :, :, set == 1), 4));
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = set;
imdb.meta.sets = splits;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
    end
end