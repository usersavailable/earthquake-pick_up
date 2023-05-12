%% 自动化(交互型)绘制三分向数据波形
do = 1;
while(do == 1)
    earthquakepath = input('请输入文件路径(须带引号)：');
    Fs = 100;
    Fs1 = 50;
    type = input('请选择数据类型("速度"/"位移"/"加速度")(须带引号)') ;
    
    if strcmp(type,'速度')
        type = '速度(nm/s)';
    elseif strcmp(type,'位移')
        type = '位移(nm)';
    elseif strcmp(type,'加速度')
        type = '加速度(nm/s^2)';
    end
    data = dir(earthquakepath);
    filename1 = data(3).name;
    parts1 = strsplit(filename1,'.');
    direction1 = parts1{10}(3);
    filename2 = data(4).name;
    parts2 = strsplit(filename2,'.');
    direction2 = parts2{10}(3);
    filename3 = data(5).name;
    parts3 = strsplit(filename3,'.');
    direction3 = parts3{10}(3);
    
    [~,record1,h1] = fget_sac(fullfile(earthquakepath,filename1));
    [~,record2,h2] = fget_sac(fullfile(earthquakepath,filename2));
    [~,record3,h3] = fget_sac(fullfile(earthquakepath,filename3));
    

    record1 = resample(record1,Fs1,Fs);  %对数据进行重采样，采样后数据长度为原来的1/5
    record2 = resample(record2,Fs1,Fs);
    record3 = resample(record3,Fs1,Fs);




    set(gca,'FontSize',20)
    subplot(3,1,1)
    for i =1:3
        if eval(strcat('direction',num2str(i))) == 'E'
            t = 1:length(eval(strcat('record',num2str(i))));
            t = t./Fs1;
            plot(t,eval(strcat('record',num2str(i))))
            xlim([0 t(length(eval(strcat('record',num2str(i)))))])
        end
    end
    hold on

    xlabel('时间(s)')
    ylabel(type)
    title('BHE')
    
    subplot(3,1,2)
    set(gca,'FontSize',20)
    for i =1:3
        if eval(strcat('direction',num2str(i))) == 'N'
            t = 1:length(eval(strcat('record',num2str(i))));
            t = t./Fs1;
            plot(t,eval(strcat('record',num2str(i))))
            xlim([0 t(length(eval(strcat('record',num2str(i)))))])
        end
    end
    hold on

    xlabel('时间(s)')
    ylabel(type)
    title('BHN')
    
    subplot(3,1,3)
    set(gca,'FontSize',20)
    for i =1:3
        if eval(strcat('direction',num2str(i))) == 'Z'
            t = 1:length(eval(strcat('record',num2str(i))));
            t = t./Fs1;
            plot(t,eval(strcat('record',num2str(i))))
            xlim([0 t(length(eval(strcat('record',num2str(i)))))])
        end
    end
    hold on

    xlabel('时间(s)')
    ylabel(type)
    title('BHZ')

    do = input('是否继续？(1/0)');
end


%%
%% 自动化(懒人式)绘制所有地震时间同一台站的三分向数据波形
path0 = input('请输入文件路径(须带引号)：');
station = input("请输入选用的台站");
Fs = 100;
Fs1 = 50;
type = input('请选择数据类型("速度"/"位移"/"加速度")(须带引号)') ;
path1 = dir(path0);

if strcmp(type,'速度')
    type = '速度(nm/s)';
elseif strcmp(type,'位移')
    type = '位移(nm)';
elseif strcmp(type,'加速度')
    type = '加速度(nm/s^2)';
end

for i = 1:length(path1)-2
    path2 = dir(fullfile(path0,path1(i+2).name));
    for j = 1:4
        if (path2(j+2).name == station)

        data = dir(fullfile(path0,path1(i+2).name,path2(j+2).name));
        filename1 = data(3).name;
        parts1 = strsplit(filename1,'.');
        direction1 = parts1{10}(3);
        filename2 = data(4).name;
        parts2 = strsplit(filename2,'.');
        direction2 = parts2{10}(3);
        filename3 = data(5).name;
        parts3 = strsplit(filename3,'.');
        direction3 = parts3{10}(3);
        
        [~,record1,h1] = fget_sac(fullfile(path0,path1(i+2).name,path2(j+2).name,filename1));
        [~,record2,h2] = fget_sac(fullfile(path0,path1(i+2).name,path2(j+2).name,filename2));
        [~,record3,h3] = fget_sac(fullfile(path0,path1(i+2).name,path2(j+2).name,filename3));
        
        % % 基线漂移去趋势项
        % record1 = detrend(record1);
        % record2 = detrend(record2);
        % record3 = detrend(record3);

        %对数据进行重采样，采样后数据长度为原来的1/5
        record1 = resample(record1,Fs1,Fs);  %对数据进行重采样，采样后数据长度为原来的1/5
        record2 = resample(record2,Fs1,Fs);
        record3 = resample(record3,Fs1,Fs);
        
        % 调用simulink进行滤波
        options=simset('SrcWorkspace','current');
        ts1 = [[0:length(record1)-1]'./Fs1,record1];
        ts = ts1;
        sim('jianyilvbo',[0,length(record1)./Fs1],options);
        record1 = record;

        ts2 = [[0:length(record2)-1]'./Fs1,record2];
        ts = ts2;
        sim('jianyilvbo',[0,length(record2)./Fs1],options);
        record2 = record;

        ts3 = [[0:length(record3)-1]'./Fs1,record3];
        ts = ts3;
        sim('jianyilvbo',[0,length(record3)./Fs1],options);
        record3 = record;
    
    
        % set(gca,'FontSize',20)
        subplot(3,1,1)
        for k =1:3
            if eval(strcat('direction',num2str(k))) == 'E'
                t = 1:length(eval(strcat('record',num2str(k))));
                t = t./Fs1;
                plot(t,eval(strcat('record',num2str(k))))
                xlim([0 t(length(eval(strcat('record',num2str(k)))))])
            end
        end
        hold on
    
        xlabel('时间(s)')
        ylabel(type)
        title('BHE')
        
        subplot(3,1,2)
        % set(gca,'FontSize',20)
        for k =1:3
            if eval(strcat('direction',num2str(k))) == 'N'
                t = 1:length(eval(strcat('record',num2str(k))));
                t = t./Fs1;
                plot(t,eval(strcat('record',num2str(k))))
                xlim([0 t(length(eval(strcat('record',num2str(k)))))])
            end
        end
        hold on
    
        xlabel('时间(s)')
        ylabel(type)
        title('BHN')
        
        subplot(3,1,3)
        % set(gca,'FontSize',20)
        for k =1:3
            if eval(strcat('direction',num2str(k))) == 'Z'
                t = 1:length(eval(strcat('record',num2str(k))));
                t = t./Fs1;
                plot(t,eval(strcat('record',num2str(k))))
                xlim([0 t(length(eval(strcat('record',num2str(k)))))])
            end
        end
        hold on
    
        xlabel('时间(s)')
        ylabel(type)
        title('BHZ')

        end
    end
end



%%
record1 = resample(record1,1,5);


%%
pathE_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.55.8300.SN.LANT.00.BHE.D.SAC';
pathN_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.57.4400.SN.LANT.00.BHN.D.SAC';
pathZ_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.57.5400.SN.LANT.00.BHZ.D.SAC';
[~,dataE_LANT,~] = fget_sac(pathE_LANT);
[~,dataN_LANT,~] = fget_sac(pathN_LANT);
[~,dataZ_LANT,~] = fget_sac(pathZ_LANT);
figure
set(gca,'FontSize',20)
subplot(3,1,1)
plot(dataE_LANT)
xlabel('时间/0.01s')
ylabel('速度/nm/s')
title('dataE LANT')

subplot(3,1,2)
plot(dataN_LANT)
xlabel('时间/0.01s')
ylabel('速度/nm/s')
title('dataN LANT')

subplot(3,1,3)
plot(dataZ_LANT)
xlabel('时间/0.01s')
ylabel('速度/nm/s')
title('dataZ LANT')
%%
pathE_MEIX = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\MEIX\2023.075.00.55.56.9500.SN.MEIX.00.BHE.D.SAC';
pathN_MEIX = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\MEIX\2023.075.00.55.57.5400.SN.MEIX.00.BHN.D.SAC';
pathZ_MEIX = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\MEIX\2023.075.00.55.58.5400.SN.MEIX.00.BHZ.D.SAC';
[~,dataE_MEIX,~] = fget_sac(pathE_MEIX);
[~,dataN_MEIX,~] = fget_sac(pathN_MEIX);
[~,dataZ_MEIX,~] = fget_sac(pathZ_MEIX);

pathE_XAN = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\XAN\2023.075.00.55.56.8800.SN.XAN.00.BHE.D.SAC';
pathN_XAN = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\XAN\2023.075.00.55.57.6500.SN.XAN.00.BHN.D.SAC';
pathZ_XAN = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\XAN\2023.075.00.55.57.8400.SN.XAN.00.BHZ.D.SAC';
[~,dataE_XAN,~] = fget_sac(pathE_XAN);
[~,dataN_XAN,~] = fget_sac(pathN_XAN);
[~,dataZ_XAN,~] = fget_sac(pathZ_XAN);

pathE_ZOZT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\ZOZT\2023.075.00.55.55.3900.SN.ZOZT.00.BHZ.D.SAC';
pathN_ZOZT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\ZOZT\2023.075.00.55.56.0000.SN.ZOZT.00.BHN.D.SAC';
pathZ_ZOZT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\ZOZT\2023.075.00.55.58.5600.SN.ZOZT.00.BHE.D.SAC';
[~,dataE_ZOZT,~] = fget_sac(pathE_ZOZT);
[~,dataN_ZOZT,~] = fget_sac(pathN_ZOZT);
[~,dataZ_ZOZT,~] = fget_sac(pathZ_ZOZT);