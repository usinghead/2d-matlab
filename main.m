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

conf_max = 10;
conf_min = -10;
conf_occ = 2.1972;
conf_free = -1.3863;

occ = 2;
free = -2;

grid = 0.04;
mapRange = [30, 30];
initPosition = mapRange/2;
mapRangeGrid = mapRange/grid;
filterThr = 0.15;

Xmin = mapRangeGrid(1);
Ymin = mapRangeGrid(2);
Xmax = 0;
Ymax = 0;

ICP_Threshold1 = 0.00075;         %迭代终止条件：误差
ICP_Threshold2 = 0.4;       %匹配点所占比例
ICP_Threshold3 = 30;        %匹配点个数
ICP_Threshold4 = 0.3;       %
PLThr = 0.0035;

map = zeros(mapRangeGrid,'single');
pose = [initPosition, 0];
edge = round(0.2/grid);

laserLenSet = importdata('100revo.csv');
index = false(503, 360);
laserPoinSet = zeros(503, 360, 2);
[lpSet, index(1, :), this] = getPoints(pose, laserLenSet(1, :));
laserPoinSet(1, index(1,:), :) = reshape(lpSet, 1, [], 2);
%data=data_filter(data);

figure('name','slam');
a=1;

while(1)
    %for i = 2:200
    if waitforbuttonpress
        a = a+1;
        pre = this;
        [lpSet, index(a, :), this] = getPoints(pose(a-1,:), laserLenSet(a,:));
        %this是经过栅格过滤的点，用于进行icp和图像中点的显示；lpSet是未经栅格过滤的点，用于更新地图
        
        [trans, theta, corrSet] = icp( this, pre );
        
        lpSet = transform(lpSet, trans);
        this = transform(this, trans);
        laserPoinSet(a, index(a,:), :) = reshape(lpSet, 1, [], 2);
        pose(a, 1:2) = transform(pose(a-1,1:2), trans);
        pose(a, 3) = pose(a-1, 3) + theta;
        updateMap(pose(a,1:2), lpSet);
        if mod(a, 3) == 0
            removeIsolatedPoints();
        end
        
        m1 = map >= occ;
        m2 = map <= free;
        m3 = (map < occ) & (map > free);
        
        
        hold on;
        mapStatus = zeros(cat(2,mapRangeGrid,3), 'uint8');
        mapStatus(:,:,1) = 107 * m1 + 46  * m2 + 22 *  m3;
        mapStatus(:,:,2) = 191 * m1 + 130 * m2 + 99 *  m3;
        mapStatus(:,:,3) = 255 * m1 + 204 * m2 + 173 * m3;
        imshow(mapStatus);
        preShow=ceil(pre/grid);     %从这开始是点的显示部分
        thisShow=ceil(this/grid);
        hold on;
        plot(preShow(:,1), preShow(:,2),'w.','markersize',15);
        plot(thisShow(:,1), thisShow(:,2),'g.','markersize',15);
        corrSet = ceil(corrSet/grid);               %从这里开始是线的显示部分
        if size(corrSet,2) == 4
            plot([corrSet(:,1),corrSet(:,3)]',[corrSet(:,2),corrSet(:,4)]','k','LineWidth',1);
        else
            plot([corrSet(:,1),corrSet(:,3)]', [corrSet(:,2),corrSet(:,4)]','g','LineWidth',1);
            plot([corrSet(:,1),corrSet(:,5)]', [corrSet(:,2),corrSet(:,6)]','y','LineWidth',1);
        end
        track = pose(:, 1:2);
        plotLines(track);
        axis([Xmin-edge Xmax+edge Ymin-edge Ymax+edge]);     %图像的显示范围
        % set(gcf,'unit','centimeters','position',[3,3,24,16]);      %窗口的显示范围为左下3：3厘米到右上24：16厘米
        text(Xmin-edge,Ymin-edge+10,num2str(Xmin));
        text(Xmin-edge+30,Ymin-edge+10,num2str(Ymin));
        text(Xmin-edge+60,Ymin-edge+10,num2str(Xmax));
        text(Xmin-edge+90,Ymin-edge+10,num2str(Ymax));
        text(Xmin-edge+120,Ymin-edge+10,['本次添加的是第 ',num2str(a),' 帧']);
        disp(trans);
        disp(['旋转角度：',num2str(theta)]);
        disp(['第 ',num2str(a),' 帧添加完毕']);
        disp(' ');
        pause(0.01);
    end
    %waitforbuttonpress;
end