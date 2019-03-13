% In order to run this download vlfeat:
% http://www.vlfeat.org/install-matlab.html.
% run('VLFEATROOT/toolbox/vl_setup') in prompt. VLFEATROOT == path


im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');

im1 = im2single(im1);
im2 = im2single(im2);

RANSAC(im1,im2,1,5);