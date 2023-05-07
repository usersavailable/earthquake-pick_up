function [index] = period_cut_ver2(data,time)
%PERIOD_CUT 节选出地震事件时段
%开始时间：速度大于step1；结束时间，持续time秒速度大于step2
%   index为包含事件开始时刻与事件结束时刻的矩阵，每一行两个元素
%   [index_start,index_end]代表一次地震事件的开始和结束时间
%   最多节选4次事件，否则报错
%   并不会，matlab会自动添加行，不存在索引问题

index = zeros(4,2);
new_i = 1;
r = 1;
k = 1;  % 记录地震事件次数
window = time.*100;
window = window(1);
% 计算触发阈值和结束阈值
m = max(data);
step1 = 7.9968e-05;
step2 = m/50;

while r<length(data)-(window-1)  % 判断循环是否已经进行到事件结束
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
            index_start = j-200*100;  % 事件开始时间为第一次达到触发阈值的时间倒推200s
        end
    end

    
    if index_start ~=0
        for j = index_start:length(data)-(window-1)
            end_flag = 1;
            for l = 1:window
                if j + l - 1 >= length(data)  % 超出数据范围，认为事件结束
                    index_end = j + l - 2;
                    break;
                elseif data(j + l - 1) < step2  % 事件结束时间为数据小于结束阈值window秒
                    if l >= 2 && (j + l - 2 - index_start) >= time * 100  % 判断是否持续了time秒
                        index_end = j + l - 2;
                        break;
                    elseif j + l - 1 - index_start > 200000  % 200000个数据点(2000秒)都没有结束事件，认为事件结束
                        index_end = j + l - 2;
                        break;
                    else
                        end_flag = 0;
                    end
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
        if k >=5
            error('事件次数过多！')
        end

        index(k,:) = [index_start,index_end];
        new_i = index_end;

        % try
        %     index(k,:) = [index_start,index_end];
        %     new_i = index_end;
        % catch 
        %     error('事件次数过多！')  % 根本不会触发此警告
        % end


        k = k+1;
    end
    % i = index_end+1;
    r = j;  % 将此时循环变量的值保存在r中

end

if k ==1
    error('没有找到任何事件！');
end

end

