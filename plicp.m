function [ lastTrans, theta, set ] = plicp( tar, ref )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

global PLThr;

lastTrans = [1 0 0;0 1 0;0 0 1];
theta = 0;
cnt = 0; %��������
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
disp(['ѭ������(���ܵı任����): ',num2str(cnt)]);

end

