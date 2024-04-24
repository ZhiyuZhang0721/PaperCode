function F = pratt_fbw(Ea,Ed)

% Function EDPM : Edge detector performance measure function. 
% 	          Calculates for a given edge image the false alarm 
%		  count, miss count and figure of merit (F) values.   		 	
%
%  
%    Input(s)... Ea : ideal edge image     	
%		 Ed : Detected edge image.
%
%    Output(s).. fac: False alarm count
%		 msc: miss count
%		 F  : Figure of merit
Ea=double(Ea);
Ed=double(Ed);

[N,M]=size(Ea);
if [N,M]~=size(Ed) 
  error('Actual and detected edge image sizes must be same');
end;
a=1/9; % edge shift penalty constant;
Na=sum(sum(Ea==1));Nd=sum(sum(Ed==1));
c=1/max(Na,Nd);
[ia,ja]=find(Ed-Ea==1);
[GTx,GTy]=find(Ea==1);
[TPx,TPy]=find(Ea.*Ed==1);
F=c*length(TPx);
if ~isempty(ia)
for k=1:length(ia) 
  tx=GTx-ia(k);
  ty=GTy-ja(k);
  di=min(sqrt(tx.^2+ty.^2));
  F=F+c/(1+a*di^2);
end
end

F = F*100;
