clear
close
xdel(winsid()) // close all windows
clc

//    High-Pass
    imOriginal = 'images\lua.tif' 
    im = imread(imOriginal);
    [x,y] = size(im);
    im2 = [cat(2, double(zeros(x,2)), double(im), double(zeros(x,2)))]; //adds 2 zeros columns to the right and left
    im2 = [cat(1, double(zeros(2, y+4)), double(im2), double(zeros(2, y+4)))]; //adds 2 lines of zeros to the right and left
    
    printf('parte 0\n');
    m = [1 1 1; 1 -8 1; 1 1 1]; //mascara
    printf('parte 1\n');
    im2 = double(im2);
    im3 = im2;
    printf('parte 2\n');
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
    printf('parte \n');
    im3 = im3(3:$-2, 3:$-2); 
    
    imFiltered = double(im) - im3;

    [x,y] = size(imFiltered);
    
    for i = 1:x
        for j = 1:y
           if imFiltered(i, j) < 0 then
                imFiltered(i,j) = 0;
           end
           if imFiltered(i, j) >255 then
                imFiltered(i,j) = 255;
           end
        end
    end
     
    //imFiltered = double(im) - im3;
    //imResult = uint8(imFiltered);
    imResult = (uint8(imFiltered));
    imshow(imResult);
