function [matches] = keypoint_matching_demo_function()


% In order to run this download vlfeat:
% http://www.vlfeat.org/install-matlab.html.
% run('VLFEATROOT/toolbox/vl_setup') in prompt. VLFEATROOT == path


%This function returns the supposed matches between region descriptors in
%each image. 

%Load imgs
img1 = imread('boat1.pgm');
img2 = imread('boat2.pgm');
im1 = im2single(img1);
im2 = im2single(img2);

keypoint_matching(im1,im2)

end