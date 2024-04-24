function z=I_g(x,y,I_type)
switch I_type
    case 'Ig'
if x<=y
    z=1-x+x^2;
else 
    z=1-x+x*y;    
end
    case 'KD'
        z=max(1-x,y);
    case 'GD'
        if x<=y
            z=1;
        else
            z=y;
        end
    case 'FD'
        if x<=y
            z=1;
        else
            z=max(1-x,y);
        end
end