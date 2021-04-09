
clear,clc;
 
% ¶ÁÈ¡Í¼Ïñ
Img = imread('D:\image\le50108.tif');
M = size(Img);
if numel(M)>2
    gray = rgb2gray(Img);
else
    gray = Img;
end

figure(1);
imshow(gray); title('Ô­Ê¼Í¼Ïñ');

% %- ¸øÆ½»¬Í¼Ïñ¼ÓÔë
% I0=imnoise(gray, 'gaussian' , 0, 0.02 );
% figure(2); imshow(uint8(I0));
% imshow(I0); title('ÔëÉùÍ¼Ïñ');

% ´´½¨ÂË²¨Æ÷
% W = fspecial('gaussian',[13,13],8);
 W = fspecial('average',[15,15]); 
G = imfilter(gray, W, 'replicate');
imwrite(G,"D:\image\le50108copy.tif")
figure(3);
imshow(G);    title('ÂË²¨ºóÍ¼Ïñ');
e=edge(gray,'Canny',0.08);
figure(4);
imshow(e);title('±ßÔµÍ¼Ïñ');