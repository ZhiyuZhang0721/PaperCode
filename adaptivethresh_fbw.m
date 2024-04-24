close all;
clc;
a=imread('36.pgm');
G=im2double(a);

%求真实的边缘GT
tic
b=imread('36GT.pgm');
[m,n]=size(b);
c=b;
for i=2:m-1
    for j=2:n-1
        if b(i-1,j-1)<50&&b(i-1,j)<50&&b(i-1,j+1)<50&&b(i,j-1)<50&&b(i,j)<50&&b(i,j+1)<50&&b(i+1,j-1)<50&&b(i+1,j)<50&&b(i+1,j+1)<50
            c((i-1:i+1),(j-1:j+1))=255*ones(3,3);
        end
    end
end
GT1=1-im2double(c);
GT=GT1;
for i=1:m
    for j=1:n
        if GT1(i,j)>0.8
            GT(i,j)=1;
        end
    end
end

[GTx,GTy]=find(GT>0&GT<1)

%求方向梯度
or = featureorient(G, 0, 0.9);
smor = smoothorient(or, 1);

%求模糊边缘
I=[0.86 0.86 0.86; 0.86 1 0.86; 0.86 0.86 0.86];

[Z,D_sup,E_inf]=fuzzy_morphological_Hidalgo(G,I);
Z_gray=255-im2uint8(Z);
Fuzzy_image=im2double(Z_gray);

%nms方法
[im, ~] = nonmaxsup(Z, smor, 1.2);
NMS_image=255-im2uint8(im);

F=zeros(25,25);
%HYS方法得到边缘像素宽度为1
for i=1:70
    for j=i:70
        t1=100+2*i;
        t2=100+2*j;
   Ea=1-hysthresh(NMS_image,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x,y]=find(F==F_max);
tx=100+2*x(1);
ty=100+2*y(1);
HYS_image= hysthresh(NMS_image,tx,ty);
value1=pratt_fbw(GT,1-HYS_image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fuzzy difference=log
[Z1,D_sup1,E_inf1]=fuzzy_morphological_Hidalgo1(G,I);

%nms方法
[im1, ~] = nonmaxsup(Z1, smor, 1.2);
NMS_image1=255-im2uint8(im1);


for i=1:70
    for j=i:70
        t1=100+2*i;
        t2=100+2*j;
   Ea=1-hysthresh(NMS_image1,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x1,y1]=find(F==F_max);
tx1=100+2*x1(1);
ty1=100+2*y1(1);
HYS_image1= hysthresh(NMS_image1,tx1,ty1);
value2=pratt_fbw(GT,1-HYS_image1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fuzzy difference=exp
[Z2,D_sup2,E_inf2]=fuzzy_morphological_Hidalgo2(G,I);

%nms方法
[im2, ~] = nonmaxsup(Z2, smor, 1.2);
NMS_image2=255-im2uint8(im2);


for i=1:70
    for j=i:70
        t1=100+2*i;
        t2=100+2*j;
   Ea=1-hysthresh(NMS_image2,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x2,y2]=find(F==F_max);
tx2=100+2*x2(1);
ty2=100+2*y2(1);
HYS_image2= hysthresh(NMS_image2,tx2,ty2);
value3=pratt_fbw(GT,1-HYS_image2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fuzzy difference=exp
[Z3,D_sup3,E_inf3]=fuzzy_morphological_Hidalgo3(G,I);

%nms方法
[im3, ~] = nonmaxsup(Z3, smor, 1.2);
NMS_image3=255-im2uint8(im3);


for i=1:70
    for j=i:70
        t1=100+2*i;
        t2=100+2*j;
   Ea=1-hysthresh(NMS_image3,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x3,y3]=find(F==F_max);
tx3=100+2*x3(1);
ty3=100+2*y3(1);
HYS_image3= hysthresh(NMS_image3,tx3,ty3);
value4=pratt_fbw(GT,1-HYS_image3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fuzzy difference=frac
[Z4,D_sup4,E_inf4]=fuzzy_morphological_Hidalgo4(G,I);

%nms方法
[im4, ~] = nonmaxsup(Z4, smor, 1.2);
NMS_image4=255-im2uint8(im4);


for i=1:70
    for j=i:70
        t1=100+2*i;
        t2=100+2*j;
   Ea=1-hysthresh(NMS_image4,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x4,y4]=find(F==F_max);
tx4=100+2*x4(1);
ty4=100+2*y4(1);
HYS_image4= hysthresh(NMS_image4,tx4,ty4);
value5=pratt_fbw(GT,1-HYS_image4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fuzzy difference=sp
[Z5,D_sup5,E_inf5]=fuzzy_morphological_Hidalgo5(G,I);

%nms方法
[im5, ~] = nonmaxsup(Z5, smor, 1.2);
NMS_image5=255-im2uint8(im5);


for i=1:70
    for j=i:70
        t1=100+2*i;
        t2=100+2*j;
   Ea=1-hysthresh(NMS_image5,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x5,y5]=find(F==F_max);
tx5=100+2*x5(1);
ty5=100+2*y5(1);
HYS_image5= hysthresh(NMS_image5,tx5,ty5);
value6=pratt_fbw(GT,1-HYS_image5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



subplot(231);imshow(HYS_image)
subplot(232);imshow(HYS_image1)
subplot(233);imshow(HYS_image2)
subplot(234);imshow(HYS_image3)
subplot(235);imshow(HYS_image4)
subplot(236);imshow(HYS_image5)
value=[value1,value2,value3,value4,value5,value6]
T_x=[tx,tx1,tx2,tx3,tx4,tx5]
T_y=[ty,ty1,ty2,ty3,ty4,ty5]
toc
t=toc


