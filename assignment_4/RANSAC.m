function [best_N, best_inlier_count, best_x] = RANSAC(im1, im2, N, P)

%%Implementing David Lowe's SIFT functions to extract and match

threshold = 30; % Threshold for ubcmatch algorithm. higher is less keypoints. 

%Find Matches
[f1, d1] = vl_sift(im1) ;
[f2, d2] = vl_sift(im2) ;
[matches, scores] = vl_ubcmatch(d1, d2, threshold) ; %Index of matches and distance between scores


%Determine coordinate vectors
x1 = f1(1,matches(1,:)) ;
x2 = f2(1,matches(2,:)) ;
y1 = f1(2,matches(1,:)) ;
y2 = f2(2,matches(2,:)) ;



best_x = zeros(6,1);
best_inlier_count = 0;
best_N = 1;

for i = 1:N    
    %pick P random matches
    picks = randi(size(x1), [1 P], 'single');
    
    A = [];
    b = [];
     
    %add samples to A and b
    for j = 1:P
        pick = picks(j);
        x_1 = x1(pick);
        y_1 = y1(pick);
        x_2 = x2(pick);
        y_2 = y2(pick);
        
        A = [A ; x_1 y_1 0 0 1 0 ; 0 0 x_1 y_1 0 1];
        b = [b ; x_2 ; y_2];          
    end
    
    %calculate pseduo-inverse
    x = pinv(A)*b;
        
    inlier_count = 0;
    
    for k = 1:size(matches(2))
        x_1 = x1(k);
        x_2 = x2(k);
        y_1 = y1(k);
        y_2 = y2(k);
        
        %Transform keypoints of image 1 
        transformed = [x_1,y_1,0,0,1,0 ; 0,0,x_1,y_1,0,1] * x;
        new_x_1 = round(transformed(1));
        new_y_1 = round(transformed(2));

        %distance between transformed and x_2
        pixel = [x_2, y_2; new_x_1, new_y_1];
        d = pdist(pixel, 'euclidean');
        
        if d <= 10
            inlier_count = inlier_count + 1;
        end
    end
    
    if inlier_count > best_inlier_count
        best_x = x;
        best_inlier_count = inlier_count;
        best_N = i;
    end 
     
end

end