clear all
close all
clc 

im = imread('pics/pepper.png');
imOriginal = im;
imdisp(imOriginal);

for l = 1:3
    compIm = im(:,:,l);
    [x,y] = size(compIm);
    im2 = [zeros(x,2) compIm zeros(x,2)];
    im2 = [zeros(2, y+4); im2; zeros(2, y+4)];
    im2 = double(im2);
    im3 = im2;

    for i = 1:x+1 
        for j = 1:y+1
            m = [ im2(i, j)   im2(i, j+1)	im2(i, j+2)	  ...
                  im2(i+1, j) im2(i+1, j+1) im2(i+1, j+2) ...
                  im2(i+2, j) im2(i+2, j+1) im2(i+2, j+2) ...
                  im2(i+3, j) im2(i+3, j+1) im2(i+3, j+2) ];


            m = sort(m);
            im3(i+1, j+1) = m(5);
        end
    end

    im3 = im3(3:end-2, 3:end-2);
    im(:,:,l) = im3;
end
figure;
imdisp(uint8(im));
