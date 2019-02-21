function [ PSNR ] = myPSNR( orig_image, approx_image )
%fprintf('Not implemented\n')
    [m, n] = size(orig_image);
    I_max = max(orig_image, [], 'all');
    RMSE = sqrt(1/(m*n) * sum((orig_image - approx_image).^2, 'all'));
    PSNR = 20 * log10(I_max/RMSE)
end

