close all;
clear ;
clc;
pause(0.1);
close all;

global grid mapRange initPosition;
global map mapRangeGrid;
global filterThr;
global ICP_Threshold1 ICP_Threshold2 ICP_Threshold3 ICP_Threshold4;
global Xmin Ymin Xmax Ymax;
global conf_max conf_min conf_occ conf_free;
global occ free;

conf_max = 20;
conf_min = -20;
conf_occ = 2.1972;
conf_free = -1.3863;

occ = 3;
free = -1;

grid = 0.04;
mapRange = [20, 20];
initPosition = mapRange/2;
mapRangeGrid = mapRange/grid;
filterThr = 0.15;

Xmin = mapRangeGrid(1);
Ymin = mapRangeGrid(2);
Xmax = 0;
Ymax = 0;

ICP_Threshold1 = 0.005;         %迭代终止条件：误差
ICP_Threshold2 = 0.4;       %匹配点所占比例
ICP_Threshold3 = 30;        %匹配点个数
ICP_Threshold4 = 0.3;       %

map = zeros(mapRangeGrid,'single');
pose = [initPosition, 0];
edge = round(0.2/grid);

row = 26;

laserLenSet = importdata('100revo.csv');
[~, ~, ref] = getPoints(pose, laserLenSet(row-1, :));
[~, ~, tar] = getPoints(pose, laserLenSet(row, :));
%data=data_filter(data);

figure('name','icptest');
a = 0;

global pointThreshold;

pointThreshold = 0.3 * 0.3; %每次icp开始时被置为这个数

lastTrans = [1 0 0;0 1 0;0 0 1];

last_error = 100;

while(1)
    preShow = ceil(ref/grid);
    thisShow = ceil(tar/grid);
    hold on;
    plot(preShow(:,1), preShow(:,2),'g.','markersize',7);
    plot(thisShow(:,1), thisShow(:,2),'r.','markersize',7);
    hold off;
    if waitforbuttonpress
        a = a + 1;
        
        [trans, R, T, error, tarNum, ratio, corrSet] = icpProcess(ref, tar);
        
        inCnt = 0;
        if error > last_error %|| row/InitialRow < 0.5
            loop = 5;
            err = [];
        
            for i = 1:loop
                [trans, R, T, error, tarNum, ratio, corrSet] = icpProcess(ref, tar);
                if ratio > 0.2
                    inCnt = inCnt + 1;
                    err(inCnt) = error;
                    tarnum(inCnt) = tarNum;
                    cor{inCnt} = corrSet;
                    tranSet{inCnt} = trans;
                end
            end
            if inCnt > 0
                [minError, minIndex] = min(err);
                error = minError;
                tarNum = tarnum(minIndex);
                corrSet = cor{minIndex};
                trans = tranSet{minIndex};
            end
        end
        last_error = error;
        if error > 0.0008
            pointThreshold = 4 * error;
        end
        tar = transform(tar, trans);      %根据得到的R T 对目标点集旋转平移
        lastTrans = trans * lastTrans;
        corrSet(:, 3:4) = transform(corrSet(:,3:4), trans);
        corrSet = ceil(corrSet/grid);
        plot([corrSet(:,1),corrSet(:,3)]',[corrSet(:,2),corrSet(:,4)]','k','LineWidth',1); 
        disp(['这是第 ',num2str(a),' 次按键，变换前的误差量大小为',num2str(error)]);
        disp(['执行参数为 ',num2str(inCnt),'，本次匹配点数为 ',num2str(tarNum)]);
    end
end





















