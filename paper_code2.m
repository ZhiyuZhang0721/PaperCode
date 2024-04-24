close all;
clc;
a=imread('143.pgm');
G=im2double(a);
%处理GT自然背景
b=imread('143GT.pgm');
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
        if GT1(i,j)>0.9
            GT(i,j)=1;
        end
    end
end

%求方向梯度
or = featureorient(G, 0, 0.9);
smor = smoothorient(or, 1);

%求模糊边缘
I=[0.86 0.86 0.86; 0.86 1 0.86; 0.86 0.86 0.86];

[Z,D_sup,E_inf]=fuzzy_morphological_Hidalgo(G,I);
[Z1,D_sup1,E_inf1]=fuzzy_morphological_Hidalgo1(G,I);
[Z2,D_sup2,E_inf2]=fuzzy_morphological_Hidalgo2(G,I);
[Z3,D_sup3,E_inf3]=fuzzy_morphological_Hidalgo3(G,I);

Z_gray=255-im2uint8(Z);
Z_gray1=255-im2uint8(Z1);
Z_gray2=255-im2uint8(Z2);
Z_gray3=255-im2uint8(Z3);

Fuzzy_image=im2double(Z_gray);
Fuzzy_image1=im2double(Z_gray1);
Fuzzy_image2=im2double(Z_gray2);
Fuzzy_image3=im2double(Z_gray3);

%nms方法
[im, location] = nonmaxsup(Z, smor, 1.5);
[im1, location1] = nonmaxsup(Z1, smor, 1.5);
[im2, location2] = nonmaxsup(Z2, smor, 1.5);
[im3, location3] = nonmaxsup(Z3, smor, 1.5);
NMS_image=255-im2uint8(im);
NMS_image1=255-im2uint8(im1);
NMS_image2=255-im2uint8(im2);
NMS_image3=255-im2uint8(im3);

%HYS方法得到边缘像素宽度为1

HYS_image= hysthresh(NMS_image,222,223);
HYS_image1 = hysthresh(NMS_image1,222,223);
HYS_image2 = hysthresh(NMS_image2,222,223);
HYS_image3 = hysthresh(NMS_image3,222,223);

 
subplot(221);imshow(HYS_image);  %s
subplot(222);imshow(HYS_image1); %logs 
subplot(223);imshow(HYS_image2);  %exps
subplot(224);imshow(HYS_image3);  %sins

%计算FOM值


F=pratt_fbw(GT,1-HYS_image);
F1=pratt_fbw(GT,1-HYS_image1);
F2=pratt_fbw(GT,1-HYS_image2);
F3=pratt_fbw(GT,1-HYS_image3);
F_com=[F F1 F2 F3]



