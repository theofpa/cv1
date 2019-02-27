function G = gauss2D( sigma , kernel_size )
    %% solution
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    G_x = gauss1D(sigma, kernel_size);
    G_y = gauss1D(sigma, kernel_size);
    for xdim=1:kernel_size
        for ydim=1:kernel_size
            G(xdim, ydim) = G_x(xdim) * G_y(ydim);
        end
    end
    G = G ./ sum(G, 'all');
end