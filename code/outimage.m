function[outrx,outry]=outimage(I)
 [m,n,p]=size(I);
 I=im2bw(I);
 se=strel('square',3);
 Ia=imerode(I,se);
 Iout=I-Ia;
 figure(1);
 imshow(Iout);
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
 figure(2);
 imshow(Iout);
 outright=Iout;
 [ny,nx]=size(outright);
 numi=0;
for iy=1:ny
    for ix=1:nx
    if outright(iy,ix)==1
        numi= numi+1;
        outrx(numi)=iy;
        outry(numi)=ix;
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
 figure(3);
 imshow(Iout1);
 outleft=Iout1;
 x=p(:,1);
 y=p(:,2);
 [R,x00,y00]=circ(x,y,N-1);
 disp(['banjing: ' num2str(R),' mm' ]);
 disp(['zuobiaodian:( ' num2str(x00) ,',',num2str(y00),')']);
 figure(4)
 imshow(I);
 hold on
 plot(x00,y00,'r+');
end