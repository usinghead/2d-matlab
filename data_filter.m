function [ date ] = data_filter( date )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global filterThr;
    
for i=1:503
    for j=2:360
        cnt=1;
        if data(i,j)-data(i,j-1)<data(i,j-1)*filterThr
            cnt=cnt+1;
        else
            if cnt<=4
                data(i,j-cnt:j-1)=0;
            end
            cnt=1;
        end
    end
end



end

