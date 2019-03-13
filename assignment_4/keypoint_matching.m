function [matches] = keypoint_matching(im1,im2)


% In order to run this download vlfeat:
% http://www.vlfeat.org/install-matlab.html.
% run('VLFEATROOT/toolbox/vl_setup') in prompt. VLFEATROOT == path


%This function returns the supposed matches between region descriptors in
%each image. 

im1 = im2single(im1);
im2 = im2single(im2);

%%Implementing David Lowe's SIFT functions to extract and match
%%descriptors%%


threshold = 30; % Threshold for ubcmatch algorithm. higher is less keypoints. 

%Find Matches
[f1, d1] = vl_sift(im1) ;
[f2, d2] = vl_sift(im2) ;
[matches, scores] = vl_ubcmatch(d1, d2, threshold) ; %Index of matches and distance between scores

%Show images
figure; 
imshow(cat(2, im1, im2)) ;

%Determine coordinate vectors for lines
x1 = f1(1,matches(1,:)) ;
x2 = f2(1,matches(2,:)) + size(im1,2) ;
y1 = f1(2,matches(1,:)) ;
y2 = f2(2,matches(2,:)) ;

% Plot keypoints
vl_plotframe(f1(:,matches(1,:))) ;
f2(1,:) = f2(1,:) + size(im1,2) ;
vl_plotframe(f2(:,matches(2,:))) ;

% Plot lines
hold on ;
h = line([x1 ; x2], [y1 ; y2]);
set(h,'linewidth', 1) ;

end