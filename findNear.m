function [ corrTar,corrRef,error ] = findNear( tar,ref )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

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
    XY_dis(:, 1) = ref(:, 1) - tar(i, 1);    % �����㼯�еĵ�x����֮��
    XY_dis(:, 2) = ref(:, 2) - tar(i, 2);    % �����㼯�еĵ�y����֮��
    distance = XY_dis(:, 1).^2 + XY_dis(:, 2).^2;   % ŷ�Ͼ���
    [minDis, minIndex] = min(distance);         % �ҵ�������С���Ǹ���
    if minDis < pointThreshold
        cnt = cnt + 1;
        corrRef(cnt, :) = ref(minIndex, :);   % ���Ǹ��㱣��Ϊ��Ӧ��
        corrTar(cnt, :) = tar(i, :);
        err(cnt) = minDis;     % ��������ֵ
        ref(minIndex,:) = [];
        r = r-1;
    end
end
error = mean(err);

end








