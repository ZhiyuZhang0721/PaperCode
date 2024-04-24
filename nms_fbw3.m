function Z=nms_fbw3(X)
[m,n]=size(X);
Y=zeros(m+2,n+2);
Y((2:m+1),(2:n+1))=X;
for i=2:m+1
    for j=2:n+1
        B(1)=Y(i-1,j);
        B(2)=Y(i,j-1);
        B(3)=Y(i,j);
        B(4)=Y(i,j+1);
        B(5)=Y(i+1,j);
        if Y(i,j)==max(B)&&max(B)>0.3
            Z(i-1,j-1)=max(B);
        else
            Z(i-1,j-1)=Y(i,j)*(Y(i,j)-min(B))/(max(B)-min(B));
        end
    end
end