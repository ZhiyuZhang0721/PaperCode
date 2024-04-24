close all;
clc;

b=imread('144GT.pgm');
[m,n]=size(b);
c=b;
for i=2:m-1
    for j=2:n-1
        if b(i-1,j-1)<50&&b(i-1,j)<50&&b(i-1,j+1)<50&&b(i,j-1)<50&&b(i,j)<50&&b(i,j+1)<50&&b(i+1,j-1)<50&&b(i+1,j)<50&&b(i+1,j+1)<50
            c((i-1:i+1),(j-1:j+1))=255*ones(3,3);
        end
    end
end
imshow(255-c)
 

%¼ÆËãFOMÖµ