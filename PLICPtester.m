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
global PLThr;

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

ICP_Threshold1 = 0.0008;         %迭代终止条件：误差
ICP_Threshold2 = 0.4;       %匹配点所占比例
ICP_Threshold3 = 30;        %匹配点个数
ICP_Threshold4 = 0.3;       %
PLThr = 0.01;

map = zeros(mapRangeGrid,'single');
pose = [initPosition, 0];
edge = round(0.2/grid);

row = 10;

laserLenSet = importdata('100revo.csv');
index = false(2, 360);
laserPoinSet = zeros(2, 360, 2);
[laserPoinSet(1, :, :),index(1, :)] = getPoints(pose, laserLenSet(row, :));
[laserPoinSet(2, :, :),index(2, :)] = getPoints(pose, laserLenSet(row+1, :));
%data=data_filter(data);

figure('name','icptest');
cnt = 0;

pre = reshape(laserPoinSet(1, :, :), 360, 2);
this = reshape(laserPoinSet(2, :, :), 360, 2);

ref = pre(index(1,:),:);
tar = this(index(2,:),:);

lastTrans = [1 0 0;0 1 0;0 0 1];

last_error = 100;

while(1)
    preShow = ceil(ref/grid);
    thisShow = ceil(tar/grid);
    plot(preShow(:,1), preShow(:,2),'g.','markersize',7);
    hold on;
    plot(thisShow(:,1), thisShow(:,2),'r.','markersize',7);
    [corr, error, corrSet] = findTwoPoints(ref, tar);
    corrSet = ceil(corrSet/grid);
    plot([corrSet(:,1),corrSet(:,3)]', [corrSet(:,2),corrSet(:,4)]','b','LineWidth',1);
    plot([corrSet(:,1),corrSet(:,5)]', [corrSet(:,2),corrSet(:,6)]','y','LineWidth',1);
    hold off;
    if waitforbuttonpress
        cnt = cnt + 1;
        res = gpc(corr);
        trans = [rotMatrix(res(3)), [res(1);res(2)]; 0,0,1];
        tar = transform(tar, trans);
        corrSet(:, 1:2) = transform(corrSet(:,1:2), trans);
        lastTrans = trans * lastTrans;
        disp(' ');
        disp(['这是第 ',num2str(cnt),' 次按键']);
    end
end








