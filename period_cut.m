function [index] = period_cut(data,time,step1,step2)
%PERIOD_CUT 节选出响应大于step nm/s且持续时长在time秒以上的速度时段
%开始时间：速度大于step；结束时间，持续time秒速度大于1e-9
%   index为包含事件开始时刻与事件结束时刻的矩阵，每一行两个元素
%   [index_start,index_end]代表一次地震事件的开始和结束时间
%   最多节选4次事件，否则报错
%   并不会，matlab会自动添加行，不存在索引问题

index = zeros(4,2);
new_i = 1;
i = 1;
k = 1;  % 记录地震事件次数
window = time.*100;
window = window(1);

while i<length(data)-(window-1)
    index_start = 0;  % 初始化
    index_end = 0;  % 初始化
    for j =new_i:length(data)-(window-1)
    %     start_flag = 1;
    %     for j =1:window  % 判断100个点的响应值
    %         if data(i+j-1)<step*1e-9
    %             start_flag = 0;
    %         end
    %     end
    %     if start_flag == 1
    %         index_start = i;
    %         break
    %     end
        if data(j) > step1
            index_start = j-300;
        end
    end

    
    if index_start ~=0
        for j = index_start:length(data)-(window-1)
            end_flag = 1;
            for l = 1:window
                if data(j+l-1)<step2
                    end_flag = 0;
                end
            end
            if end_flag == 1
                index_end = j;
                break
            end
        end


        % if k<5
        %     index(k,:) = [index_start,index_end];
        %     new_i = index_end;
        % else 
        %     disp('事件次数过多！')
        %     return
        % end

        try
            index(k,:) = [index_start,index_end];
            new_i = index_end;
        catch 
            error('事件次数过多！')  % 根本不会触发此警告
        end


        k = k+1;
    end
    i = index_end+1;
end
   

end

