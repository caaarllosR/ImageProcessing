clear
close
xdel(winsid()) // close all windows
clc

imOriginal = 'images\pout.tif'

 //Read and show image
    im = imread(imOriginal); 
    [x, y] = size(im); 
    imshow(im); 

// Histogram equalization

    //histogram of the original image

    hist_im = zeros(1, 256)
    for i=1:x
        for j=1:y
            hist_im( int16(im(i, j))+1 ) = hist_im( int16(im(i, j))+1 ) + 1;
        end
    end
    
    // histogram graph
    figure("BackgroundColor",[1,1,1])
    plot(hist_im);
    title("histogram of the original image");
    
    p = hist_im/(x*y);
    
    // equalization
    s = zeros(1, 256);
    for k=1:256
        if k == 1
            s(k) = 255*p(k)
        else
            s(k) = s(k-1) + 255*p(k)
        end
    end
    s = round(s)
    
    // Creating Equalized Image
    im_Equalized = im;
    
    for i=1:x
        for j=1:y
            im_Equalized(i,j) = s( im(i,j)+1 );
        end
    end
    
    testIm = [im im_Equalized]
    imshow(testIm); 
    
    // histogram of the equalized image
    hist_im_eq = zeros(1, 256)
    
    for i=1:x
        for j=1:y
            hist_im_eq( int16(im_Equalized(i, j))+1 ) = hist_im_eq( int16(im_Equalized(i, j))+1 ) + 1;
        end
    end
    
    // Gráfico do histogram da imagem equalizada
    figure("BackgroundColor",[1,1,1])
    plot(hist_im_eq);
    title("histogram of the equalized Image");
    
    // high-pass filter
//    imOriginal = 'lua.tif' 
//    im = imread(imOriginal);
//    [x,y] = size(im);
//    im2 = [cat(2, double(zeros(x,2)), double(im), double(zeros(x,2)))]; //adds 2 zeros columns to the right and left
//    im2 = [cat(1, double(zeros(2, y+4)), double(im2), double(zeros(2, y+4)))]; //adds 2 lines of zeros to the right and left
////    [l,m] = size(im2);
////    disp(l);
////    disp(m);
////    disp(im2);
//    printf('part 0\n');
//    m = [1 1 1; 1 -8 1; 1 1 1]; //mask
//    printf('part 1\n');
//    im2 = double(im2);
//    im3 = im2;
//    printf('part 2\n');
//    for i = 1:x-1 
//        for j = 1:y-1
//            im3(i+1, j+1) = m(1,1)*im2(i,j)+ ...
//                                    m(2,1)*im2(i+1,j)+ ...
//                                    m(3,1)*im2(i+2,j)+ ...
//                                    m(1,2)*im2(i,j+1)+ ...
//                                    m(2,2)*im2(i+1,j+1)+ ...
//                                    m(3,2)*im2(i+2,j+1)+ ...
//                                    m(1,3)*im2(i,j+2)+ ...
//                                    m(2,3)*im2(i+1,j+2)+ ...
//                                    m(3,3)*im2(i+2,j+2);
//        end
//    end
//    printf('part 3\n');
//    im3 = im3(3:$-2, 3:$-2); 
////    disp(im3)
////    [l,m] = size(im3);
////    disp(l);
////    disp(m);
//    imFiltered = double(im) - im3;
////    disp(imFiltered);
//    testIm = [im  uint8(imFiltered)]
//    imshow(testIm);
