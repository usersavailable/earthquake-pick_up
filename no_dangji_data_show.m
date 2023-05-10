earthquakepath = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230316085600.seed\LANT';
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

[~,record1,~] = fget_sac(fullfile(earthquakepath,filename1));
[~,record2,~] = fget_sac(fullfile(earthquakepath,filename2));
[~,record3,~] = fget_sac(fullfile(earthquakepath,filename3));

figure
set(gca,'FontSize',20)
subplot(3,1,1)
for i =1:3
    if eval(strcat('direction',num2str(i))) == 'E'
        t = [1:length(eval(strcat('record',num2str(i))))];
        t = t./100;
        plot(t,eval(strcat('record',num2str(i))))
    end
end

xlabel('时间(s)')
ylabel('速度(nm/s)')
title('BHE')

subplot(3,1,2)
for i =1:3
    if eval(strcat('direction',num2str(i))) == 'N'
        t = [1:length(eval(strcat('record',num2str(i))))];
        t = t./100;
        plot(t,eval(strcat('record',num2str(i))))
    end
end

xlabel('时间(s)')
ylabel('速度(nm/s)')
title('BHN')

subplot(3,1,3)
for i =1:3
    if eval(strcat('direction',num2str(i))) == 'Z'
        t = [1:length(eval(strcat('record',num2str(i))))];
        t = t./100;
        plot(t,eval(strcat('record',num2str(i))))
    end
end

xlabel('时间(s)')
ylabel('速度(nm/s)')
title('BHZ')



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