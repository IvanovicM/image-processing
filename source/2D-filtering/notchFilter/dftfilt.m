function g = dftfilt(f, H)

f = double(f);

% Calculate padding params
[M, N] = size(f);
P = 2*M - 1;
Q = 2*N - 1;

% Find DFT of input padded image
F = fft2(f, P, Q);

% Calculate FFT of filtered output
G = H.*F;

% Find IFFT of output and crop it to original dimensions
g = ifft2(G);
g = uint8(g(1:M, 1:N));

end