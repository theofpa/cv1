% Read images
orig = imread('image1.jpg')
salt = imread('image1_saltpepper.jpg')
gauss = imread('image1_gaussian.jpg')

% Box filtering of size 3x3, 5x5, 7x7
salt_box3 = denoise(salt, 'box', 3);
salt_box5 = denoise(salt, 'box', 5);
salt_box7 = denoise(salt, 'box', 7);

gauss_box3 = denoise(gauss, 'box', 3);
gauss_box5 = denoise(gauss, 'box', 5);
gauss_box7 = denoise(gauss, 'box', 7);

% Median filtering of size 3x3, 5x5, 7x7
salt_med3 = denoise(salt, 'median', 3);
salt_med5 = denoise(salt, 'median', 5);
salt_med7 = denoise(salt, 'median', 7);

gauss_med3 = denoise(gauss, 'median', 3);
gauss_med5 = denoise(gauss, 'median', 5);
gauss_med7 = denoise(gauss, 'median', 7);

% Calculate PSNR values
psnrvalues = zeros(4,3);

psnrvalues(1,1) = myPSNR(orig, salt_box3);
psnrvalues(1,2) = myPSNR(orig, salt_box5);
psnrvalues(1,3) = myPSNR(orig, salt_box7);

psnrvalues(2,1) = myPSNR(orig, salt_med3);
psnrvalues(2,2) = myPSNR(orig, salt_med5);
psnrvalues(2,3) = myPSNR(orig, salt_med7);

psnrvalues(3,1) = myPSNR(orig, gauss_box3);
psnrvalues(3,2) = myPSNR(orig, gauss_box5);
psnrvalues(3,3) = myPSNR(orig, gauss_box7);

psnrvalues(4,1) = myPSNR(orig, gauss_med3);
psnrvalues(4,2) = myPSNR(orig, gauss_med5);
psnrvalues(4,3) = myPSNR(orig, gauss_med7);

% PSNR of different sigma values
psnrsigma = zeros(3, 4);
psnrsigma(1, 1) = myPSNR(orig, denoise(gauss, 'gaussian', 1, 3));
psnrsigma(1, 2) = myPSNR(orig, denoise(gauss, 'gaussian', 2, 3));
psnrsigma(1, 3) = myPSNR(orig, denoise(gauss, 'gaussian', 3, 3));
psnrsigma(1, 4) = myPSNR(orig, denoise(gauss, 'gaussian', 10, 3));
psnrsigma(2, 1) = myPSNR(orig, denoise(gauss, 'gaussian', 1, 5));
psnrsigma(2, 2) = myPSNR(orig, denoise(gauss, 'gaussian', 2, 5));
psnrsigma(2, 3) = myPSNR(orig, denoise(gauss, 'gaussian', 3, 5));
psnrsigma(2, 4) = myPSNR(orig, denoise(gauss, 'gaussian', 10, 5));
psnrsigma(3, 1) = myPSNR(orig, denoise(gauss, 'gaussian', 1, 7));
psnrsigma(3, 2) = myPSNR(orig, denoise(gauss, 'gaussian', 2, 7));
psnrsigma(3, 3) = myPSNR(orig, denoise(gauss, 'gaussian', 3, 7));
psnrsigma(3, 4) = myPSNR(orig, denoise(gauss, 'gaussian', 10, 7));
