I=imread('D:\image\test\49804.tif');       %读取当前路径下的图片
figure(1);
imshow(I);
title('原始图像')
% I1=im2bw(I);
I1=rgb2gray(I);
figure(2);
imshow(I1);
title('灰度图像');
I1=medfilt2(I1);
I2=edge(I1,'canny',0.05);
figure(3);
imshow(I2);
title('canny算子分割结果');