function [ out ] = transform( tar, trans )
%UNTITLED8 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[h, w] = size(tar);
t = [tar, ones(h, 1)]';
t2 = (trans * t)';
out = t2( : ,1:w);  

end

