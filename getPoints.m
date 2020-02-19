function [ points, index, this ] = getPoints( pose, laserLen )
%UNTITLED9 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
cnt = 1;
index = laserLen<8 & laserLen>0.2;
points = zeros(sum(index), 2);
for i = find(index)
    len = laserLen(i);
    theta = pose(3) + (i-1) * pi / 180;
    c = cos(theta);
    s = sin(theta);
    points(cnt, :) = [pose(1)+c*len,pose(2)+s*len];
    cnt = cnt + 1;
end
this = gridFilter(points);

end

