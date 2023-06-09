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

%%


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
        timehistory = cell(12,1);
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
%% 加速度、速度、位移共同剪切

maindir1 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel';
maindir2 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-disp';
maindir3 = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG - acc';
subdir1 = dir(maindir1);
subdir2 = dir(maindir2);
subdir3 = dir(maindir3);
DATA_VEL = repmat(struct(), 1, length(subdir1)-2);
DATA_DISP = repmat(struct(), 1, length(subdir2)-2);
DATA_ACC = repmat(struct(), 1, length(subdir3)-2);
for i = 15:length(subdir1)-2
    % 读取速度文件 
    subdirpath1 = fullfile(maindir1, subdir1(i+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
    stru1 = dir(subdirpath1);
    DATA1 = struct();
    % 读取位移文件
    subdir2 = dir(maindir2);
    subdirpath2 = fullfile(maindir2, subdir2(i+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
    stru2 = dir(subdirpath2);
    DATA2 = struct();
    % 读取加速度文件
    subdirpath3 = fullfile(maindir3, subdir3(i+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
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
        station1 = hr1.station.kstnm;
        station1 = strrep(station1,' ','');
        time1 = strcat(num2str(hr1.event.nzyear),'年',num2str(hr1.event.nzjday),'日');
        direction1 = hr1.stations.kcmpnm;
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
        % index = period_cut_ver2_tidy(record1,300);
        index = period_cut_ver2_tidy(record1,450);  % 将时窗改为450s  20235.7.22：57
        % timehistory = cell(4,1);  % 5.6.17:13
        timehistory1 = cell(12,1);
        % for i =1:4 5.6.17:13
        for k =1:12
            if ~isequal(index(k,:),[0,0])
                timehistory1{k} = record1(index(k,1):index(k,2));
            else 
                timehistory1{k} = NaN;
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
            for k =1:12
                if ~isequal(index(k,:),[0,0])
                    timehistory2{k} = record2(index(k,1):index(k,2));
                else 
                    timehistory2{k} = NaN;
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
            for k =1:12
                if ~isequal(index(k,:),[0,0])
                    timehistory3{k} = record3(index(k,1):index(k,2));
                else 
                    timehistory3{k} = NaN;
                end
            end
            data3.timehistory = timehistory3;
            data3.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30
            DATA3(j).data = data3;
        else 
            error('加速度文件与速度文件不匹配')
        end
    
    end
    % fprintf('The %d st turn has ended. And the velosity data is:',i);
    % DATA1
    
    DATA_VEL(i).data = DATA1;
    DATA_DISP(i).data = DATA2;
    DATA_ACC(i).data = DATA3;
    % fprintf('The velosity data stored is:');
    % DATA_VEL(i)
end
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

%% 获取完整地震数据
maindir = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel';
subdir = dir(maindir);
for k = 1:1
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
    
        
        data.station = station;
        data.time = time;
        data.direction = direction;
        data.timehistory = data1;
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
for k = 1:1  %5.6.17:13
    subdirpath = fullfile(maindir1, subdir(k+2).name, '*.SAC');  % 注意前两个subdir去掉'.','..'
    stru = dir(subdirpath);
    number = 0;

    for j = 1:length(stru)
        data = struct();
        number = number+1;
        path = fullfile(stru(j).folder, stru(j).name);
        parts = strsplit(path, '.');
        station = parts{7};
        channel = parts{9}(2); % 第9个部分的第2个字符
        
        % 构造新的文件名
        newFilename = sprintf('data%s_%s%s', channel, station, '.SAC');
        
        % 构造完整的源文件路径和目标文件路径
        sourceFolder = 'C:\Users\wty\Documents\MATLAB\cier\201411221655 _SAC';
        sourceFile = fullfile(sourceFolder, fileList(i).name);

        targetFolder = 'C:\Users\wty\Documents\MATLAB\cier\宕机1';
        targetFile = fullfile(targetFolder, newFilename);
        
        % 执行重命名操作
        movefile(sourceFile, targetFile);

    end
end

%%
dataE_LANT = DATA1(8).data.timehistory.*1e9;
dataE_XAN = DATA1(15).data.timehistory.*1e9;
dataE_MEIX = 0;
dataE_ZOZT = DATA1(3).data.timehistory.*1e9;
figure
plot(dataE_LANT)
% hold on
% plot(dataE_MEIX)
hold on
plot(dataE_XAN)
hold on
plot(dataE_ZOZT)
xlabel('时间/0.01s')
ylabel('速度/nm/s')
legend('LANT','XAN','ZOZT')
title('dataE')
set(gca,'FontSize',20)
%%
% 源文件夹路径
sourceFolder = 'C:\Users\wty\Documents\MATLAB\cier\201411221655 _SAC';

% 目标文件夹路径
targetFolder = 'C:\Users\wty\Documents\MATLAB\cier\宕机1';

% 获取源文件夹中所有的文件列表
cd(sourceFolder)
fileList = dir('*.SAC');

% 遍历每个文件并重命名
for i = 1:length(fileList)-2
    % 获取文件名（包括扩展名）
    [~, filename, ext] = fileparts(fileList(i+2).name);
    
    % 解析文件名
    parts = strsplit(filename, '.');
    station = parts{8};
    channel = parts{10}(3); % 第9个部分的第2个字符
    
    % 构造新的文件名
    newFilename = sprintf('data%s_%s%s', channel, station, ext);
    
    % 构造完整的源文件路径和目标文件路径
    sourceFile = fullfile(sourceFolder, fileList(i+2).name);
    targetFile = fullfile(targetFolder, newFilename);

    % 执行重命名操作
    movefile(sourceFile, targetFile);
end

%%
