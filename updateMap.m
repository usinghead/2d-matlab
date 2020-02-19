function [  ] = updateMap( pose, set )
%UNTITLED10 此处显示有关此函数的摘要
%   此处显示详细说明
global map grid;
global Xmin Ymin Xmax Ymax;
global conf_max conf_min conf_occ conf_free;

set = ceil(set/grid);
pose = ceil(pose/grid);
for i = 1:size(set, 1)
    gridGot = bresenham(pose(1), pose(2), set(i,1), set(i,2));
    row = size(gridGot, 1);
    if set(i,1) < Xmin
        Xmin = set(i,1);
    end
    if set(i,1) > Xmax
        Xmax = set(i,1);
    end
    if set(i,2) < Ymin
        Ymin = set(i,2);
    end
    if set(i,2) > Ymax
        Ymax = set(i,2);
    end
    if map(set(i,2),set(i,1)) < conf_max 
        map(set(i,2),set(i,1)) = ...
        map(set(i,2),set(i,1)) + conf_occ;
    end

    for m = 1:row - 1
        if map(gridGot(m,2),gridGot(m,1)) > conf_min
            map(gridGot(m,2),gridGot(m,1)) = ...
            map(gridGot(m,2),gridGot(m,1)) + conf_free;
        end
    end    
end


end

