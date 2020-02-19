function [ lastTrans, theta, set ] = plicp( tar, ref )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

global PLThr;

lastTrans = [1 0 0;0 1 0;0 0 1];
theta = 0;
cnt = 0; %迭代次数
num = 0;
[corr, error, set] = findTwoPoints(ref, tar);

while cnt < 7  % && error > PLThr
    
    last_error = error;
    res = gpc(corr);
    theta = theta + res(3);
    trans = [rotMatrix(res(3)), [res(1);res(2)]; 0,0,1];
    tar = transform(tar, trans);
    [corr, error, set1] = findTwoPoints(ref, tar);
    if error > last_error
        num = num + 1;
        if num >= 2;
            break;
        end
    end
    cnt = cnt + 1;
    set = set1;
    lastTrans = trans * lastTrans;

end

disp(' ');
disp(['循环次数(接受的变换次数): ',num2str(cnt)]);

end

