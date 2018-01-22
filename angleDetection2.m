%%���������С���뷨ֱ�����ԭ�� 
%%2018.01.19 by Cooper Liu
%%Questions? Contact me: angelpoint@foxmail.com
clear;clc; %���֮ǰ�ı���
I=imread('line5.bmp'); %��ȡͼ��
level=graythresh(I); %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ
bw=im2bw(I,level); %������ֵ��ʹ��im2bw�������Ҷ�ͼ��ת��Ϊ��ֵͼ��ʱ
figure(1);imshow(bw);

[m,n]=size(bw); %��ȡ�ߴ�
xSum=0;xCount=0;
ySum=0;yCount=0;
tic; %��ʱ��ʼ
for i=1:m
    for j=1:n
        if bw(i,j)==0
           xSum=xSum+i;xCount=xCount+1;
           ySum=ySum+j;yCount=yCount+1;
        end
    end
end
xMean=xSum/xCount;
yMean=ySum/yCount;

Lxx=0;
Lyy=0;
Lxy=0;
for i=1:m
    for j=1:n
        if bw(i,j)==0
          Lxx=Lxx+(i-xMean)^2;
          Lyy=Lyy+(j-yMean)^2;
          Lxy=Lxy+(i-xMean)*(j-yMean);
        end
    end
end
toc %��ȡ��ʱʱ��
tmp=((Lyy-Lxx) + nthroot((Lyy-Lxx)^2 + 4*Lxy^2, 2))/(2*Lxy);
if isnan(tmp) 
    tmp=inf; %������tmp��NaN����ô����Ҫ��ת
end
%tmp=atan(2*Lxy/(Lxx-Lyy))/2; %�����б�������ˮƽ��������45
angle=atan(tmp); %��atan������ĽǶ���-pi/2��+pi/2֮��
angle=angle*180/pi

rot=90-angle;
pic=imrotate(I,rot,'crop'); %��תͼ��
figure(2);imshow(pic);