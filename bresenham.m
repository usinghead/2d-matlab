function [ out ] = bresenham( x0,y0,x1,y1 )
%UNTITLED11 此处显示有关此函数的摘要
%   此处显示详细说明
dx = abs(x1 - x0);
dy = abs(y1 - y0);
if x0 < x1
    sx = 1;
else
    sx = -1;
end
if y0 < y1
    sy = 1;
else
    sy = -1;
end
if dx >= dy
    err = dx/2;
else
    err = -dy/2;
end
i = 1;
out = [0 0];
while(1)
    out(i,:) = [x0 y0];
    i = i + 1;
    if x0 == x1 && y0 ==y1
        break
    end
    e2 = err;
    if e2 > -dx
        err = err - dy;
        x0 = x0 + sx;
    end
    if e2 < dy
        err = err + dx;
        y0 = y0 + sy;
    end
end
% out(end,:) = [];


end

