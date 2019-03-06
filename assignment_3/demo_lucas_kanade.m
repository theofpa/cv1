% This is a demo for our Lucas-Kanade method
% This demo calls lucas_kanade.m and requires the files:
% - sphere1.ppm
% - sphere2.ppm
% - synth1.pgm
% - synth2.pgm

sphere1_orig = imread('sphere1.ppm');
sphere1 = im2double(rgb2gray(sphere1_orig));
sphere2 = im2double(rgb2gray(imread('sphere2.ppm')));

lucas_kanade(sphere1_orig, sphere1, sphere2, 2, 1)

synth1_orig = imread('synth1.pgm');
synth1 = im2double(synth1_orig);
synth2 = im2double(imread('synth2.pgm'));

lucas_kanade(synth1_orig, synth1, synth2, 10, 1)
