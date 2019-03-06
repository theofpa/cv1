function [v_all] = lucas_kanade_specific(img1, img2, x_vals, y_vals)

% Regions for given points
regions1 = divide_img(img1, x_vals, y_vals)
regions2 = divide_img(img2, x_vals, y_vals)

% Calculate all A
A_all = calculate_A(regions1);

% Calculate all b
b_all = calculate_b(regions1, regions2);

% Calculate all v
v_all = calculate_v(A_all, b_all);

end

function [divided_img] = divide_img(img, x_vals, y_vals)
    divided_img = {1, length(x_vals)};
    
    size_x = size(img, 1);
    size_y = size(img, 2);
    
    for i = 1:length(x_vals)
        x = x_vals(i);
        y = y_vals(i);
        
        x_min = max(x - 7, 1);
        x_max = min(x + 7, size_x);
        y_min = max(y - 7, 1);
        y_max = min(y + 7, size_y);
        
        divided_img{i} = img(x_min:x_max, y_min:y_max);
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
