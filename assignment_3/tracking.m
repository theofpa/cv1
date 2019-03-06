threshold = 0.169
rot_angle = 0

for i = 1:50
    image1_name = sprintf('%08d.jpg', i);
    image2_name = sprintf('%08d.jpg', i+1);
    orig_image1 = imread(image1_name);
    image1 = im2double(rgb2gray(orig_image1));
    image2 = im2double(rgb2gray(imread(image2_name)));
    
    if i == 1
        [H, r, c] = harris_corner_detector(image1_name, threshold, rot_angle, 0);
    end
    
    
    v_all = lucas_kanade_specific(image1, image2, c, r);
    figure
    close
    imshow(orig_image1);
    hold on;

    plot(c, r, 'r+','MarkerSize',6);
    
    i = 1;
    for k = length(c)
        x = c(k);
        for l = length(r)
            y = r(l);
            v = v_all{i}
            v_x = v(1);
            v_y = v(2);
            r(l) = r(l) + 1;
            c(k) = c(k) + 1;
            i=i+1;
        end
    end
    pause(0.0167) % approximate 60fps
end