function [max_cols, max_rows] = lucas_kanade(orig_img1, img1, img2, scale)
% Input: original imread image, two double grey images and the scale
% since some images get a tiny vectors
% Output: max columns, max rows and the figure with the vectors

% Get image sizes
size_x = size(img1,1);
size_y = size(img1,2);

% Window, column en row sizes
ppr = 15;
max_cols = floor(size_x/ppr);
max_rows = floor(size_y/ppr);

% Divide image into regions
regions1 = divide_img(img1, max_cols, max_rows);
regions2 = divide_img(img2, max_cols, max_rows);

% Calculate all A
A_all = calculate_A(regions1);

% Calculate all b
b_all = calculate_b(regions1, regions2);

% Calculate all v
v_all = calculate_v(A_all, b_all);

% Draw image with the quivers
draw_img(orig_img1, v_all, scale, ppr);
end

function [divided_img] = divide_img(img, cols, rows)
% Divide image into different regions given the row and column count
% The output is a (1, row*column) sized cell with each containing
% a 15x15 matrix
    divided_img = {1,cols*rows};
    i=1;
    for row = 1:rows
        for col = 1:cols
            r2 = row*15;
            r1 = r2 - 14;
            c2 = col*15;
            c1 = c2 - 14;
            divided_img{i} = img(c1:c2, r1:r2);
            i=i+1;
        end
    end
end

function [A_all] = calculate_A(regions)
% Calculate for the different regions all A matrices; the x and y partial
% derivatives
    A_all = {};
    for x = 1:length(regions)
        [I_x, I_y] = gradient(regions{x});
        [col, row] = size(I_x);
        I_x = reshape(I_x, [col*row, 1]);
        I_y = reshape(I_y, [col*row, 1]); % Should be same size
        A_all{x} = [I_x(:), I_y(:)];
    end
end

function [b_all] = calculate_b(region1, region2)
% Calculate for the different regions all b vectors; the t partial
% derivatives
    b_all = {};
    for x = 1:length(region1)
        I_t = region2{x}-region1{x};
        [col, row] = size(I_t);
        I_t = reshape(I_t, [col*row, 1]);
        b_all{x} = -I_t;
    end
end

function [v_all] = calculate_v(A, b)
% Calculate for the different regions all v vectors; v_x and v_y
    v_all = {};
    for x = 1:length(A)
        r = A{x}.'*A{x};
        y = A{x}.'*b{x}; 
        v_all{x} = r\y; 
    end
end

function draw_img(i1, v_all, scale, ppr)
% Draw image and add the vectors of v for every region starting
% from the minimal x and y value in the region
    figure;
    imshow(i1);
    hold on;
    
    v_size = sqrt(length(v_all));
    v_all = reshape(v_all, [v_size, v_size]);
    for row = 1:v_size
        for col = 1:v_size
            % Quiver start at roughly middle of region
            x = col*15-floor(ppr/2);
            y = row*15-floor(ppr/2);
            
            v = v_all{row, col};
            v_x = v(1);
            v_y = v(2);
            q = quiver(x, y, v_x, v_y);
            q.AutoScaleFactor = scale; % Quivers were too small
            q.Color = 'red';
            q.ShowArrowHead = 'on'; 
            q.MaxHeadSize = 1.5;
        end
    end
end
