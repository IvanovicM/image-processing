function [image, betterImage] = makeGirlHtBetter()
    image = im2double(imread('../../sekvence/girl_ht.tif'));
    dir = '../images/girl/';
    
    filtered = filterNFAndNotch(image, dir);
    averaged = average(filtered);
    sharped = sharp(averaged);
    
    betterImage = sharped;
end

function J = filterNFAndNotch(I, dir)
    % Prosirivanje slike
    [M, N] = size(I);
    P = 2*M - 1; Q = 2*N - 1;
    
    % Furije ulazne slike
    F = fftshift(fft2(I, P, Q));
    f = figure('Name', '|F| [dB]');
    imshow(log(1 + abs(F)), []);
    saveFigure(f, dir, 'F_original.jpg'); close(f);
    
    % =====================================================================
    % Specifikacija NF filtra
    HNf = fftshift(lpfilter('gaussian', P, Q, 200));
    f = figure('Name', '|HNf| [dB]');
    imshow(log(1 + abs(HNf)), []);
    saveFigure(f, dir, 'H_NF.jpg'); close(f);
    
    % NF filtriranje
    GNf = F .* HNf;
    f = figure('Name', '|GNf| [dB]');
    imshow(log(1 + abs(GNf)), []);
    saveFigure(f, dir, 'F_NF.jpg'); close(f);
    
    % Inverzna transformacija NF filtrirane slike
    gnf_p = ifft2(ifftshift(GNf));
    gnf = gnf_p(1:M, 1:N);
    saveImage(gnf, dir, 'I_NF.jpg');
    
    % =====================================================================
    % Specifikacija notch filtra
    C = [0 300; P 300; 0 600; P 600;
         150 0; 150 Q; 150 300; 150 600;
         300 0; 300 Q; 300 300; 300 600;
         450 0; 450 Q; 450 300; 450 600;
         600 0; 600 Q; 600 300; 600 600;
         (P - 150) 300; (P - 150) 600;
         (P - 300) 300; (P - 300) 600;
         (P - 450) 300; (P - 450) 600;
         (P - 600) 300; (P - 600) 600
    ];
    HNotch = cnotch('gaussian', 'reject', P, Q, C, 40);
    f = figure('Name', '|HNotch| [dB]');
    imshow(log(1 + abs(HNotch)), []);
    saveFigure(f, dir, 'H_notch.jpg'); close(f);
    
    % FIltriranje notchom
    G = GNf .* HNotch;
    f = figure('Name', '|G| [dB]');
    imshow(log(1 + abs(G)), []);
    saveFigure(f, dir, 'F_notch.jpg'); close(f);
    
    % Inverzna transformacija notch filtrirane slike
    gp = ifft2(ifftshift(G));
    J = gp(1:M, 1:N);
end

function J = average(I)
    w = ones(15, 15);
    w = w./sum(w(:));
    J = imfilter(I, w, 'replicate');
end

function J = sharp(I)
    w_lp = fspecial('average', 15);
    I_lp = imfilter(I, w_lp, 'replicate');
    I_hp = I - I_lp;
    J = I + I_hp;
end