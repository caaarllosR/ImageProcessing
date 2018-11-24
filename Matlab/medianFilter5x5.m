clear all
close all
clc 

im = imread('pics/pepper.png');
imOriginal = im;
imdisp(imOriginal);

for l = 1:3
    compIm = im(:,:,l);
    [x,y] = size(compIm);
    im2 = [zeros(x,4) compIm zeros(x,4)];
    im2 = [zeros(4, y+8); im2; zeros(4, y+8)];
    im2 = double(im2);
    im3 = im2;

    for i = 1:x+2 
        for j = 1:y+2
            m = [ im2(i, j)   im2(i, j+1)	im2(i, j+2)	  im2(i, j+3)	im2(i, j+4)  ...
                  im2(i+1, j) im2(i+1, j+1) im2(i+1, j+2) im2(i+1, j+3) im2(i+1, j+4)  ...
                  im2(i+2, j) im2(i+2, j+1) im2(i+2, j+2) im2(i+2, j+3) im2(i+2, j+4)  ...
                  im2(i+3, j) im2(i+3, j+1) im2(i+3, j+2) im2(i+3, j+3) im2(i+3, j+4)  ...
                  im2(i+4, j) im2(i+4, j+1) im2(i+4, j+2) im2(i+4, j+3) im2(i+4, j+4) ];

            m = sort(m);
            im3(i+2, j+2) = m(13);
        end
    end

    im3 = im3(5:end-4, 5:end-4);
    im(:,:,l) = im3;
end
figure;
imdisp(uint8(im));
