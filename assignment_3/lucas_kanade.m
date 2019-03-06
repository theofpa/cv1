function [max_cols, max_rows] = lucas_kanade(image1, image2)
%LUCAS_KANADE Summary of this function goes here
%   Detailed explanation goes here
i1 = imread(image1);
i2 = imread(image2);

img1 = im2double(rgb2gray(i1));
img2 = im2double(rgb2gray(i2));

size_x = size(img1,1);
size_y = size(img1,2);

ppr = 15;
max_cols = floor(size_x/ppr);
max_rows = floor(size_y/ppr);

regions1 = divide_img(img1, max_cols, max_rows);
regions2 = divide_img(img2, max_cols, max_rows);


A = calculate_A(regions1);
A{1};

A_t = calculate_A_t(A);
A_t{1};

b = calculate_b(regions1, regions2);
b{60};

v = calculate_v(A, A_t, b);
v{60};

draw_img(i1, v);
end

function draw_img(i1, v)
figure;
imshow(i1);
hold on;

for x = 1:length(v)
    v1 = v{x}(1:15, :);
    v2 = v{x}(16:30, :);
    
end
end

function [divided_img] = divide_img(img, cols, rows)
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

function [A] = calculate_A(regions)
A = {};
for x = 1:length(regions)
    [I_x, I_y] = gradient(regions{x});
    A{x} = [I_x,I_y];
end
end

function [A_t] = calculate_A_t(A)
A_t = {};
for x = 1:length(A)
    A_t{x} = A{x}';
end
end

function [b] = calculate_b(region1, region2)
b = {};
for x = 1:length(region1)
    b{x} = region1{x}-region2{x};
end
end

function [v] = calculate_v(A, A_t, b)
v = {};
for x = 1:length(A)
    r = A_t{x}*A{x};
    y = A_t{x}*b{x}; 
    v{x} = r\y; 
end
end