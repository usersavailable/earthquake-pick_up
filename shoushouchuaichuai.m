%%
data21 = DATA1(21).data.timehistory;
index21 = period_cut_ver2_tidy(data21,300);
fig = figure;
plot(data21(index21(1,1):index21(1,2)))
title(DATA1(21).data.station,DATA1(21).data.direction);
saveas(fig, 'pictures/figure21.png')
%%
mkdir('pictures_of_folder1');
Mydata = cell(1, length(DATA1));
for i = 1:length(DATA1)
    datax = DATA1(i).data.timehistory;
    indexx = period_cut_ver2_tidy(datax,300);
    result = cell(1, size(indexx, 1)); % 创建一个空的cell数组来存储结果
    for j = 1:size(indexx, 1)
        start_idx = index(j, 1);
        end_idx = index(j, 2);
        if ~isequal([start_index,end_index],[0,0]) % 如果结束索引不为0
            result{j} = datax(start_idx:end_idx);
        end
    end
    % cell 数组到 mat 文件中
    num = i;
    matname = ['Timehistory of folder' num2str(num) '.mat'];
    save(result,matname);

    fig = figure;
    subplot(1,3,1)
    plot(datax(indexx(1,1):indexx(1,2)))
    subplot(1,3,2)
    plot(datax(indexx(2,1):indexx(2,2)))
    subplot(1,3,3)
    plot(datax(indexx(3,1):indexx(3,2)))
    num = i;
    filename = ['pictures_of_folder1/figure' num2str(num) '.png'];
    set(fig, 'Visible', 'off') % 将图形窗口设置为不可见
    saveas(fig, filename) % 保存图像
end
%% 图像保存β

%%
A = [2,4,6;8,10,12;14,16,18];
B = [1,3;4,5;0,0];
result = cell(1, size(B, 1)); % 创建一个空的cell数组来存储结果

for i = 1:size(B, 1)
    start_idx = B(i, 1);
    end_idx = B(i, 2);
    if end_idx > 0 % 如果结束索引不为0
        result{i} = A(start_idx:end_idx);
    end
end

%%
% 读取不宕机地震数据的SAC文件
maindir = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_none';

subdir = dir(maindir);
for k = 1:length(subdir)-2
    subdirpath = fullfile(maindir, subdir(k+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
    stru = dir(subdirpath);
    number = 0;
    eval(['DATA', num2str(k), '= struct();']); % 使用eval和字符串拼接动态生成变量名
    for j = 1:length(stru)
        data = struct();
        number = number+1;
        path = fullfile(stru(j).folder, stru(j).name);
        %try
        [t, data1, hr] = fget_sac(path);
        % data1 = period_cut(data1,1,1e-4);
        station = hr.station.kstnm;
        station = strrep(station,' ','');
        % time = datenum(hr.event.nzyear, (hr.event.nzjday-mod(hr.event.nzjday,30))./30, mod(hr.event.nzjday,30), hr.event.nzhour, hr.event.nzmin, hr.event.nzsec);
        % time = datenum(hr.event.nzyear, (hr.event.nzjday-mod(hr.event.nzjday,30))./30, mod(hr.event.nzjday,30));
        time = strcat(hr.event.nzyear,'年',hr.event.nzjday,'日');
        direction = hr.stations.kcmpnm;
        direction = strrep(direction,' ','');
    
        % 选取地震发生时段的时程
        index = period_cut_ver2_tidy(data1,300);
        timehistory = cell(4,1);
        for i =1:4
            if ~isequal(index(i,:),[0,0])
                timehistory{i} = data1(index(i,1):index(i,2));
            else 
                timehistory{i} = NaN;
            end
        end
        
        data.station = station;
        data.time = time;
        data.direction = direction;
        data.timehistory = timehistory;
        % catch ME
        %     disp(['Error reading file ', path, ': ', ME.message]);
        %     continue;
        %end
        eval(['DATA', num2str(k), '(j).data= data;']);
    end
end
%% 读取地震数据的SAC文件β
maindir1 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel';  % 读取速度文件
maindir2 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-disp';  % 读取位移文件
maindir3 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG - acc';  % 读取加速度文件

subdir = dir(maindir1);
for k = 1:length(subdir)-2  %5.6.17:13
    subdirpath = fullfile(maindir1, subdir(k+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
    stru = dir(subdirpath);
    number = 0;
    eval(['DATA', num2str(k), '= struct();']); % 使用eval和字符串拼接动态生成变量名
    for j = 1:length(stru)
        data = struct();
        number = number+1;
        path = fullfile(stru(j).folder, stru(j).name);
        %try
        [t, data1, hr] = fget_sac(path);
        % data1 = period_cut(data1,1,1e-4);
        station = hr.station.kstnm;
        station = strrep(station,' ','');
        % time = datenum(hr.event.nzyear, (hr.event.nzjday-mod(hr.event.nzjday,30))./30, mod(hr.event.nzjday,30), hr.event.nzhour, hr.event.nzmin, hr.event.nzsec);
        % time = datenum(hr.event.nzyear, (hr.event.nzjday-mod(hr.event.nzjday,30))./30, mod(hr.event.nzjday,30));
        time = strcat(hr.event.nzyear,'年',hr.event.nzjday,'日');
        direction = hr.stations.kcmpnm;
        direction = strrep(direction,' ','');
        % 通过文件位置判断是否宕机，前12个宕机，其余未宕机 5.6.20:30
        if j <= 12
            dangji = 1;
        else 
            dangji = 0;
        end

        % 选取地震发生时段的时程
        index = period_cut_ver2_tidy(data1,300);
        % timehistory = cell(4,1);  % 5.6.17:13
        timehistory = cell(12,1);
        % for i =1:4 5.6.17:13
        for i =1:12
            if ~isequal(index(i,:),[0,0])
                timehistory{i} = data1(index(i,1):index(i,2));
            else 
                timehistory{i} = NaN;
            end
        end
        
        data.station = station;
        data.time = time;
        data.direction = direction;
        data.timehistory = timehistory;
        data.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30
        % catch ME
        %     disp(['Error reading file ', path, ': ', ME.message]);
        %     continue;
        %end
        eval(['DATA', num2str(k), '(j).data= data;']);
    end
end


%% 读取地震数据的SAC文件β2.0
maindir = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel';
subdir = dir(maindir);
for k = 1:length(subdir)-2
    subdirpath = fullfile(maindir, subdir(k+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
    stru = dir(subdirpath);
    number = 0;
    eval(['DATA', num2str(k), '= struct();']); % 使用eval和字符串拼接动态生成变量名
    for j = 1:length(stru)
        data = struct();
        number = number+1;
        path = fullfile(stru(j).folder, stru(j).name);
        %try
        [t, data1, hr] = fget_sac(path);
        % data1 = period_cut(data1,1,1e-4);
        station = hr.station.kstnm;
        station = strrep(station,' ','');
        % time = datenum(hr.event.nzyear, (hr.event.nzjday-mod(hr.event.nzjday,30))./30, mod(hr.event.nzjday,30), hr.event.nzhour, hr.event.nzmin, hr.event.nzsec);
        % time = datenum(hr.event.nzyear, (hr.event.nzjday-mod(hr.event.nzjday,30))./30, mod(hr.event.nzjday,30));
        time = strcat(hr.event.nzyear,'年',hr.event.nzjday,'日');
        direction = hr.stations.kcmpnm;
        direction = strrep(direction,' ','');
    
        % 选取地震发生时段的时程
        index = period_cut_ver2_tidy(data1,300);
        timehistory = cell(4,1);
        for i =1:4
            if ~isequal(index(i,:),[0,0])
                timehistory{i} = data1(index(i,1):index(i,2));
            else 
                timehistory{i} = NaN;
            end
        end
        
        data.station = station;
        data.time = time;
        data.direction = direction;
        data.timehistory = timehistory;
        % catch ME
        %     disp(['Error reading file ', path, ': ', ME.message]);
        %     continue;
        %end
        eval(['DATA', num2str(k), '(j).data= data;']);
    end
end

%%

save('Velocity_periodcutting2.mat',"DATA1","DATA2","DATA3","DATA4","DATA5","DATA6","DATA7","DATA8","DATA9","DATA10","DATA11","DATA12","DATA13","DATA14","DATA15");
%% 滤波处理尝试
% 读入数据，假设数据为x，采样频率为fs
% load('data.mat');
% x = DATA6(19).data.timehistory;
x = data1;

% 设计滤波器
fc = 0.1; % 截止频率
fs = 100; % 采样频率
[b,a] = butter(4,fc/(fs/2),'low'); % 4阶巴特沃斯低通滤波器

% 进行滤波
y = filtfilt(b,a,x); % filtfilt函数是双向滤波函数，可以避免相位变化

% 绘制滤波前后的波形图
figure
t = (0:length(x)-1)/fs;
subplot(2,1,1);
plot(t,x);
title('原始数据');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2);
plot(t,y);
title('滤波后数据');
xlabel('Time (s)');
ylabel('Amplitude');
