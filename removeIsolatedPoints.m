function [  ] = removeIsolatedPoints( )
%UNTITLED12 此处显示有关此函数的摘要
%   此处显示详细说明
global map mapRangeGrid occ;

a = mapRangeGrid(1);
b = mapRangeGrid(2);
[row, col] = find(map(3:a-2,3:b-2) >= occ);
m1 = map >= occ;
row = row+2;
col = col+2;
r = size(row, 1);
for n = 1:r
    i = row(n);
    j = col(n);
    window = m1(i-1:i+1,j-1:j+1);
    cnt = sum(sum(window));
    if cnt == 1
        map(i, j) = 0;
    end
end

end

