%%��ֵ�˲�
%��˹��������
clc;clear;
I=imread('D:\image\le50304.tif');
I=im2double(I);
I=rgb2gray(I);
figure(1);
imshow(I)
title('ԭͼ');
%��ֵ�˲�
I_3=fspecial('average',[13,13]);%3*3��ֵ�˲�    ����Ԥ������˲�����
I_3=imfilter(I,I_3);%(����������˲���)
figure(2)
imshow(I_3);title('3*3��ֵ�˲�');
e=edge(I_3,'Canny',0.1);
figure(3);
imshow(e);title('��Եͼ��');