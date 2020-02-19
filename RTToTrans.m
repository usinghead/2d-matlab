function [ trans ] = RTToTrans( R, T )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
a = size( R, 1);
if a == 2
    mid = [ 0, 0, 1 ];
elseif a == 3
    mid = [ 0, 0, 0, 1 ];
end
trans = cat( 1, cat( 2, R, T ), mid);

end

