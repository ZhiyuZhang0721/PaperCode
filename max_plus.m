function D=max_plus(A,B)
[m,p]=size(A);
[~,n]=size(B);
C=ones(1,p);
D=ones(m,n);
for i=1:m
    for j=1:n
        for k=1:p
            C(k)=A(i,k)*B(k,j);
        D(i,j)=max(C);
        end
    end
end