function [histograms] = encoding_histogram(images, clusters)
    histograms = zeros(size(images,1),size(clusters,2));
    stepPixels=4;
    sizePixels=5;
    descriptorGeometry=[4 4 8];
    for i = 1:size(images, 1)
        [~,descriptors]=vl_dsift(...
            rgb2gray(im2single(reshape(squeeze(images(i,:)),96,96,3))),...
            'step', stepPixels,...
            'geometry', descriptorGeometry,...
            'size', sizePixels);
        %[~,descriptors]=vl_dsift(rgb2gray(im2single(squeeze(images(i,:,:,:)))), 'step', stepPixels, 'geometry', descriptorGeometry);
        [~, k] = min(transpose(vl_alldist2(transpose(double(descriptors)), clusters)));
        imhist = histcounts(k, 1:size(clusters, 2)+1);
        imhist = imhist / size(descriptors, 1);
        histograms(i,:) = imhist;
        
    end
end