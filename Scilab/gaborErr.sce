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
         imSort = [ im2(i, j)   im2(i, j+1)   im2(i, j+2) ...
                    im2(i+1, j) im2(i+1, j+1) im2(i+1, j+2) ...
                    im2(i+2, j) im2(i+2, j+1) im2(i+2, j+2) ...
                    im2(i+3, j) im2(i+3, j+1) im2(i+3, j+2) ];
                       
        imSort = gsort(imSort);
        im3(i+1, j+1) = imSort(5);
    end
end

im3 = im3(3:$-2, 3:$-2)
I = im3;



// Gabor
theta = %pi;
sigmax = 5;
sigmay = 5;
f = 1;

//[x,y] = size(im3);
filterSize = 3;
G = zeros(filterSize);

    for i=(0:filterSize-1)/filterSize
        for j=(0:filterSize-1)/filterSize

            xprime=  i*cos(theta) + j*sin(theta);
            yprime = j*cos(theta) - i*sin(theta);         
//            K = cos(2*%pi*f*i); //smoothing term K that controls how much smoothing is applied to the Gabor magnitude responses
//            K = 2*%pi*sqrt(-1)*f*yprime;
            K = 2*%pi*sqrt(-1)*f*xprime;
            G(round((i+1)*filterSize),round((j+1)*filterSize)) = exp(K-(((xprime^2)/(2*sigmax^2))+((yprime^2)/(2*sigmay^2))))
            
        end
    end
    
J = conv2(double(I),double(G), "full");


m=size(I,1);
n=size(I,2);

J = J(3:$-($-m), 3:$-($-n));

J = real(J)

bigger = max(J);
smaller = min(J);

[x,y] = size(J);


for i = 1:x 
    for j = 1:y
         J(i,j) = (J(i,j)-smaller)/(bigger-smaller)
         J(i,j) = J(i,j) * 255.0
//         if(J(i,j)) > 0.65*255;
//            J(i,j) = 255;
//         else
//            J(i,j) = 0;
//         end
    end
end

J = uint8(J);

imshow(J);
