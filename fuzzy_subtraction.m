function z=fuzzy_subtraction(x,y,s_type)
switch s_type
    case 's'
        z=max(x-y,0);
    case 'sp'
        z=sqrt(max(x^2-y^2,0));
    case 'logs'
        z=max((x-y)/(y+1),0);
    case 'exps'
        z=log(max(exp(x)-exp(y)+1,1));
    case 'sins'
        z=max((2/pi)*asin(sin(pi*x/2)-sin(pi*y/2)),0);
    case 'frac'
        z=max((x-y)/(1+x*y+2*y),0);
    %%Example3
    case 'ep3'
        z=sqrt(max(x^2+y^2-2*y,0));
end
