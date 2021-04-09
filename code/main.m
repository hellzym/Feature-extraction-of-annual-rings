I = imread('D:\image\50204.tif');
%I = imread('G:\feature_extraction\2.jpg');
circen=coordinate(I);
[x0 y0]=coordinate(I)
[outrx,outry]=outimage(I)
% I = imread('I:\feature_extraction\background\49804.tif');
I = rgb2hsv(I);
I = I(:,:,3);
% I = rgb2gray(I);

I = im2double(I); 
imshow(I);
% %%- 平滑图像
I = gauss(I,1,1);

%%- 给平滑图像加噪
% I0=Img+10*randn([nrow, ncol]);
% figure(2); imshow(uint8(I0));
imshow(I);

lamda=0.3;       
timestep=0.01;    % 设置步长

I_temp=I;        % 初始化
[nrow, ncol] = size(I);
%%- 迭代开始
for n=1:150
   
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
% imshow(uint8(I_temp));
% imshow(I_temp);
W5=edge(I_temp,'canny',0.04);
imshow(W5);
% view=pi./4;
% k=tan(view);
% [x,y]=solve('(x-x0).^2+(y-y0).^2=R.^2','y=kx','x','y')
%qiuyubianyuanjiaodian

kx1=x0;
ky1=y0;
[~,outxnum]=size(outrx);
outynum=outxnum;

for numx=1:outxnum
    kx2(numx)=outrx(numx);
    ky2(numx)=outry(numx);
    kk(numx) = (ky1-ky2(numx))./(kx1-kx2(numx));
     num =0;
    for kx=kx2(numx):1:kx1
    ky=ceil(kk(numx)*(kx-kx1)+ky1);
    if W5(kx,ky)==1
        num = num+1;
        sx(num)=kx;
        sy(num)=ky;
   
    end
     outside(numx)=sqrt((kx2(numx)-sx(30)).^2+(ky2(numx)-sy(30)).^2);
     [~,index]=size(sx)
     inside(numx)=sqrt((kx1-sx(index-30)).^2+(ky1-sy(index-30)).^2);
    end

ringnum(numx)=floor(num./2);
distance(numx)=sqrt((ky1-ky2(numx)).^2+(kx1-kx2(numx)).^2);

% average=distance./ringnum;
% sx15=sx(30);
% sy15=sy(30);
% dis_out_15(numx)=sqrt((sx15-kx2(numx)).^2+(sy15-ky2(numx)).^2)
% dis_out_15av(numx)=dis_out_15(numx)./15
% sx38=sx(40);
% sy38=sy(40);
% dis_in_15(numx)=sqrt((sx38-kx1).^2+(sy38-ky1).^2)
% dis_in_15av(numx)=dis_in_15(numx)./15
% for number=1:2:num-1
%     dis_av(number)=sqrt((sx(number+1)-sx(number)).^2+(sy(number+1)-sy(number)).^2);
% end
end
outsidel=mean(outside(1300:1919))
out=outsidel./15
insidel=mean(inside(1300:1919))
in=2*insidel./15
ring=floor(mean(ringnum(800:1200)))
% distance1=mean(distance(1:outxnum-1800))
distance1=mean(distance(400:900))*2
average=distance1./ring