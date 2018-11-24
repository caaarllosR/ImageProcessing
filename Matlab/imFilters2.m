im = imread('pics/pout.tif');
im_neg = imread('pics/pout.tif');
im_eq = imread('pics/pout.tif');

figure
imdisp(im);

[x,y] = size(im);

% negative image

for i = 1:x 
    for j = 1:y
        im_neg(i,j) = -double(im_neg(i,j))+255;    
    end
end
figure
imdisp(im_neg);


% Equalization of the histogram

histo = zeros(1,256);
for i = 1:x 
    for j = 1:y
        histo(im(i,j)+1) = histo(im(i,j)+1)+1;    
    end
end
figure
plot(histo);

p = histo/(x*y);
s = zeros(1,256);
for k = 1:256 
    if k == 1
        s(k) = 255*p(k);
    else
        s(k) = s(k-1)+255*p(k);
    end
end
s = round(s);

figure
plot(s);


% equalized image

for i = 1:x 
    for j = 1:y
        im_eq(i,j) = s(im_eq(i,j)+1);    
    end
end

figure
imdisp(im_eq);


%histogram of the equalized image

histo = zeros(1,256);
for i = 1:x 
    for j = 1:y
        histo(im_eq(i,j)+1) = histo(im_eq(i,j)+1)+1;    
    end
end
figure
plot(histo);
