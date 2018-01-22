%%������ڻ���任ԭ�� 
%%2018.01.16 by Cooper Liu
%%Questions? Contact me: angelpoint@foxmail.com
clear;clc; %���֮ǰ�ı���
I=imread('line5.bmp'); %��ȡͼ��
level=graythresh(I); %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ
bw=im2bw(I,level); %������ֵ��ʹ��im2bw�������Ҷ�ͼ��ת��Ϊ��ֵͼ��ʱ
figure(1);imshow(bw);
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
[m,n]=size(countMatrix);
for i=1:m
    for j=1:n
        if countMatrix(i,j)>countMatrix(1,1)
            countMatrix(1,1)=countMatrix(i,j); %��ȡ������ߵ��ཻ��
            angle=j; %��ȡ�ཻ�㴦��Ӧ�ĽǶ�
        end
    end
end
toc;
angle %����õ��ĽǶ��� ԭ�㵽ֱ�ߵĴ��� ��X��ļн�
if angle<=90
    rot=-angle;
else
    rot=180-angle;
end
pic=imrotate(I,rot,'crop'); %��תͼ��
figure(2);imshow(pic);
                