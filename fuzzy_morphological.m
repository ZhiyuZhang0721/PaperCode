function [Z,D_sup,E_inf]=fuzzy_morphological(A,B)
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
         E(2,1)=1;
     else
          %2
         E(2,1)=I_g(B(2,1),A(i+1,j),'GD');
     end
     if i+2>m
         E(3,1)=1;
     else
          %3
         E(3,1)=I_g(B(3,1),A(i+2,j),'GD'); 
     end
     if i+1>m||j+1>n
         E(2,2)=1;
     else 
         %3
         E(2,2)=I_g(B(2,2),A(i+1,j+1),'GD'); 
     end 
     if i+2>m||j+1>n
         E(3,2)=1;
     else 
        %5
        E(3,2)=I_g(B(3,2),A(i+2,j+1),'GD');
     end 
     if i+2>m||j+2>n
         E(3,3)=1;
     else 
        %6
        E(3,3)=I_g(B(3,3),A(i+2,j+2),'GD');
     end 
     if j+1>n
         E(1,2)=1;
     else
          %7
         E(1,2)=I_g(B(1,2),A(i,j+1),'GD');
     end
     if j+2>n
         E(1,3)=1;
     else 
         %8
        E(1,3)=I_g(B(1,3),A(i,j+2),'GD');
     end 
     if i+1>m||j+2>n
         E(2,3)=1;
     else 
        %9
        E(2,3)=I_g(B(2,3),A(i+1,j+2),'GD');
     end 
       if i==1  %2
           D(2,1)=0;
       else
           D(2,1)=T_norm(B(2,1),A(i-1,j),'nM');
       end
       if i==1||j==1 %3
           D(2,2)=0;
       else
           D(2,2)=T_norm(B(2,2),A(i-1,j-1),'nM');
       end
       if i==1||j<=2 %4
           D(2,3)=0;
       else
           D(2,3)=T_norm(B(2,3),A(i-1,j-2),'nM');
       end
       if j==1 %5
           D(1,2)=0;
       else
           D(1,2)=T_norm(B(1,2),A(i,j-1),'nM');
       end
       if i<=2||j==1  %6
           D(3,2)=0;
       else
           D(3,2)=T_norm(B(3,2),A(i-2,j-1),'nM');
       end
       if i<=2||j<=2 %7
           D(3,3)=0;
       else
          D(3,3)=T_norm(B(3,3),A(i-2,j-2),'nM');
       end 
       if i<=2 %8
           D(3,1)=0;
       else
           D(3,1)=T_norm(B(3,1),A(i-2,j),'nM');
       end 
       if j<=2 %9
           D(1,3)=0;
       else
           D(1,3)=T_norm(B(1,3),A(i,j-2),'nM');
       end 
        D_sup(i,j)=max(max(D));
        E_inf(i,j)=min(min(E));
        Z(i,j)=fuzzy_subtraction(D_sup(i,j),E_inf(i,j),'s');
    end
  end