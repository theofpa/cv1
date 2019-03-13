function [stiched] = stitch(im1, im2, threshold, n, p)

% get the transformed image from RANSAC when it is ready
[~, im2_trans, corners_trans] = RANSAC(im2, im1, n, p);
max_corners = ceil(max(corners_trans, [], 2));

[h, w] = size(im1);
h = max(h, max_corners(2));
w = max(w, max_corners(1));

stiched_l = zeros(h, w);
stiched_r = zeros(h, w);

shift = floor(min(corners_trans, [], 2));

[h, w] = size(im1);
shift_l = -min(shift, [0; 0]);
stiched_l(1+shift_l(2):h+shift_l(2), 1+shift_l(1):w+shift_l(1)) = mat2gray(im1);
[h, w] = size(im2_trans); 
shift_r = max(shift, [0; 0]);
stiched_r(1+shift_r(2):h+shift_r(2), 1+shift_r(1):w+shift_r(1)) = im2_trans;


stiched = max(stiched_l, stiched_r);

mean_stitch = (stiched_l + stiched_r)/2.;
select = (stiched_l > 0 & stiched_r > 0);
stiched(select) = mean_stitch(select);

end
