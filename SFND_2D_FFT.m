% 1. Take a 2D signal matrix

% 2. In the case of Radar signal processing. Convert the signal in MxN matrix, 
% where M is the size of Range FFT samples and N is the size of Doppler FFT samples:

% signal  = reshape(signal, [M, N]);

% 3. Run the 2D FFT across both the dimensions.
% Y = fft2(X) returns the 2D FFT of a matrix using a fast Fourier transform algorithm, 
% which is equivalent to computing fft(fft(X).').'. 
% If X is a multidimensional array, 
% then fft2 takes the 2-D transform of each dimension higher than 2. 
% The output Y is the same size as X. 
% Y = fft2(X,M,N) truncates X or pads X with trailing zeros to form an m-by-n matrix 
% before computing the transform. Y is m-by-n. 
% If X is a multidimensional array, 
% then fft2 shapes the first two dimensions of X according to m and n.

% signal_fft = fft2(signal, M, N);

% 4. Shift zero-frequency terms to the center of the array

% signal_fft = fftshift(signal_fft);

% 5. Take the absolute value

% signal_fft = abs(signal_fft);

% 6. Here since it is a 2D output, it can be plotted as an image. Hence, we use the imagesc function
% imagesc(signal_fft);

% In the following exercise, 
% you will practice the 2D FFT in MATLAB using some generated data. 
% The data generated below will have the correct shape already, 
% so you should just need to use steps 3-6 from above. You can use the following starter code:

% 2-D Transform
% The 2-D Fourier transform is useful for processing 2-D signals and other 2-D data such as images.
% Create and plot 2-D data with repeated blocks.

P = peaks(20);
X = repmat(P,[5 10]);
imagesc(X)

% TODO : Compute the 2-D Fourier transform of the data.  
% Shift the zero-frequency component to the center of the output, and 
% plot the resulting 100-by-200 matrix, which is the same size as X.
Y = fft2(X);
signal_fft = fftshift(Y);
signal_fft = abs(signal_fft);
% signal_fft = fft2(Y,2^nextpow2(100),2^nextpow2(200));

imagesc(signal_fft);

