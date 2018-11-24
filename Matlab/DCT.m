close all
clear all
clc


%due to this being a very costly 
%operation computationally it was 
%only applied in a small piece of the image

im = imread('pics/camera.tif');
im = im(101:200, 101:200);
figure;
imshow(im);

im = double(im);

[M, N] = size(im);

imCompact = zeros(M, N);

% applying the direct cosine transform for image compression(DCT)
for p=0:M-1
    if p == 0
        ap = 1/sqrt(M);
    else
        ap = sqrt(2/M);
    end
    for q=0:N-1
        if q==0
            aq = 1/sqrt(N);
        else
            aq = sqrt(2/N);
        end
        for m=0:M-1
            for n=0:N-1
                imCompact(p+1, q+1) = imCompact(p+1, q+1) + im(m+1, n+1)*cos((pi*(2*m+1)*p)/(2*M))*cos((pi*(2*n+1)*q)/(2*N));
            end
        end
        imCompact(p+1, q+1) = ap*aq*imCompact(p+1, q+1);
    end
end


% isolating 30% of the components of greater magnitude

im30 = imCompact(1:(M*0.3), 1:(N*0.3)); % doing compression with 30% = 0.3
[M, N] = size(im30);

% showing 30% of the highest magnitude components
figure;
imshow(uint8(im30));


im30Zeros = zeros(M, N);
for i=1:M
    for j=1:N
        im30Zeros(i, j) = im30(i, j);
    end
end

imFinal = double(zeros(M, N));

% Recovering the Compressed Image with Reverse DCT (IDCT)
for m=0:M-1
    for n=0:N-1
        for p=0:M-1
            if p == 0
                ap = 1/sqrt(M);
            else
                ap = sqrt(2/M);
            end
            for q=0:N-1
                if q == 0
                    aq = 1/sqrt(N);
                else
                    aq = sqrt(2/N);
                end
                imFinal(m+1, n+1) = imFinal(m+1, n+1) + ap*aq*im30Zeros(p+1, q+1)*cos((pi*(2*m+1)*p)/(2*M))*cos((pi*(2*n+1)*q)/(2*N));
            end
        end
    end
end

% Picture after the decompression
figure;
imshow(uint8(imFinal));
