function [ ] = plotLines( set )
%UNTITLED13 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

global grid;

set = ceil(set/grid);
sets = set(1:2:end,:);
sets1 = sets(1:end-1,:);
sets2 = sets(2:end,:);

plot([sets1(:,1) sets2(:,1)],[sets1(:,2) sets2(:,2)],'y','LineWidth',1);
plot(sets(end,1),sets(end,2),'ro','markersize',5);

end

