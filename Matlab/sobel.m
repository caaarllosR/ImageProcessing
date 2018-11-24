clear all
close all
clc 

im = imread('pics/lua.tif');
imOriginal = im;
imdisp(imOriginal);

[x,y] = size(im);
im2 = [zeros(x,2) im zeros(x,2)];
im2 = [zeros(2, y+4); im2; zeros(2, y+4)];
im2 = double(im2);
im3 = im2;

% median filter

for i = 1:x+1 
    for j = 1:y+1
    
     im3(i+1, j+1) = (im2(i,j)+ ...
                     im2(i+1,j)+ ...
                     im2(i+2,j)+ ...
                     im2(i,j+1)+ ...
                     im2(i+1,j+1)+ ...
                     im2(i+2,j+1)+ ...
                     im2(i,j+2)+ ...
                     im2(i+1,j+2)+ ...
                     im2(i+2,j+2))/9;
    end
end

%mask horizontal and vertical gradient
mx = [-1 -2 -1; 0 0 0; 1 2 1]; 
my = [-1 0 1; -2 0 2; -1 0 1];

imx = im3;
imy = im3;

%applying the mask

for i=1:x+1
	for j=1:y+1
		imx(i+1, j+1) = im3(i, j)	 *mx(1, 1) + ...
						im3(i, j+1)	 *mx(1, 2) + ...
						im3(i, j+2)	 *mx(1, 3) + ...
						im3(i+1, j)	 *mx(2, 1) + ...
						im3(i+1, j+1)*mx(2, 2) + ...
						im3(i+1, j+2)*mx(2, 3) + ...
						im3(i+2, j)	 *mx(3, 1) + ...
						im3(i+2, j+1)*mx(3, 2) + ...
						im3(i+2, j+2)*mx(3, 3);
		
		imy(i+1, j+1) = im3(i, j)	 *my(1, 1) + ...
						im3(i, j+1)	 *my(1, 2) + ...
						im3(i, j+2)  *my(1, 3) + ...
						im3(i+1, j)	 *my(2, 1) + ...
						im3(i+1, j+1)*my(2, 2) + ...
						im3(i+1, j+2)*my(2, 3) + ...
						im3(i+2, j)	 *my(3, 1) + ...
						im3(i+2, j+1)*my(3, 2) + ...
						im3(i+2, j+2)*my(3, 3);
    end
end

%applying threshold on the resulting gradient image to highlight the leading edges

imMag = abs(imx)+abs(imy);
bigger = max(max(imMag));

for i = 1:x 
    for j = 1:y
        if(imMag(i,j)) > .33*bigger;
            imMag(i,j) = 255;
        else
            imMag(i,j) = 0;
        end
    end
end

imMag = imMag(3:end-2, 3:end-2);

figure;
imdisp(uint8(imMag));
