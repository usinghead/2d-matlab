function [ lastTrans, theta, corrSet ] = icp( tar, ref )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global ICP_Threshold1 ICP_Threshold2 ICP_Threshold3 ICP_Threshold4;
global pointThreshold;

pointThreshold = 0.3 * 0.3; %ÿ��icp��ʼʱ����Ϊ�����
tarMean = mean(tar, 1);

% tic;
lastTrans = [1 0 0;0 1 0;0 0 1];
error = 1000000;
last_error = 2000000;
cnt = 0; %��������

while cnt < 25  && error > ICP_Threshold1   % && abs(last_error - error) > 0.01
    cnt = cnt + 1;
    last_error = error;
    
    [trans, R, T, error, tarNum, ratio, corrSet] = icpProcess(ref, tar);
    
    if error > last_error %|| row/InitialRow < 0.5
        inCnt = 0;
        loop = 5;
        err = [];
        
        for i = 1:loop
            [trans, R, T, error, tarNum, ratio, corrSet] = icpProcess(ref, tar);
            if ratio > 0.2
                inCnt = inCnt + 1;
                err(inCnt) = error;
                rat(inCnt) = ratio;
                tarnum(inCnt) = tarNum;
                cor{inCnt} = corrSet;
                RSet{inCnt} = R;
                TSet{inCnt} = T;
                tranSet{inCnt} = trans;
            end
        end
        if inCnt > 0
            [minError, minIndex] = min(err);
            error = minError;
            ratio = rat(minIndex);
            tarNum = tarnum(inCnt);
            corrSet = cor{minIndex};
            R = RSet{minIndex};
            T = TSet{minIndex};
            trans = tranSet{minIndex};
        end
    end
    if error > 0.0008
        pointThreshold = 4 * error;
    end
    tar = transform(tar, trans);      %���ݵõ���R T ��Ŀ��㼯��תƽ��
    lastTrans =  trans * lastTrans;
end

% toc; %��ʱ����

corrSet(:, 3:4) = transform(corrSet(:,3:4), trans);

theta = atan2(lastTrans(2,1),lastTrans(1,1));
tarFinalMean = mean(tar, 1);
delta = sum((tarMean - tarFinalMean).^2);

disp(['ƥ�����: ',num2str(tarNum)]);
disp(['ѭ������: ',num2str(cnt)]);
disp(['����С: ',num2str(error)]);

flag = 1;
if error > ICP_Threshold1 
    flag = 0;
    disp(['ICP������: ',num2str(error)]);
end
if ratio < ICP_Threshold2
    flag = 0;
    disp(['���ռ�ȹ���: ',num2str(ratio)]);
end
if tarNum < ICP_Threshold3 
    flag = 0;
    disp(['ƥ���̫��: ',num2str(tarNum)]);
end
if delta > ICP_Threshold4 
    flag = 0;
    disp(['delta����: ',num2str(delta)]);
end
    
   
end

