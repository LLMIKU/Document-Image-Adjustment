%%�������б�ʿռ�ͶƱԭ�� 
%%2018.01.20_14:09 by Cooper Liu
%%Questions? Contact me: angelpoint@foxmail.com
clear;clc; %���֮ǰ�ı���
I=imread('line5.bmp'); %��ȡͼ��
level=graythresh(I); %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ
bw=im2bw(I,level); %������ֵ��ʹ��im2bw�������Ҷ�ͼ��ת��Ϊ��ֵͼ��
figure(1);imshow(bw);
[m,n]=size(bw); %��ȡ�ߴ�
flag=0;
tic; %��ʱ��ʼ
 for i=1:m
    for j=1:n
        if bw(i,j)==0
            if flag==0
                x0=i;y0=j; %��ȡ��һ����
                flag=1;
            end
        end
    end
 end
range=10000; %rangeԽ��ԽǶȷֵø�ϸ������������
low=-1;
high=3;

a=zeros(range,1);
 for i=1:m
   for j=1:n
        if bw(i,j)==0
            if i==x0
                k=2;
                area=floor((k-(-1))/4*range); %����ȡ��
                a(area+1,1)=a(area+1,1)+1; %�������
            else
                k=(j-y0)/(i-x0);
                k2=k;
                if  k>1 || k<-1
                    k2=2-1/k; %ת��б�ʣ���֤б�ʷ�Χ��-1, 3��
                end
                area=floor((k2-(-1))/4*range); %����ȡ��
                a(area+1,1)=a(area+1,1)+1;
            end 
        end
    end
 end
 toc %��ȡʱ��
[s_i,index] = sort(a,'descend'); %�������򲢻�ȡԭ�����е������index
max=index(1);
tmp=(-1)+max/range*4;
if tmp>1
    k=1/(2-tmp); %��ԭԭ����б��
else
    k=tmp;
end
angle=atan(k); %��atan������ĽǶ���-pi/2��+pi/2֮��
angle=angle*180/pi

rot=90-angle;
pic=imrotate(I,rot,'crop'); %��תͼ��
figure(2);imshow(pic);