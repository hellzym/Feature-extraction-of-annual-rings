%%均值滤波
%高斯噪声部分
clc;clear;
I=imread('D:\image\le50304.tif');
I=im2double(I);
I=rgb2gray(I);
figure(1);
imshow(I)
title('原图');
%均值滤波
I_3=fspecial('average',[13,13]);%3*3均值滤波    建立预定义的滤波算子
I_3=imfilter(I,I_3);%(待处理矩阵，滤波器)
figure(2)
imshow(I_3);title('3*3均值滤波');
e=edge(I_3,'Canny',0.1);
figure(3);
imshow(e);title('边缘图像');