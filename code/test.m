I=imread('D:\image\test\49804.tif');       %��ȡ��ǰ·���µ�ͼƬ
figure(1);
imshow(I);
title('ԭʼͼ��')
% I1=im2bw(I);
I1=rgb2gray(I);
figure(2);
imshow(I1);
title('�Ҷ�ͼ��');
I1=medfilt2(I1);
I2=edge(I1,'canny',0.05);
figure(3);
imshow(I2);
title('canny���ӷָ���');