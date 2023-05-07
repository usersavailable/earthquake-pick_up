% 读取2014年地震速度、位移、加速度数据的SAC文件
% 读取速度文件
maindir1 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel';
subdir1 = dir(maindir1);
subdirpath1 = fullfile(maindir1, subdir1(3).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
stru1 = dir(subdirpath1);
DATA1 = struct();
% 读取位移文件
maindir2 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-disp';
subdir2 = dir(maindir2);
subdirpath2 = fullfile(maindir2, subdir2(3).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
stru2 = dir(subdirpath2);
DATA2 = struct();
% 读取加速度文件
maindir3 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG - acc';
subdir3 = dir(maindir3);
subdirpath3 = fullfile(maindir3, subdir3(3).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
stru3 = dir(subdirpath3);
DATA3 = struct();
number = 0;
% 
% if ~strcmp(stru2.name, stru1.name)
%     error('位移文件与速度文件不匹配')
% end
% 
% if ~strcmp(stru3.name, stru1.name)
%     error('加速度文件与速度文件不匹配')
% end

for j = 1:length(stru1)

    % 对速度记录进行处理--------------------------------------------------
    data1 = struct();
    number = number+1;
    path1 = fullfile(stru1(j).folder, stru1(j).name);
    [t1, record1, hr1] = fget_sac(path1);
    station1 = hr.station.kstnm;
    station1 = strrep(station1,' ','');
    time1 = strcat(num2str(hr.event.nzyear),'年',num2str(hr.event.nzjday),'日');
    direction1 = hr.stations.kcmpnm;
    direction1 = strrep(direction1,' ','');
    data1.station = station1;
    data1.time = time1;
    data1.direction = direction1;


    % 通过文件位置判断是否宕机，前12个宕机，其余未宕机 5.6.20:30
    if j <= 12
        dangji = 1;
    else 
        dangji = 0;
    end
    data1.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30

    % 选取地震发生时段的时程
    index = period_cut_ver2_tidy(record1,300);
    % timehistory = cell(4,1);  % 5.6.17:13
    timehistory1 = cell(12,1);
    % for i =1:4 5.6.17:13
    for i =1:12
        if ~isequal(index(i,:),[0,0])
            timehistory1{i} = record1(index(i,1):index(i,2));
        else 
            timehistory1{i} = NaN;
        end
    end
    data1.timehistory = timehistory1;

    DATA1(j).data = data1;

    % 对位移记录进行处理--------------------------------------------------------
    data2 = struct();
    number = number+1;
    path2 = fullfile(stru2(j).folder, stru2(j).name);
    [t2, record2, hr2] = fget_sac(path2);
    if stru2(j).name == stru1(j).name
        station2 = station1;
        time2 = time1;
        direction2 = direction1;
        data2.station = station2;
        data2.time = time2;
        data2.direction = direction2;
        timehistory2 = cell(12,1);
        % 位移使用速度事件选取的索引来截出地震事件，保证位移与速度为同一时间下。
        for i =1:12
            if ~isequal(index(i,:),[0,0])
                timehistory2{i} = record2(index(i,1):index(i,2));
            else 
                timehistory2{i} = NaN;
            end
        end
        data2.timehistory = timehistory2;
        data2.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30
        DATA2(j).data = data2;
    else 
        error('位移文件与速度文件不匹配')
    end

    % 对加速度记录进行处理--------------------------------------------------------
    data3 = struct();
    number = number+1;
    path3 = fullfile(stru3(j).folder, stru3(j).name);
    [t3, record3, hr3] = fget_sac(path3);
    if stru3(j).name == stru1(j).name
        station3 = station1;
        time3 = time1;
        direction3 = direction1;
        data3.station = station3;
        data3.time = time3;
        data3.direction = direction3;
        timehistory3 = cell(12,1);
        % 加速度使用速度事件选取的索引来截出地震事件，保证加速度与速度为同一时间下。
        for i =1:12
            if ~isequal(index(i,:),[0,0])
                timehistory3{i} = record3(index(i,1):index(i,2));
            else 
                timehistory3{i} = NaN;
            end
        end
        data3.timehistory = timehistory3;
        data3.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30
        DATA3(j).data = data3;
    else 
        error('加速度文件与速度文件不匹配')
    end

end
%% 读取2014年SEED文件
% maindir = 'C:\Users\wty\三星地震数据';
% subdir = dir(maindir);
% number = 0;
% DATA = stru();
% for i = 1:7
%     data = stru();
%     if contains(subdir(i).name,'ZOZT')
%         station = 'ZOZT';
%     elseif contains(subdir(i).name,'LANT')
%         station = 'LANT';
%     elseif contains(subdir(i).name,'MEIX')
%         station = 'MEIX'; 
%     elseif contains(subdir(i).name,'XAN')
%         station = 'XAN';    
%     end
%     subdirpath = fullfile(maindir, subdir(i).name, '*.txt')
%     stru = dir(subdirpath);
%     for j = 1:length(stru)
%         if contains(stru(j).name,'BHE')
%             direction = 'BHE';
%         elseif contains(stru(j).name,'BHN')
%             direction = 'BHN';
%         elseif contains(stru(j).name,'BHZ')
%             direction = 'BHZ';
%         end
%         path = fullfile(maindir, subdirpath,stru(j).name)
%         data1 = textscan(path);
%         data.station = station;
%         data.direction = direction;
%         data.timehistory = data1;
%     end
% end
maindir = 'C:\Users\wty\三星地震数据';
subdir = dir(maindir);
number = 0;
DATA2 = struct();
subdirpath = fullfile(maindir,subdir(3).name,'*.txt');
station = '';

if contains(subdirpath,'LANT')
    station = 'LANT';
elseif contains(subdirpath,'XAN')
    station = 'XAN';
elseif contains(subdirpath,'ZOZT')
    station = 'ZOZT';
elseif contains(subdirpath,'MEIX')
    station = 'MEIX';
end

stru = dir(subdirpath);
for j = 1:length(stru)
    direction = '';
    if contains(stru(j).name,'BHE')
        direction = 'BHE';
    elseif contains(stru(j).name,'BHN')
        direction = 'BHN';
    elseif contains(stru(j).name,'BHZ')
        direction = 'BHZ';
    end
    data = struct();
    path = fullfile(maindir,subdir(3).name,stru(j).name);
    data1 = load(path);
    % data1 = data1./1248.6;
    data.timehistory = data1;
    data.direction = direction;
    data.station = station;
    DATA2(j).data = data;
end
%% 读取2014年SEED文件2
%% 读取2014年SEED文件2
maindir = 'C:\Users\wty\新三星地震数据';
subdir = dir(maindir);
number = 0;
DATA3 = struct();
subdirpath = fullfile(maindir,subdir(4).name,'*.txt');
station = '';

if contains(subdirpath,'LANT')
    station = 'LANT';
elseif contains(subdirpath,'XAN')
    station = 'XAN';
elseif contains(subdirpath,'ZOZT')
    station = 'ZOZT';
elseif contains(subdirpath,'MEIX')
    station = 'MEIX';
end

stru = dir(subdirpath);
for j = 1:length(stru)
    direction = '';
    if contains(stru(j).name,'BHE')
        direction = 'BHE';
    elseif contains(stru(j).name,'BHN')
        direction = 'BHN';
    elseif contains(stru(j).name,'BHZ')
        direction = 'BHZ';
    end
    data = struct();
    path = fullfile(maindir,subdir(3).name,stru(j).name);
    data1 = load(path);
    data1 = data1./1248.6;
    data.timehistory = data1;
    data.direction = direction;
    data.station = station;
    DATA3(j).data = data;
end
%%
%% 时程比较
data1 = DATA1(12).data.timehistory;
[~, max_index] = max(abs(data1));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data1)
    data1 = data1(idx_start:idx_end);
end
data2 = DATA3(1).data.timehistory;
[~, max_index] = max(abs(data2));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data2)
    data2 = data2(idx_start:idx_end);
end
figure
% plot(data1.*3e6,'r')
plot(data1,'r')
% hold on
% plot(data2,'b')
set(gca,'FontSize',20)
title('BHN of LANT')
legend('SAC文件','SEED文件')
%%
for i=1:length(DATA1)
    if contains(DATA1(i).data.station, 'LANT')
        figure
        data1 = DATA1(i).data.timehistory;
        % start_index = start(data1,e-7);
        % plot(data1(start_index:start_index+120000).*1e6)
        plot(data1.*1e6)
        direction = DATA1(i).data.direction;
        % max1 = max(DATA1(i).data.timehistory);
        title('Velocity %s of SAC',direction)
        set(gca,'FontSize',20);
        % print('max of %s station of %s direction is %f','LANT',direction,max1)
    end
end

for i=1:length(DATA2)
    if contains(DATA2(i).data.station, 'LANT')
        data2 = DATA2(i).data.timehistory;
        % start_index2 = start(data2,0.1);
        figure
        % plot(data2(start_index:start_index+120000))
        plot(data2)
        direction = DATA2(i).data.direction;
        % max2 = max(DATA2(i).data.timehistory);
        title('Velocity %s of SAC',direction)
        % print('max of %s station of %s direction is %f','LANT',direction,max2)
        set(gca,'FontSize',20);
    end
end

%%
data1 = DATA1(1).data.timehistory;
m1 = max(data1);
%%
data = DATA1(12).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data1 = data(idx_start:idx_end);
end
figure
plot(data1,'r')
set(gca,'FontSize',20)
title('BHE of LANT')
legend('SAC文件')
%% 时程比较
data = DATA1(1).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data1 = data(idx_start:idx_end);
end
data = DATA2(2).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data2 = data(idx_start:idx_end);
end
figure
% plot(data1.*1e6,'r')
plot(data1.*1e9,'r')
hold on
plot(data2,'b')
set(gca,'FontSize',20)
title('BHN of LANT')
legend('SAC文件','SEED文件')
%% 时程比较
data = DATA1(8).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data1 = data(idx_start:idx_end);
end
data = DATA2(1).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data2 = data(idx_start:idx_end);
end
figure
plot(data1.*1e6,'r')
hold on
plot(data2,'b')
set(gca,'FontSize',20)
title('BHE of LANT')
legend('SAC文件','SEED文件')

%% 时程比较
data = DATA1(9).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data1 = data(idx_start:idx_end);
end
data = DATA2(3).data.timehistory;
[~, max_index] = max(abs(data));
idx_start = max_index - 20000;
idx_end = idx_start + 120000 - 1;
if idx_start > 0 && idx_end <= length(data)
    data2 = data(idx_start:idx_end);
end
figure
plot(data1.*1e6,'r')
hold on
plot(data2,'b')
set(gca,'FontSize',20)
title('BHZ of LANT')
legend('SAC文件','SEED文件')
%% 时程比较

%% PGV_N比较
figure
plot(sorted_PGVN.*1e6,'r','LineWidth',2);
hold on
plot(sorted_PGV_N,'b','LineWidth',2);
legend('SAC文件','SEED文件')
set(gca,'FontSize',20)
title('升序排序后的PGV_N')
%% PGV_Z比较
figure
plot(sorted_PGVZ.*1e6,'r','LineWidth',2);
hold on
plot(sorted_PGV_Z,'b','LineWidth',2);
legend('SAC文件','SEED文件')
set(gca,'FontSize',20)
title('升序排序后的PGV_Z')
%% 选取时段并绘图查看
index = period_cut(DATA1(1).data.timehistory,2,2000);
figure
plot(DATA1(1).data.timehistory(index(1,1):index(1,2)))
%% 筛选需要的台站及速度方向
for i =1:length(DATA1)
    if strcmp(DATA1(i).data.station , 'LANT') && strcmp(DATA1(i).data.direction ,'BHE')
        disp(i);
    end
end