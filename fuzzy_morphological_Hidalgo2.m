function [Z,D_sup,E_inf]=fuzzy_morphological_Hidalgo2(A,B)
[m,n]=size(A);
D_sup=zeros(m,n);
E_inf=zeros(m,n);
D=zeros(3,3);
E=zeros(3,3);
Z=zeros(m,n);
  for i=1:m
    for j=1:n  
     D(1,1)=T_norm(B(1,1),A(i,j),'nM');   %1
     E(1,1)=I_g(B(1,1),A(i,j),'GD');
     if i+1>m
         D(2,1)=0;
         E(2,1)=1;
     else
         D(2,1)=T_norm(B(2,1),A(i+1,j),'nM');%2
         E(2,1)=I_g(B(2,1),A(i+1,j),'GD');
     end
     if i+2>m
         D(3,1)=0;
         E(3,1)=1;
     else
         D(3,1)=T_norm(B(3,1),A(i+2,j),'nM');%3
         E(3,1)=I_g(B(3,1),A(i+2,j),'GD'); 
     end
     if i+1>m||j+1>n
         D(2,2)=0;
         E(2,2)=1;
     else 
         D(2,2)=T_norm(B(2,2),A(i+1,j+1),'nM');%3
         E(2,2)=I_g(B(2,2),A(i+1,j+1),'GD'); 
     end 
     if i+2>m||j+1>n
         D(3,2)=0;
         E(3,2)=1;
     else 
        D(3,2)=T_norm(B(3,2),A(i+2,j+1),'nM');%5
        E(3,2)=I_g(B(3,2),A(i+2,j+1),'GD');
     end 
     if i+2>m||j+2>n
         D(3,3)=0;
         E(3,3)=1;
     else 
        D(3,3)=T_norm(B(3,3),A(i+2,j+2),'nM');%6
        E(3,3)=I_g(B(3,3),A(i+2,j+2),'GD');
     end 
     if j+1>n
         D(1,2)=0;
         E(1,2)=1;
     else
         D(1,2)=T_norm(B(1,2),A(i,j+1),'nM');%7
         E(1,2)=I_g(B(1,2),A(i,j+1),'GD');
     end
     if j+2>n
         D(1,3)=0;
         E(1,3)=1;
     else 
        D(1,3)=T_norm(B(1,3),A(i,j+2),'nM');%8
        E(1,3)=I_g(B(1,3),A(i,j+2),'GD');
     end 
     if i+1>m||j+2>n
         D(2,3)=0;
         E(2,3)=1;
     else 
        D(2,3)=T_norm(B(2,3),A(i+1,j+2),'nM');%9
        E(2,3)=I_g(B(2,3),A(i+1,j+2),'GD');
     end 
        D_sup(i,j)=max(max(D));
        E_inf(i,j)=min(min(E));
        Z(i,j)=fuzzy_subtraction(D_sup(i,j),E_inf(i,j),'exps');
    end
  end