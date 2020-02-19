function [ corr, meanError, set ] = findTwoPoints( ref, tar )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

r = size(ref,1);
t = size(tar,1);
error = 0;
cnt = 0;
set = [0,0,0,0,0,0];
corr = {};
for i = 1:t
    xDis = ref(:, 1) - tar(i, 1);
    yDis = ref(:, 2) - tar(i, 2);
    dis = xDis.^2 + yDis.^2;
    [minDis, minIndex] = min(dis);
    dis(minIndex) = [];
    [secDis, secIndex] = min(dis);
    if secIndex >= minIndex
        secIndex = secIndex + 1;
    end
    minRef = ref(minIndex, :);
    secRef = ref(secIndex, :);
    if secDis > 0.04
        continue;
    end
    if cnt > 0
        % h = pointToHigh( minRef, secRef, tar(i,:));
        if secDis > 4*thr
            continue;
        end
    end
    error = error + (minDis+secDis)/2;
    cnt = cnt + 1;
    thr = error/cnt;
    set(cnt, :) = [tar(i,:), minRef, secRef];
    nor = [minRef(2) - secRef(2); secRef(1) - minRef(1)];
    corr{cnt}.p = tar(i,:)';
    corr{cnt}.q = minRef';
    corr{cnt}.C = nor*nor' / (nor(1)^2+nor(2)^2);
end
meanError = error / cnt;
disp(['ƥ�������',num2str(cnt)]);
disp(['ƥ���ռ�ȣ�',num2str(cnt/t)]);
disp(['����С: ',num2str(meanError)]);

end








