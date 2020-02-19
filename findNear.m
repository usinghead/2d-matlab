function [ corrTar,corrRef,error ] = findNear( tar,ref )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

global pointThreshold;
cnt = 0;
err = [];

t = size(tar, 1);
r = size(ref, 1);
if t > r
    tar = tar(1:r, :);
    t = r;
end

for i = 1:t
    XY_dis = zeros(r, 2);
    XY_dis(:, 1) = ref(:, 1) - tar(i, 1);    % 两个点集中的点x坐标之差
    XY_dis(:, 2) = ref(:, 2) - tar(i, 2);    % 两个点集中的点y坐标之差
    distance = XY_dis(:, 1).^2 + XY_dis(:, 2).^2;   % 欧氏距离
    [minDis, minIndex] = min(distance);         % 找到距离最小的那个点
    if minDis < pointThreshold
        cnt = cnt + 1;
        corrRef(cnt, :) = ref(minIndex, :);   % 将那个点保存为对应点
        corrTar(cnt, :) = tar(i, :);
        err(cnt) = minDis;     % 保存距离差值
        ref(minIndex,:) = [];
        r = r-1;
    end
end
error = mean(err);

end








