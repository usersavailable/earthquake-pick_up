function [index] = period_cut_ver2_tidy(data,time)

% index = zeros(4,2); % 5.6.17:13
index = zeros(12,2);
new_i = 1;
r = 1;
k = 1;  % 记录地震事件次数
window = time.*100;
window = window(1);
% 计算触发阈值和结束阈值
m = max(data);
% step1 = m/25; % 5.6.17:32
step1 = m/20;
step2 = m/50;

while r<length(data)-(window-1)  % 判断循环是否已经进行到事件结束
    fprintf('The %d st turn of searching starting at %d......\n',k,r);
    index_start = 0;  % 初始化
    index_end = 0;  % 初始化
    fprintf('Now the detector starts at %d\n',new_i);
    for n =r:length(data)-(window-1)
        if data(n) > step1
            % index_start = n-200*100;  % 事件开始时间为第一次达到触发阈值的时间倒推200s
            index_start = n-300*100;  % 事件开始时间为第一次达到触发阈值的时间倒推300s % 2023.5.7.22:56
            fprintf('The %d st event is detected, for the timehistory is bigger than %f | Its starting index is %d\n',k,step1, index_start);
            
            break
        end

    end
    % r = j;  % 将此时循环变量的值保存在r中
    % fprintf('The starting detector has gone to %d\n',j);


    mark = 0;  % 跳出循环标记

    if index_start ~=0
        fprintf('The %d st event starts at %d\n',k,index_start);
        for j = index_start:length(data)-(window-1)
            end_flag = 1;
            for l = 1:window
                if j + l - 1 >= length(data)  % 超出数据范围，认为事件结束
                    index_end = j + l - 1;
                    fprintf('The %d st event ends, for it has got to the tail. | Its ending index is %d.\n',k,index_end);
                    mark = 1;
                    break;
                elseif data(j + l - 1) > step2  % 事件结束时间为数据小于结束阈值window秒
                    end_flag = 0;
                    break
                end
            end
            if end_flag == 1
                index_end = j;
                fprintf('The lasting %f s of data is all under %f, the event ends at %d.',length(index_end-index_start)/100,step2,index_end);
            end
                    % if l >= 2 && (j + l - 2 - index_start) >= time * 100  % 判断是否持续了time秒
                    %     index_end = j + l - 2;
                    %     fprintf('The %d event ends, for the timehistory is no bigger than %f for %d s. | Its ending index is %d.\n',k,step2,time,index_end);
                    %     mark = 1;
                    % 
                    %     break;
                    % elseif j + l - 1 - index_start > 200000  % 200000个数据点(2000秒)都没有结束事件，认为事件结束
                    %     index_end = j + l - 2;
                    %     fprintf('The %d event ends, for it lasts too long for 2000s. | Its ending index is %d.\n',k,index_end);
                    %     mark = 1;
                    % 
                    %     break;
                    % else
                    %     end_flag = 0;
                    % end

            if end_flag == 1
                index_end = j;
                break
            end

            if mod(j,1000000)==0
                fprintf('The ending detector has gone to %d\n',j)
            end

            if mark == 1
                break
            end
        
        end

        if index_end ~= 0
            fprintf('The %d st event ends at %d\n',k,index_end);
        end

        if index_end < index_start
            error('识别有误！结束时间早于开始时间！可能是回推时间过长或者开始阈值过小或者结束阈值过大，请检查参数设置！')
        end

        % if k >=5  % 5.6.17:13
        if k >= 13
            error('事件次数过多！')
        end
        
        % 如果事件回退时间内事件发生过晚，为避免误判将事件定义为
        if index_end - index_start < 60000
            index_end = index_start +60000;
        end

        index(k,:) = [index_start,index_end];
        new_i = index_end;
        
        k = k+1;
    end
    
    if index_start ~= 0
        r = index_end+1;
    elseif index_start == 0
        r = n;
    end

    

end

if k ==1
    error('没有找到任何事件！');
end

fprintf('共找到%d次事件，其起始时间与终止时间为：\n',k-1)
a = index ~= 0;
disp(index(a));
end

