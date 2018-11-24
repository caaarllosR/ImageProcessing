clear
close
xdel(winsid()) // close all windows
clc

imOrigin = imread('images\finger.png');

[x,y] = size(imOrigin);

for i = 1:x
    for j = 1:y
    im(i,j) = imOrigin(i,j,1);
   end
end

im2 = [cat(2, double(zeros(x,2)), double(im), double(zeros(x,2)))]; //adds 2 zeros columns to the right and left
im2 = [cat(1, double(zeros(2, y+4)), double(im2), double(zeros(2, y+4)))]; //adds 2 lines of zeros to the right and left

im2 = double(im2);
im3 = im2;

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

mx = [-1 -2 -1; 0 0 0; 1 2 1]; //mask
my = [-1 0 1; -2 0 2; -1 0 1];

imx = im3;
imy = im3;

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

imMag = abs(imx)+abs(imy);
imMag = imMag(3:$-2, 3:$-2); 
bigger = max(max(imMag));

[x,y] = size(imMag);

for i = 1:x 
    for j = 1:y
         if(imMag(i,j)) > 0.20*bigger;
            imMag(i,j) = 0;
            else
            imMag(i,j) = 255;
        end
    end
end

imshow(uint8(imMag));
