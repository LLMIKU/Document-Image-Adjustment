%% �ĵ�ͼ����б�Ǽ�⼰У�������ڻ���任ԭ��
% Version_1.01 2018.01.21_15:12 by Cooper Liu 
% ����ʹ��˵����������Ϊmatlab����
% ����ͼƬĿǰ��line.bmpϵ�к�23.bmp���뽫��ЩͼƬ��������ͬһĿ¼��
% Questions? Contact me: angelpoint@foxmail.com

%% ������ͼ��Ԥ������
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
I1=bwareaopen(I1, meanArea+1);%ȥ�����ŻҶ�ֵС��ƽ���Ĳ���
figure(5);imshow(I1);

bw=~I1; %ȡ��


%% �����ǻ��ڻ���任����бУ��
[m,n]=size(bw); %��ȡ�ߴ�
pMax=round(sqrt(m^2+n^2)); %�������p
thetaMax=180; %�趨���Ƕ�
countMatrix=zeros(pMax,thetaMax); %����p�ͽǶȵļ�������
tic;
for i=1:m
    for j=1:n
        if bw(i,j)==0
            for theta=1:thetaMax %��theta��ѭ��
                p=floor( abs( i*cos(3.14*theta/180) + j*sin(3.14*theta/180) ) ); %��thetaѭ�������м���ͼ�������һ�����ص��Ӧ��pֵ
                countMatrix(p+1,theta)=countMatrix(p+1,theta)+1; %���ص��Ӧ�ļ���������(p+1,theta)������
            end
        end
    end
end
toc;
[m,n]=size(countMatrix);
for i=1:m
    for j=1:n
        if countMatrix(i,j)>countMatrix(1,1)
            countMatrix(1,1)=countMatrix(i,j); %��ȡ������ߵ��ཻ��
            angle=j; %��ȡ�ཻ�㴦��Ӧ�ĽǶ�
        end
    end
end
angle %����õ��ĽǶ��� ԭ�㵽ֱ�ߵĴ��� ��X��ļн�
if angle<=90
    rot=-angle;
else
    rot=180-angle;
end
pic=imrotate(I,rot,'crop'); %��תͼ��
figure(9);imshow(pic);