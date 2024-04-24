close all;
clc;
a=imread('143.pgm');
G=im2double(a);

%求真实的边缘GT

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
GT=1-im2double(c);

%求方向梯度
or = featureorient(G, 0, 0.9);
smor = smoothorient(or, 1);

%求模糊边缘
I=[0.86 0.86 0.86; 0.86 1 0.86; 0.86 0.86 0.86];

[Z,D_sup,E_inf]=fuzzy_morphological_Hidalgo(G,I);
Z_gray=255-im2uint8(Z);
Fuzzy_image=im2double(Z_gray);

%nms方法
[im, location] = nonmaxsup(Z, smor, 1.2);
NMS_image=255-im2uint8(im);


%HYS方法得到边缘像素宽度为1
for i=1:25
    for j=i:25
        t1=180+2*i;
        t2=180+2*j;
   Ea=1-hysthresh(NMS_image,t1,t2); 
   F(i,j)=pratt_fbw(GT,Ea);
    end
end
F_max=max(max(F));
[x,y]=find(F==F_max);
tx=180+2*x(1);
ty=180+2*y(1);
HYS_image= hysthresh(NMS_image,tx,ty); %tx=216 ty=220(144)  %tx=222 ty=230(143)
%HYS_image= hysthresh(NMS_image,200,230); 
subplot(221);imshow(G);  
subplot(222);imshow(Fuzzy_image);  
subplot(223);imshow(NMS_image);  
subplot(224);imshow(HYS_image);  

%计算FOM值