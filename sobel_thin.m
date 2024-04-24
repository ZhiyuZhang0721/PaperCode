function e = sobel_thin(img)
op = fspecial('sobel') / 8;
x_mask = op';
a = im2double(img);
scale = 4;
bx = imfilter(a,x_mask,'replicate');
b = bx.*bx;
cutoff = 4 * mean2(b);
[m, n] = size(b);
 
for r = 1 : m
    for c=1 : n
        if ((c - 1) < 1)
            b1 = true;
        else
            b1 = (b(r, c - 1) <= b(r, c));
        end
        if (c + 1) > n
            b2 = true;
        else
            b2 = (b(r, c) > b(r, c + 1));
        end
        if ((r - 1) < 1)
            b3 = true;
        else
            b3 = (b(r - 1, c) <= b(r, c));
        end
        if ((r+1) > m)
            b4 = true;
        else
            b4 = (b(r, c) > b(r + 1, c));
        end
        e(r, c) = (b(r, c) > cutoff) &  ((b1 & b2) | (b3 & b4));
    end
end