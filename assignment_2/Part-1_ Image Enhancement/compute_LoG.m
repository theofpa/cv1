function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        hsize = 5;
        sigma = 0.5;
        h = fspecial('gaussian', hsize, sigma);
        filtered_image = imfilter(image, h, 'conv');
        h2 = fspecial('laplacian');
        imOut = imfilter(filtered_image, h2, 'conv');
    case 2
        %method 2
        hsize = 5;
        sigma = 0.5;
        h = fspecial('log', hsize, sigma);
        imOut = imfilter(image, h, 'conv');
    case 3
        %method 3
        fprintf('Not implemented\n')

end

figure;
imshow(imOut);

end

