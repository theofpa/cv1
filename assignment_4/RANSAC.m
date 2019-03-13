function [] = RANSAC(im1, im2, N, P)

%%Implementing David Lowe's SIFT functions to extract and match
%%descriptors%%

threshold = 30; % Threshold for ubcmatch algorithm. higher is less keypoints. 

%Find Matches
[f1, d1] = vl_sift(im1) ;
[f2, d2] = vl_sift(im2) ;
[matches, scores] = vl_ubcmatch(d1, d2, threshold) ; %Index of matches and distance between scores

% %Show images
% figure; 
% imshow(cat(2, im1, im2)) ;

%Determine coordinate vectors for lines
x1 = f1(1,matches(1,:)) ;
x2 = f2(1,matches(2,:)) + size(im1,2) ;
y1 = f1(2,matches(1,:)) ;
y2 = f2(2,matches(2,:)) ;



M = zeros(2,2);
T = zeros(2,1);

for i = 1:N
    
    %pick P random matches
    picks = randi(size(x1), [1 P], 'single')
    
    A = [];
    b = [];
        
    for j = 1:P
        pick = picks(j);
        x_1 = x1(pick);
        y_1 = y1(pick);
        x_2 = x2(pick);
        y_2 = y2(pick);
        
        A = [A ; x_1 y_1 0 0 1 0 ; 0 0 x_1 y_1 0 1];
        b = [b ; x_2 ; y_2];          
    end
    
    x = pinv(A)*b
end

end