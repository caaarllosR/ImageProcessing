%image filters in the high-pass and low-pass frequencies domain


clear all
close all
clc

im = imread('pics/camera.tif');
[M,N] = size(im);

P = 2*M
Q = 2*N

im = [ im zeros(M,N) ];
im = [ im ; zeros(M,Q) ];
im = double(im);


% centralizes the frequency spectrum


for i = 1:P 
    for j = 1:Q
    im(i,j) = im(i,j)*(-1)^(i+j);
    end
end

% applies the Fourier transform in the image


F = fft2(im);

% prepares the proposed filter for the frequency domain

Z = zeros(P,Q);

for i = 1:P 
    for j = 1:Q
    Z(i,j) = sqrt((i- P/2)^2 + (j- Q/2)^2);
    end
end

% binary filter 

limiar = 50;

H = Z>limiar; %high-pass
H2 = Z<limiar; %low-pass

% apply the filter in the frequency domain

imHF = H.*F;
imHF2 = H2.*F;

% applies the inverse Fourier transform

iF = real(ifft2(imHF));
iF2 = real(ifft2(imHF2));

% decentralizes the resulting image spectrum

for i = 1:P 
    for j = 1:Q
    iF(i,j) = iF(i,j)*(-1)^(i+j);
    iF2(i,j) = iF2(i,j)*(-1)^(i+j);

    end
end   


iF = iF(1:P/2,1:Q/2);
iF2 = iF2(1:P/2,1:Q/2);

% shows the resulting high-pass spectrum

figure;
imdisp(uint8(20*log(abs(imHF))));

% end result of the high-pass

figure;
imdisp(uint8(iF))

% shows the resulting low-pass spectrum

figure;
imdisp(uint8(20*log(abs(imHF2))));

% end result of the low-pass
figure;
imdisp(uint8(iF2))





