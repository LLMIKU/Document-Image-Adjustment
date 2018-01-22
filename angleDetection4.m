%%�������б�ʿռ�ͶƱԭ���Ľ���angleDetection3.m 
%%2018.01.20_15:41 by Cooper Liu
%%Questions? Contact me: angelpoint@foxmail.com
clear;clc; %���֮ǰ�ı���
I=imread('line5.bmp'); %��ȡͼ��
level=graythresh(I); %ʹ�������䷽��ҵ�ͼƬ��һ�����ʵ���ֵ
bw=im2bw(I,level); %������ֵ��ʹ��im2bw�������Ҷ�ͼ��ת��Ϊ��ֵͼ��ʱ
figure(1);imshow(bw);
[m,n]=size(bw); %��ȡ�ߴ�
flag=0;

 for i=1:m
    for j=1:n
        if bw(i,j)==0
            if flag==0
                x0=i;y0=j;
                flag=1;
            end
        end
    end
 end
range=10; %����б�������Ϊ10��������
low=-1;
high=3;
tmpLow=low;
tmpHigh=high;
max=0;
areaAddtion=0; 
tic; %��ʼ��ʱ
while high-low>0.0001
a=zeros(range,1);
    for i=1:m
        for j=1:n
            if bw(i,j)==0
                if i==x0 %���x������x0��ͬ
                    k=2; %��̶�kΪ2
                    if k>=low && k<=high
                        area=floor((k-low)/(high-low)*range); %����ȡ��
                        if area==range %����������һ������
                            area=area-1; %�뿼�ǵ��������������area+1
                        end
                        a(area+1,1)=a(area+1,1)+1; %�������
                    end
                else     %���x������x0��ͬ
                    k=(j-y0)/(i-x0); %�����б��
                    k2=k;
                    if  k>1 || k<-1
                        k2=2-1/k;
                    end
                    if k2>=low && k2<=high
                        area=floor((k2-low)/(high-low)*range); %����ȡ��
                        if area==range
                            area=area-1;
                        end
                        a(area+1,1)=a(area+1,1)+1;
                    end
                end 
            end
        end
    end
[s_i,index] = sort(a,'descend');
max = index(1);
tmpLow = low;
tmpHigh = high;
if max>=2 && max<=9
    areaAddition=0; %������Ҫ���Ը���������ķ�Χ
else
    areaAddtion=0;
end
low = tmpLow + (max - 1 - areaAddition)/range*(tmpHigh - tmpLow);
high = tmpLow + (max + areaAddtion)/range*(tmpHigh - tmpLow);
end

toc %��ȡ��ʱʱ��

tmp=tmpLow+max/range*(tmpHigh-tmpLow);
if tmp>1
    k=1/(2-tmp);
else
    k=tmp;
end
angle=atan(k); %��atan������ĽǶ���-pi/2��+pi/2֮��
angle=angle*180/pi

rot=90-angle;
pic=imrotate(I,rot,'crop'); %��תͼ��
figure(2);imshow(pic);