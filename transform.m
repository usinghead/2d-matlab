function [ out ] = transform( tar, trans )
%UNTITLED8 此处显示有关此函数的摘要
%   此处显示详细说明
[h, w] = size(tar);
t = [tar, ones(h, 1)]';
t2 = (trans * t)';
out = t2( : ,1:w);  

end

