function [ trans, R, T, error, tarNum, ratio, corrSet ] = icpProcess( ref, tar )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
tarNumBegin = size(tar, 1);
randRank = randperm(size(tar, 1));
tar = tar(randRank,:);
[tar,ref,error] = findNear(tar, ref);
tarNum = size(tar, 1);
ratio = tarNum/tarNumBegin;
corrSet = [ref, tar];
[trans, R, T] = calcuTrans( ref, tar );

end

