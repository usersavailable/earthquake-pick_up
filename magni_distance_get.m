path = 'C:\Users\wty\Downloads\百度网盘下载\SUMSUNG不宕机数据_SAC\SAC_vel\20230317183000.seed\LANT';
file = '2023.076.10.29.57.0100.SN.LANT.00.BHE.D.SAC';
path = fullfile(path,file);
[t,data,h] = fget_sac(path);

figure
plot(data)


%%
path = 'C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel\202101120532 _SAC';
file = '2021.248.15.59.58.7000.SN.MEIX.00.BHE.D.SAC';
path = fullfile(path,file);
[t,data,h] = fget_sac(path);
figure
plot(data)