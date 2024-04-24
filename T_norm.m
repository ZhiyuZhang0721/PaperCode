function z=T_norm(x,y,T_type)
switch T_type
    case 'nM'
if x+y<=1
    z=0;
else
z=min(x,y);
end
    case 'M'
        z=min(x,y);
end