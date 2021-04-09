%%%%%%%%% EXAMPLE #3:
%daima fei great
%  rawimg = imread('TestImg_CHT_c3.bmp');
 tic; %tic用来保存当前时间
rawimg = imread('E:/zhitian/1/1.jpg');
%[10 150], 1,50, 0.45
%rawimg = imread('I:\feature_extraction\background\50308.tif');
%[10 170], 5,50, 0.4
%  rawimg = imread('G:\feature_extraction\background\50312.tif');
%  [10 170], 3,50, 0.4);
% rawimg = imread('G:\feature_extraction\background\50004.tif');
% [10 200], 3,50, 0.4
% rawimg = imread('G:\feature_extraction\background\50008.tif');%tong shang
% rawimg = imread('G:\feature_extraction\background\50012.tif');
% [10 100], 2,45, 0.4)
% rawimg = imread('G:\feature_extraction\background\50216.tif');
%[20 150], 2,120, 0.4
% rawimg = imread('I:\feature_extraction\background\B46804.tif');
%[90 150], 6,130, 0.6)
 rawimg=rgb2gray(rawimg); %将图像转换成灰度图像
  fltr4img = [1 1 1 1 1; 1 2 2 2 1; 1 2 4 2 1; 1 2 2 2 1; 1 1 1 1 1];
 fltr4img = fltr4img / sum(fltr4img(:));
  imgfltrd = filter2( fltr4img , rawimg ); %高斯滤波
 
  [accum, circen, cirrad] = ...
      CircularHough_Grd(imgfltrd, [10 170], 5,50, 0.4);%...代表换行的意思
toc;%tc用来记录程序完成时间
  figure(1); imagesc(accum); axis image;%第一幅图
  figure(2); imagesc(rawimg); colormap('gray'); axis image;
  hold on;%图形保持，可以多次作图，
  plot(circen(:,1), circen(:,2), 'r+');
  for k = 1 : size(circen, 1)
      DrawCircle(circen(k,1), circen(k,2), cirrad(k), 32, 'b-');
  end
  hold off;
  title(['Raw Image with Circles Detected ', ...
      '(center positions and radii marked)']);
  x0=circen(6,1);
  y0=circen(6,2);
  
  x0=966;
  y0=718;
  
 I=imread('D:\image\bezier\49804_c.tif');
 [m,n,p]=size(I);
 I=im2bw(I);%函数im2bw使用阈值变换法把灰度图像转换成二值图像
 se=strel('square',3); %创建一个3阶的正方形矩阵
 Ia=imerode(I,se);%图像腐蚀
 Iout=I-Ia;%形态学梯度，提取图像的轮廓
 figure(6);
 imshow(Iout);
 title("形态学梯度图像");
 Iout1=Iout;
 N=1;
 for i=1:m
     for j=1:n
         if Iout(i,j)==1
             p(N,1)=i;
             p(N,2)=j;
             N=N+1;
             Iout(i,j+5:end)=0;
         end
        
     end
 end
 figure(7);
 imshow(Iout);
 title("左边界");
 outright=Iout;
 [ny,nx]=size(outright);
 numi=0;
for iy=1:ny
    for ix=1:nx
    if outright(iy,ix)==1
        numi= numi+1;
        outrx(numi)=ix;
        outry(numi)=iy;
    end
    end
end
 for i=1:m
     for j=n:(-1):1
         if Iout1(i,j)==1
             p(N,1)=i;
             p(N,2)=j;
             N=N+1;
             Iout1(i,1:j-5)=0;
         end
     end
 end
 figure(8);
 imshow(Iout1);
 title("右边界");
 outleft=Iout1;
 x=p(:,1);
 y=p(:,2);
 [R,x00,y00]=circ(x,y,N-1);
 disp(['banjing: ' num2str(R),' mm' ]);
 disp(['zuobiaodian:( ' num2str(x0) ,',',num2str(y0),')']);
 figure(9)
 imshow(I);
  title("边界图像")
 hold on
 plot(x00,y00,'r+');
%  view=pi./4;
% k=tan(view);
% [x,y]=solve('(x-222)^2+(y-333)^2=666','y=x','x','y') 
 

% %calculate other data 
% I = imread('D:\image\bezier\49804_c.tif');
% I = rgb2hsv(I);
% I = I(:,:,3);
% % I = rgb2gray(I);
% 
% I = im2double(I); 
% imshow(I);
% % %%- 平滑图像
% I = gauss(I,1,1);
% 
% %%- 给平滑图像加噪
% % I0=Img+10*randn([nrow, ncol]);
% % figure(2); imshow(uint8(I0));
% imshow(I);
% 
% lamda=0.3;       
% timestep=0.01;    % 设置步长
% 
% I_temp=I;        % 初始化
% [nrow, ncol] = size(I);
% %%- 迭代开始
% for n=1:200
%    
%        Ix = 0.5*(I_temp(:,[2:ncol,ncol])-I_temp(:,[1,1:ncol-1]));
%        Iy = 0.5*(I_temp([2:nrow,nrow],:)-I_temp([1,1:nrow-1],:));
%        Ix_back = I_temp-I_temp(:,[1,1:ncol-1]);
%        Ix_forw = I_temp(:,[2:ncol,ncol])-I_temp;
%        Iy_back = I_temp-I_temp([1,1:nrow-1],:);
%        Iy_forw = I_temp([2:nrow,nrow],:)-I_temp;
%        grad = Ix.^2+Iy.^2+eps;
%        
%        Ixx = I_temp(:,[2:ncol,ncol])+I_temp(:,[1,1:ncol-1])-2*I_temp;
%        Iyy = I_temp([2:nrow,nrow],:)+I_temp([1,1:nrow-1],:)-2*I_temp;
%        Ixy = 0.25*(I_temp([2:nrow,nrow],[2:ncol,ncol])+I_temp([1,1:nrow-1],[1,1:ncol-1])-...
%            I_temp([2:nrow,nrow],[1,1:ncol-1])-I_temp([1,1:nrow-1],[2:ncol,ncol]));
%        term1 = (Ixx.*Iy.^2-2*Ix.*Iy.*Ixy+Iyy.*Ix.^2)./grad;
%        
%        D=gauss(I_temp,7,3)-I;
%        DD = gauss(D,7,3);
%        upwind_x=Ix_back;
%        upwind_x(Ix.*DD<0)=Ix_forw(Ix.*DD<0);
%        upwind_y=Iy_back;
%        upwind_y(Iy.*DD<0)=Iy_forw(Iy.*DD<0);
%        term2 = lamda*sqrt(upwind_x.^2+upwind_y.^2).*DD;
%        I_t = term1-term2;
% 
%        I_temp=I_temp+timestep*I_t;
% end
% % imshow(uint8(I_temp));
% % imshow(I_temp);
% W5=edge(I_temp,'canny',0.1);
% figure(10)
% imshow(W5);
% title('canny边缘图像');
% % view=pi./4;
% % k=tan(view);
% % [x,y]=solve('(x-x0).^2+(y-y0).^2=R.^2','y=kx','x','y')
% % qiuyubianyuanjiaodian
% 
% kx1=x0;%中心的横坐标
% ky1=y0;%中心的纵坐标
% [~,outxnum]=size(outrx);
% outynum=outxnum;
% 
% for numx=1:outxnum
%     kx2(numx)=outrx(numx);
%     ky2(numx)=outry(numx);
%     kk(numx) = (ky1-ky2(numx))./(kx1-kx2(numx));
%     num =0;
%     for kx=kx2(numx):1:kx1
%         ky=ceil(kk(numx)*(kx-kx1)+ky1);
%         if ky >= 0
%             if W5(kx,ky)==1
%                 num = num+1;
%                 sx(num)=kx;
%                 sy(num)=ky;
%             end
%         end
%     end
% 
%     ringnum(numx)=floor(num./2);
%     distance(numx)=sqrt((ky1-ky2(numx)).^2+(kx1-kx2(numx)).^2);
%     average=distance./ringnum;
% end
% ring=floor(mean(ringnum(1:outxnum)))
% % distance1=mean(distance(1:outxnum-1800))
% average1 = mean(average(140:outxnum-100))
  