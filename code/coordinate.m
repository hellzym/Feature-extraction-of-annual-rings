%%%%%%%%% EXAMPLE #3:
%daima fei great
%  rawimg = imread('TestImg_CHT_c3.bmp');
% rawimg = imread('G:\feature_extraction\2.jpg');
%[10 150], 1,50, 0.45
% rawimg = imread('G:\feature_extraction\background\50308.tif');
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
function[x0 y0]=coordinate(I)
rawimg = I;
%[90 150], 6,130, 0.6)
 rawimg=rgb2gray(rawimg);
  fltr4img = [1 1 1 1 1; 1 2 2 2 1; 1 2 4 2 1; 1 2 2 2 1; 1 1 1 1 1];
 fltr4img = fltr4img / sum(fltr4img(:));
  imgfltrd = filter2( fltr4img , rawimg );
  tic;
  [accum, circen, cirrad] = ...
      CircularHough_Grd(imgfltrd, [10 150], 1,50, 0.45);
  toc;
  figure(1); imagesc(accum); axis image;
  figure(2); imagesc(rawimg); colormap('gray'); axis image;
  hold on;
  plot(circen(:,1), circen(:,2), 'r+');
  for k = 1 : size(circen, 1),
      DrawCircle(circen(k,1), circen(k,2), cirrad(k), 32, 'b-');
  end
  hold off;
  title(['Raw Image with Circles Detected ', ...
      '(center positions and radii marked)']);
  %qiu chu xian ci shu zui duo de zuo biao
  table=unique(circen(:,2));
htable=histc(circen(:,2),table);
[maxCount idx]=max(htable);
y0=table(idx);
  table=tabulate(circen(:,1));
  [maxCount idx]=max(table(:,2));
  x0=table(idx);
end