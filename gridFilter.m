function [ outSet ] = gridFilter( pointSet )
%GRIDFILTER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

minX = min(pointSet(:,1));
minY = min(pointSet(:,2));
maxX = max(pointSet(:,1));
maxY = max(pointSet(:,2));

gridSize = 0.04;
W = floor((maxX - minX) / gridSize) + 1;
H = floor((maxY - minY) / gridSize) + 1;

voxel = cell(W,H);
for i=1:size(pointSet,1)
    I = floor((pointSet(i,1)-minX)/gridSize)+1;
    J = floor((pointSet(i,2)-minY)/gridSize)+1;
    voxel{I,J} = [voxel{I,J};pointSet(i,:)];
end

outSet = [];
for i=1:W
    for j=1:H
        if ~isempty(voxel{i,j})
            outSet = [outSet;mean(voxel{i,j},1)];
        end
    end
end

disp(['���˺�ĵ���Ϊ��',num2str(size(outSet,1))]);

end

