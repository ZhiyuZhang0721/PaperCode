close all;
clc;
a=imread('47.pgm');
G=im2double(a);

%求真实的边缘GT

b=imread('47GT.pgm');
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

[Z,D_sup,E_inf]=fuzzy_morphological_Hidalgo4(G,I);
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


%新增部分

% Perform edge detection using different operators
operators = {'sobel', 'canny', 'roberts', 'prewitt'};
nir_values = zeros(1, length(operators));

for i = 1:length(operators)
    detected_edges = edge(G, operators{i});
    nir_values(i) = calculateNIR(GT, detected_edges);
end

% Laplacian edge detection
laplacian_edges = del2(double(G));
% Use Laplacian result directly without thresholding
nir_laplacian = calculateNIR(GT, laplacian_edges > 0);

% Add your operator
nir_your_operator = calculateNIR(GT, HYS_image);
nir_your_operator = 1 - nir_your_operator;  % Adjust for black edges
operators = [operators, 'Laplacian', 'Your Operator'];
nir_values = [nir_values, nir_laplacian, nir_your_operator];

% Plot
figure;
plot(nir_values, '-o');  % Use line plot with dots
set(gca, 'XTick', 1:length(operators), 'XTickLabel', operators);
ylabel('Noise Introduction Rate');
ylim([0, 1]);  % Set Y axis range
yticks(0:1);  % Set Y axis ticks
ytickformat('%.1f');  