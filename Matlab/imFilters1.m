clear all
close all
clc

im = imread('pics/pout.tif');

imdisp(im);

[x, y] = size(im);

biggerInt = -1;
smallerInt = 256;

% Searching for bigger and smaller intensity in the image and its coordinates
for i = 1:x 
    for j = 1:y
        if im(i,j) > biggerInt
            biggerInt = im(i,j);
            x_bigger = i;
            y_bigger = j;
        end
        if im(i,j) < smallerInt
            smallerInt = im(i,j);
            x_smaller = i;
            y_smaller = j;
        end
    end
end


% Histogram
imR = reshape(im, 1, x*y) % resized image matrix
figure
hist(double(imR), 40)

% Binarization
% the cut variable is a threshold of intensity

im_c1 = im;
corte = 50; 
for i=1:x
    for j=1:y
        if im_c1(i, j) > corte
            im_c1(i,j) = 255;
        else
            im_c1(i,j) = 0;
        end
    end
end



im_c2 = im;
corte = 120;
for i=1:x
    for j=1:y
        if im_c2(i, j) > corte
            im_c2(i,j) = 255;
        else
            im_c2(i,j) = 0;
        end
    end
end


im_c3 = im;
corte = 200;
for i=1:x
    for j=1:y
        if im_c3(i, j) > corte
            im_c3(i,j) = 255;
        else
            im_c3(i,j) = 0;
        end
    end
end


%	Reversing the image

im_inv = im;
ind_i_inv = x;
ind_j_inv = y;
for i=1:x
    for j=1:y
        im_inv(ind_i_inv, ind_j_inv) = im(i, j);
        ind_j_inv = ind_j_inv - 1;
    end
    ind_i_inv = ind_i_inv - 1;
    ind_j_inv = y;
end

%images applying each cut

figure
imdisp(im_c2);

figure
imdisp(im_c1);

figure
imdisp(im_c3);

%inverted image

figure
imdisp(im_inv);