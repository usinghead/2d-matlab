function [ trans, R, T ] = calcuTrans( ref, tar )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
r1 = size(tar, 1);
x1x2 = sum( tar(:, 1) .* ref(:, 1) );
y1y2 = sum( tar(:, 2) .* ref(:, 2) );
x1y2 = sum( tar(:, 1) .* ref(:, 2) );
x2y1 = sum( tar(:, 2) .* ref(:, 1) );

X2Y1 = mean(tar(:, 2)) * mean(ref(:, 1));
X1Y2 = mean(tar(:, 1)) * mean(ref(:, 2));
X1X2 = mean(tar(:, 1)) * mean(ref(:, 1));
Y1Y2 = mean(tar(:, 2)) * mean(ref(:, 2));

Theta = atand((r1 * (X2Y1 - X1Y2) + x1y2 - x2y1)...
    /(r1 * (X1X2 + Y1Y2) - x1x2 - y1y2));

t1 = (sum(ref(:, 1)) - cosd(Theta) * sum(tar(:, 1))...
    - sind(Theta) * sum(tar(:, 2)))/r1;
t2 = (sum(ref(:, 2)) + sind(Theta) * sum(tar(:, 1))...
    - cosd(Theta) * sum(tar(:, 2)))/r1;

R = [cosd(Theta) sind(Theta); 
    -sind(Theta) cosd(Theta)];

T = [t1; t2];

trans = RTToTrans( R, T );

end

