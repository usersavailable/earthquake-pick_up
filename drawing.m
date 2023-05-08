tata = DATA9(3).data.timehistory;

figure
for i =1:3
    for j =1:4
        subplot(3,4,i*4-4+j)
        plot(tata{i*4-4+j})
    end
end

%%
data = DATA_VEL2(15).data(1).data.timehistory;
for k =1:nnz(data)
    figure()
end
%% 读取不宕机数据

maindir1 = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel';
subdir1 = dir(maindir1);
subdirpath = fullfile(maindir1,subdir1(3).name);
subsubdir1 = dir(subdirpath);
subsubdirpath1 = fullfile(subdirpath,subsubdir1(3).name);
subsubsubdir1 = dir(subsubdirpath1);

DATA_VEL2 = repmat(struct(), 1, length(subdir1)-2);
%% tidy
mainpath1 = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel'
maindir1 = dir(mainpath1);
for i = 1:length(maindir1)-2
    eval(['path',num2str(i),'=fullfile(mainpath1,maindir1(i+2).name)']);
end
% path1 = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed';

%% more tidy 一次地震记录四个台站的速度对比
pathE_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.55.8300.SN.LANT.00.BHE.D.SAC';
pathN_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.57.4400.SN.LANT.00.BHN.D.SAC';
pathZ_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.57.5400.SN.LANT.00.BHZ.D.SAC';
[~,dataE_LANT,~] = fget_sac(pathE_LANT);
[~,dataN_LANT,~] = fget_sac(pathN_LANT);
[~,dataZ_LANT,~] = fget_sac(pathZ_LANT);

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

figure
set(gca,'FontSize',20)
subplot(3,1,1)
plot(dataE_LANT)
hold on
plot(dataE_MEIX)
hold on
plot(dataE_XAN)
hold on
plot(dataE_ZOZT)
legend('LANT','MEIX','XAN','ZOZT')
title('dataE')
xlabel('时间/0.01s')
ylabel('速度/nm/s')

subplot(3,1,2)
plot(dataN_LANT)
hold on
plot(dataN_MEIX)
hold on
plot(dataN_XAN)
hold on
plot(dataE_ZOZT)
legend('LANT','MEIX','XAN','ZOZT')
title('dataN')
xlabel('时间/0.01s')
ylabel('速度/nm/s')

subplot(3,1,3)
plot(dataZ_LANT)
hold on
plot(dataZ_MEIX)
hold on
plot(dataZ_XAN)
hold on
plot(dataE_ZOZT)
legend('LANT','MEIX','XAN','ZOZT')
title('dataZ')
xlabel('时间/0.01s')
ylabel('速度/nm/s')

%%
%% more tidy 一次地震记录四个台站的位移对比
pathE_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.55.8300.SN.LANT.00.BHE.D.SAC';
pathN_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.57.4400.SN.LANT.00.BHN.D.SAC';
pathZ_LANT = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT\2023.075.00.55.57.5400.SN.LANT.00.BHZ.D.SAC';
[~,dataE_LANT,~] = fget_sac(pathE_LANT);
[~,dataN_LANT,~] = fget_sac(pathN_LANT);
[~,dataZ_LANT,~] = fget_sac(pathZ_LANT);

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

figure
set(gca,'FontSize',20)
subplot(3,1,1)
plot(dataE_LANT)
hold on
plot(dataE_MEIX)
hold on
plot(dataE_XAN)
hold on
plot(dataE_ZOZT)
legend('LANT','MEIX','XAN','ZOZT')
title('dataE')
xlabel('时间/0.01s')
ylabel('速度/nm/s')

subplot(3,1,2)
plot(dataN_LANT)
hold on
plot(dataN_MEIX)
hold on
plot(dataN_XAN)
hold on
plot(dataE_ZOZT)
legend('LANT','MEIX','XAN','ZOZT')
title('dataN')
xlabel('时间/0.01s')
ylabel('速度/nm/s')

subplot(3,1,3)
plot(dataZ_LANT)
hold on
plot(dataZ_MEIX)
hold on
plot(dataZ_XAN)
hold on
plot(dataE_ZOZT)
legend('LANT','MEIX','XAN','ZOZT')
title('dataZ')
xlabel('时间/0.01s')
ylabel('速度/nm/s')

%% 频谱分析
%% 两个频率分别为15HZ 和 20HZ 的正弦信号[1]
Fs=100;%采样率

tE = 0:1/Fs:length(dataE_ZOZT)/Fs-1/Fs; %采样率为100的时间序列
x = dataE_ZOZT;
% figure;
% plot(tE,x);
y = fft(x); 

%将横坐标转化，显示为频率f= n*(fs/N)
f = (0:length(y)-1)*Fs/length(y);
% figure;
% plot(f,abs(y));
% title('Magnitude');
%该变换还会生成尖峰的镜像副本，该副本对应于信号的负频率。

%为了更好地以可视化方式呈现周期性，可以使用 fftshift 函数对变换执行以零为中心的循环平移。
n = length(x);                         
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
frequncyE_ZOZT = fshift;
magnitudeE_ZOZT = yshift;
% figure;
% plot(fshift,abs(yshift));
% xlabel('频率')
% title('dataE ZOZT')
% set(gca,'FontSize',20)

%FFT的结果所要展现的真实的频谱幅值[2]
realy=2*abs(y(1:n/2+1))/n;
realf=(0:n/2)*(Fs/n);
figure;
plot(realf,realy);

frequncyE_ZOZT = realf;
magnitudeE_ZOZT = realy;

xlabel('频率')
title('dataE ZOZT')
set(gca,'FontSize',20)
%%
%% 两个频率分别为15HZ 和 20HZ 的正弦信号[1]
Fs=100;%采样率

tN = 0:1/Fs:length(dataN_ZOZT)/Fs-1/Fs; %采样率为100的时间序列
x = dataN_ZOZT;

y = fft(x); 

f = (0:length(y)-1)*Fs/length(y);

n = length(x);                         
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
frequncyN_ZOZT = fshift;
magnitudeN_ZOZT = yshift;

% figure;
% plot(fshift,abs(yshift));
% xlabel('频率')
% title('dataN ZOZT')
% set(gca,'FontSize',20)

realy=2*abs(y(1:n/2+1))/n;
realf=(0:n/2)*(Fs/n);
figure;
plot(realf,realy);

frequncyN_ZOZT = realf;
magnitudeN_ZOZT = realy;

xlabel('频率')
title('dataN ZOZT')
set(gca,'FontSize',20)
%%
%% 两个频率分别为15HZ 和 20HZ 的正弦信号[1]
Fs=100;%采样率

tN = 0:1/Fs:length(dataN_LANT)/Fs-1/Fs; %采样率为100的时间序列
x = dataN_LANT;

y = fft(x); 

f = (0:length(y)-1)*Fs/length(y);

n = length(x);                         
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
frequncyN_LANT = fshift;
magnitudeN_LANT = yshift;

% figure;
% plot(fshift,abs(yshift));
% xlabel('频率')
% title('dataN LANT')
% set(gca,'FontSize',20)

realy=2*abs(y(1:n/2+1))/n;
realf=(0:n/2)*(Fs/n);
figure;
plot(realf,realy);

frequncyZ_ZOZT = realf;
magnitudeZ_ZOZT = realy;

xlabel('频率')
title('dataZ ZOZT')
set(gca,'FontSize',20)
%%
figure;
set(gca,'FontSize',20)
subplot(3,1,1)
plot(frequncyE_ZOZT,magnitudeE_ZOZT);
xlabel('频率')
title('dataE ZOZT')
subplot(3,1,2)
plot(frequncyN_ZOZT,magnitudeN_ZOZT);
xlabel('频率')
title('dataN ZOZT')
subplot(3,1,3)
plot(frequncyZ_ZOZT,magnitudeZ_ZOZT);
xlabel('频率')
title('dataZ ZOZT')

%% 两个频率分别为15HZ 和 20HZ 的正弦信号[1]
Fs=100;%采样率

tN = 0:1/Fs:length(dataZ_ZOZT)/Fs-1/Fs; %采样率为100的时间序列
x = dataZ_ZOZT;

y = fft(x); 

f = (0:length(y)-1)*Fs/length(y);

n = length(x);                         
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
frequncyZ_ZOZT = fshift;
magnitudeZ_ZOZT = yshift;

figure;
plot(fshift,abs(yshift));
xlabel('频率')
title('dataZ ZOZT')
set(gca,'FontSize',20)
%%
figure;
subplot(1,3,1)
plot(fshift,abs(yshift));
xlabel('频率')
title('dataZ ZOZT')
%% 两个频率分别为15HZ 和 20HZ 的正弦信号[1]
Fs=100;%采样率

tN = 0:1/Fs:length(dataZ_ZOZT)/Fs-1/Fs; %采样率为100的时间序列
x = dataZ_ZOZT;

y = fft(x); 

f = (0:length(y)-1)*Fs/length(y);

n = length(x);                         
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
figure;
plot(fshift,abs(yshift));
xlabel('频率')
title('dataN ZOZT')
set(gca,'FontSize',20)
%% 加速度、速度、位移共同剪切

maindir1 = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel';
maindir2 = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_none';
maindir3 = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_acc';
subdir1 = dir(maindir1);
subdir2 = dir(maindir2);
subdir3 = dir(maindir3);
DATA_VEL2 = repmat(struct(), 1, length(subdir1)-2);
DATA_DISP2 = repmat(struct(), 1, length(subdir2)-2);
DATA_ACC2 = repmat(struct(), 1, length(subdir3)-2);
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
    
    
        dangji = 0;
        data1.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30    
        data1.timehistory = record1;    
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
            
            data2.timehistory = record2;
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
           
            data3.timehistory = record3;
            data3.status = dangji;  % 1代表宕机，0代表未宕机 5.6.20：30
            DATA3(j).data = data3;
        else 
            error('加速度文件与速度文件不匹配')
        end
    
    end
    % fprintf('The %d st turn has ended. And the velosity data is:',i);
    % DATA1
    
    DATA_VEL2(i).data = DATA1;
    DATA_DISP2(i).data = DATA2;
    DATA_ACC2(i).data = DATA3;
    % fprintf('The velosity data stored is:');
    % DATA_VEL(i)
end

%%
save("DATA_BUDANG.mat","DATA_ACC2","DATA_DISP2","DATA_VEL2")