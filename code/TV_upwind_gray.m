%% 用全变分方法恢复一幅退化图像（有噪声且模糊），
%% 所用的数学工具是基于Roe的迎风方案
 
clear all;
close all;
clc;

% Img = imread('lenna.bmp');
% Img = double(Img);
% figure(1); imshow(uint8(Img));
% [nrow, ncol] = size(Img);
I = imread('E:/zhitian/1/1.jpg');
figure(1)
imshow(I);title('原始图像');
I = rgb2hsv(I);
I = I(:,:,3);
[m,n]=size(I);
% I = rgb2gray(I);
figure(2)
imshow(I);title('灰度图像');

I = im2double(I); 
% %%- 平滑图像
I = gauss(I,1,1);

%%- 给平滑图像加噪
% I0=I+0.2*randn([m, n]);
% figure(3); imshow(uint8(I0));
% imshow(I0);


lamda=0.3;       
timestep=0.04;    % 设置步长

I_temp=I;        % 初始化
[nrow, ncol] = size(I);
%%- 迭代开始
tic; %tic用来保存当前时间
for n=1:250
   
       Ix = 0.5*(I_temp(:,[2:ncol,ncol])-I_temp(:,[1,1:ncol-1]));
       Iy = 0.5*(I_temp([2:nrow,nrow],:)-I_temp([1,1:nrow-1],:));
       Ix_back = I_temp-I_temp(:,[1,1:ncol-1]);
       Ix_forw = I_temp(:,[2:ncol,ncol])-I_temp;
       Iy_back = I_temp-I_temp([1,1:nrow-1],:);
       Iy_forw = I_temp([2:nrow,nrow],:)-I_temp;
       grad = Ix.^2+Iy.^2+eps;
       
       Ixx = I_temp(:,[2:ncol,ncol])+I_temp(:,[1,1:ncol-1])-2*I_temp;
       Iyy = I_temp([2:nrow,nrow],:)+I_temp([1,1:nrow-1],:)-2*I_temp;
       Ixy = 0.25*(I_temp([2:nrow,nrow],[2:ncol,ncol])+I_temp([1,1:nrow-1],[1,1:ncol-1])-...
           I_temp([2:nrow,nrow],[1,1:ncol-1])-I_temp([1,1:nrow-1],[2:ncol,ncol]));
       term1 = (Ixx.*Iy.^2-2*Ix.*Iy.*Ixy+Iyy.*Ix.^2)./grad;
       
       D=gauss(I_temp,7,3)-I;
       DD = gauss(D,7,3);
       upwind_x=Ix_back;
       upwind_x(Ix.*DD<0)=Ix_forw(Ix.*DD<0);
       upwind_y=Iy_back;
       upwind_y(Iy.*DD<0)=Iy_forw(Iy.*DD<0);
       term2 = lamda*sqrt(upwind_x.^2+upwind_y.^2).*DD;
       I_t = term1-term2;

       I_temp=I_temp+timestep*I_t;
end
toc;
figure(4);
imshow(uint8(I_temp));
imshow(I_temp);title('去噪后图像');
W5=edge(I_temp,'Canny',0.05);
figure(5);
imshow(W5);title('提取边缘');
kx1=859;
ky1=545;
kx2=439;
ky2=222;
kk = (ky1-ky2)./(kx1-kx2);
num =1;
for kx=439:1:859
    ky=ceil(kk*(kx-kx2)+ky2);
    if W5(kx,ky)==1
        num = num+1
        sx(num)=kx;
        sy(num)=ky;
    end
end
ringnum=floor(num./2)
distance=sqrt((ky1-ky2).^2+(kx1-kx2).^2)
average=distance./ringnum
sx15=sx(30);
sy15=sy(30);
dis_in_15=sqrt((sx15-kx2).^2+(sy15-ky2).^2)
dis_in_15av=dis_in_15./15
sx38=sx(38);
sy38=sy(38);
dis_out_15=sqrt((sx38-kx1).^2+(sy38-ky1).^2)
dis_out_15av=dis_out_15./15
for number=1:2:num-1
    dis_av(number)=sqrt((sx(number+1)-sx(number)).^2+(sy(number+1)-sy(number)).^2);
end
