function [ imOut ] = denoise( image, kernel_type, varargin)
switch kernel_type
    case 'box'
        if size(varargin) == [1, 1]
            [kernelSize] = varargin{:};
            imOut = imboxfilt(image, kernelSize);
        else
            imOut = imboxfilt(image);
        end
    case 'median'
        if size(varargin) == [1, 1]
            [kernelSize] = varargin{:};
            imOut = medfilt2(image, [kernelSize, kernelSize]);
        else
            imOut = medfilt2(image);
        end
    case 'gaussian'
        [sigma, kernelSize] = varargin{:};
        imOut = imfilter(image ,gauss2D(sigma, kernelSize));
end
end
