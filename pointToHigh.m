function [ h ] = pointToHigh( bp, bp2, tp )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明

a=sqrt((bp(1)-bp2(1))^2 + (bp(2)-bp2(2))^2);
b=sqrt((bp(1)-tp(1))^2 + (bp(2)-tp(2))^2);
c=sqrt((tp(1)-bp2(1))^2 + (tp(2)-bp2(2))^2);
p = (a + b + c) / 2;
s = sqrt(abs(p * (p - a) * (p - b) * (p - c)));
h = s * 2 / a;

end

