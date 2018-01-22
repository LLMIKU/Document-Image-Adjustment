%% �ĵ�ͼ����б�Ǽ�⼰У����������С����ֱ�����ԭ��
% Version_1.02 2018.01.21_20:30 by Cooper Liu 
% ����ʹ��˵����������Ϊmatlab�����ɴ����A��B��C��ɣ���ѡ��A+C����B+C
% ����ͼƬĿǰ��line.bmpϵ�к�23.bmp���뽫��ЩͼƬ��������ͬһĿ¼��
% Questions? Contact me: angelpoint@foxmail.com

%% �����A�������Ĳ���ͼƬline.bmpϵ�����������´��룬������ͼ��Ԥ������
% clear;clc;
% I=imread('line5.bmp'); %��ȡͼ��
% level=graythresh(I); %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ
% bw=im2bw(I,level); %������ֵ��ʹ��im2bw�������Ҷ�ͼ��ת��Ϊ��ֵͼ��
% I1=~bw; %��ֵͼ��ȡ��
% figure(1);imshow(I1);


%% �����B�������ĵ�ͼ��23.bmp���������´��룬������ͼ��Ԥ������
clear;clc;
I=imread('23.bmp'); %��ȡͼ��
level=graythresh(I); %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ
bw=im2bw(I,level); %������ֵ��ʹ��im2bw�������Ҷ�ͼ��ת��Ϊ��ֵͼ��ʱ
bw=~bw; %��ֵͼ��ȡ��
figure(1);imshow(bw);

se=strel('square',16);
I1=imclose(bw,se); %������
figure(2);imshow(I1);

se=strel('square',12);
I1=imdilate(I1,se); %����
figure(3);imshow(I1);

se=strel('disk',18);
I1=imerode(I1,se); %��ʴ
figure(4);imshow(I1);

total = bwarea(I1);
[L, num]=bwlabel(I1,4); %�����ͨ��ĸ���
meanArea=round(total/num); %��ƽ����ͨ��
I1=bwareaopen(I1, meanArea+1); %ȥ�����ŻҶ�ֵС��ƽ���Ĳ���
figure(5);imshow(I1);


%% �����C����б�Ǽ�⼰У������

f=I1;
[L,n]=bwlabel(f,4);
mark=0;
for k=1:n
    [r,c]=find(L==k);
    [s_i,index] = sort(c,'descend'); %����
    if mark<(max(c)-min(c))
        mark=k; %Ѱ��ˮƽ�������ֱ��
    end
end
tic;
for k=mark
    [r,c]=find(L==k);
    
    xMean=mean(r);yMean=mean(c);
    xSum=sum(r);ySum=sum(c);
    
    LxxCol=(r(:,1)-xMean).^2;
    Lxx=sum(LxxCol);
    
    LyyCol=(c(:,1)-yMean).^2;
    Lyy=sum(LyyCol);
    
    LxyCol=(r(:,1)-xMean).*(c(:,1)-yMean);
    Lxy=sum(LxyCol);
    
    tmp=((Lyy-Lxx) + nthroot((Lyy-Lxx)^2 + 4*Lxy^2, 2))/(2*Lxy);
    if isnan(tmp) 
       tmp=inf; %������tmp��NaN����ô����Ҫ��ת
    end
    angle=atan(tmp); %��atan������ĽǶ���-pi/2��+pi/2֮��
    angle=angle*180/pi
end
toc

rot=90-angle;
pic=imrotate(I,rot,'crop'); %��תͼ��
figure(9);imshow(pic);