%laplacian filter


clear all
close all

im = imread('pics/lua.tif');
imdisp(im);
[x,y] = size(im);
im2 = [zeros(x,2) im zeros(x,2)];
im2 = [zeros(2, y+4); im2; zeros(2, y+4)];
m = [1 1 1; 1 -8 1; 1 1 1]; %mask
im2 = double(im2);
im3 = im2;

for i = 1:x-1 
    for j = 1:y-1
        im3(i+1, j+1) = m(1,1)*im2(i,j)+ ...
                        m(2,1)*im2(i+1,j)+ ...
                        m(3,1)*im2(i+2,j)+ ...
                        m(1,2)*im2(i,j+1)+ ...
                        m(2,2)*im2(i+1,j+1)+ ...
                        m(3,2)*im2(i+2,j+1)+ ...
                        m(1,3)*im2(i,j+2)+ ...
                        m(2,3)*im2(i+1,j+2)+ ...
                        m(3,3)*im2(i+2,j+2);
    end
end

im3 = im3(3:end-2, 3:end-2);
imFiltrada = double(im) - im3;
figure;
imdisp(uint8(imFiltrada));