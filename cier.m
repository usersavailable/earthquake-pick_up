function[] = neimenggu()
%%
x1 = 0:0.01:599.99
y1 = neimenggu_LANT_N./1248.6
plot(x1,y1)
%%
x2 = 0:0.01:599.99
y2 = neimenggu_LANT_E./1252.86
plot(x2,y2)
%%
x3 = 0:0.01:599.99
y3 = neimenggu_LANT_Z./1262.57
plot(x3,y3)
%%
x = 0:0.01:599.99
y = ZOZT./1263.73
plot(x,y)
%%
clc;clear
path = 'C:\Users\wty\三星地震数据\';
namelist = dir([path,'*.txt']);
% namelist = dir([path,'*.xls']);
L = length(namelist);
a = cell(1,L);
for i = 1:L
    filename{i} = [path,namelist(i).name];
    a{1,i} = load(filename{i});%读取txt文件
%     a{1,i} = xlsread(filename{i});%读取excel文件
    namelist(i).name;
end     
data1=a;
for i = 1:length(data1)
    t_end(i) = length(data1{i}).*0.01
end
!x=cell2mat(data1);%由元胞数组转化为矩阵
!{x20141122_LANT-E,x20141122_LANT-N,x20141122_LANT-Z} = data1
%% 
% 先将seed文件导出的txt文本由counts还原为速度，再分方向存储
% velocity(um/s) = counts ./ scale factor;

for i = 1:12
    data1{i} = data1{i}./1248.6
end
for i = 13:25
    data1{i} = data1{i}./1664.45
end
for i = 26:37
    data1{i} = data1{i}./1252.86
end
for i = 38:50
    data1{i} = data1{i}./1670.13
end
for i = 51:62
    data1{i} = data1{i}./1262.57
end
for i = 63:75
    data1{i} = data1{i}./1683.08
end
for i = 76:100
    data1{i} = data1{i}./1250.74
end
for i = 101:125
    data1{i} = data1{i}./1259.59
end
for i = 126:150
    data1{i} = data1{i}./1253.34
end
for i =151:159
    data1{i} = data1{i}./1252.36
end
for i = 160:161
    data1{i} = data1{i}./1224.67
end
for i = 162:176
    data1{i} = data1{i}./1632.55
end
for i = 177:185
    data1{i} = data1{i}./1267.46
end
for i = 186:187
    data1{i} = data1{i}./12570.5
end
for i = 188:202
    data1{i} = data1{i}./1571.31
end
for i = 203:211
    data1{i} = data1{i}./1280.05
end
for i = 212:213
    data1{i} = data1{i}./1233.48
end
for i = 214:228
    data1{i} = data1{i}./1644.3
end
for i = 229:254
    data1{i} = data1{i}./1263.73
end
for i = 255:280
    data1{i} = data1{i}./1259.72
end
for i = 281:306
    data1{i} = data1{i}./1259.35
end
for i = 1:25
    Vel_E(1:length(data1{i}),i) = data1{i};
    Vel_N(1:length(data1{i+25}),i) = data1{i+25};
    Vel_Z(1:length(data1{i+50}),i) = data1{i+50};
end
for i = 26:50
    Vel_E(1:length(data1{i+75-25}),i) = data1{i+75-25};
    Vel_N(1:length(data1{i+100-25}),i) = data1{i+100-25};
    Vel_Z(1:length(data1{i+125-25}),i) = data1{i+125-25};
end
for i = 51:76
    Vel_E(1:length(data1{i+150-50}),i) = data1{i+150-50};
    Vel_N(1:length(data1{i+176-50}),i) = data1{i+176-50};
    Vel_Z(1:length(data1{i+202-50}),i) = data1{i+202-50};
end
for i = 77:102
    Vel_E(1:length(data1{i+228-77}),i) = data1{i+228-77};
    Vel_N(1:length(data1{i+254-77}),i) = data1{i+254-77};
    Vel_Z(1:length(data1{i+280-77}),i) = data1{i+280-77};
end


save('VelENZ360000','Vel_E','Vel_N','Vel_Z');
%%
% for i = 1:306
%     PGV1(i) = max(data1{i})
%     PGV2(i) = min(data1{i})
%     if abs(PGV1(i)) > abs(PGV2(i))
%         PGV(i) = PGV1(i)
%     else
%         PGV(i) = PGV2(i)
%     end
% end
for i = 1:306
    PGV(i) = max(abs(data1{i}))
end
%%
for i = 1:12
    PGV(i) = PGV(i)./1248.6
end
for i = 13:25
    PGV(i) = PGV(i)./1664.45
end
for i = 26:37
    PGV(i) = PGV(i)./1252.86
end
for i = 38:50
    PGV(i) = PGV(i)./1670.13

end
for i = 51:62
    PGV(i) = PGV(i)./1262.57
end
for i = 63:75
    PGV(i) = PGV(i)./1683.08
end
for i = 76:100
    PGV(i) = PGV(i)./1250.74
end
for i = 101:125
    PGV(i) = PGV(i)./1259.59
end
for i = 126:150
    PGV(i) = PGV(i)./1253.34
end
for i =151:159
    PGV(i) = PGV(i)./1252.36
end
for i = 160:161
    PGV(i) = PGV(i)./1224.67
end
for i = 162:176
    PGV(i) = PGV(i)./1632.55
end
for i = 177:185
    PGV(i) = PGV(i)./1267.46
end
for i = 186:187
    PGV(i) = PGV(i)./12570.5
end
for i = 188:202
    PGV(i) = PGV(i)./1571.31
end
for i = 203:211
    PGV(i) = PGV(i)./1280.05
end
for i = 212:213
    PGV(i) = PGV(i)./1233.48
end
for i = 214:228
    PGV(i) = PGV(i)./1644.3
end
for i = 229:254
    PGV(i) = PGV(i)./1263.73
end
for i = 255:280
    PGV(i) = PGV(i)./1259.72
end
for i = 281:306
    PGV(i) = PGV(i)./1259.35
end
%%
clear PGV_E PGV_N PGV_Z
for i = 1:25
    PGV_E(i) = PGV(i)
    PGV_N(i) = PGV(i+25)
    PGV_Z(i) = PGV(i+50)
end
for i = 26:50
    PGV_E(i) = PGV(i+75-25)
    PGV_N(i) = PGV(i+100-25)
    PGV_Z(i) = PGV(i+125-25)
end
for i = 51:76
    PGV_E(i) = PGV(i+150-50)
    PGV_N(i) = PGV(i+176-50)
    PGV_Z(i) = PGV(i+202-50)
end
for i = 77:102
    PGV_E(i) = PGV(i+228-77)
    PGV_N(i) = PGV(i+254-77)
    PGV_Z(i) = PGV(i+280-77)
end
%%
d_E = zeros(104,1);
d_N = zeros(104,1);
d_Z = zeros(103,1);
% d_E(1) = 0.3
% d_E(2) = 0.3
%%
% clc;clear
% path_2nd = 'C:\Users\wty\三星地震数据\';
% namelist_2nd = dir([path_2nd,'*.par']);
% % namelist = dir([path,'*.xls']);
% L_2nd = length(namelist_2nd);
% a2 = cell(1,L_2nd);
% for i = 1:L_2nd
%     filename2{i} = [path_2nd,namelist_2nd(i).name];
%     a2{1,i} = load(filename2{i});%读取txt文件
% %     a{1,i} = xlsread(filename{i});%读取excel文件
%     namelist_2nd(i).name;
% end     
% data2=a2;
%%
![X,Y] = meshgrid(D(:,1),D(:,2));
X = D(:,1)
Y = D(:,2)
Z = D(:,3)
!Fig = mesh(X,Y,Z);
plot3(X,Y,Z);
%%
figure
scatter3(X, Y, Z, 100, 'filled')
!hold on
!scatter3(x2, y2, z2, 2, repmat(C2,length(x2),1), 'filled')
!hTitle = title('宕机率与基本参数分布');
hXLabel = xlabel('震级');
hYLabel = ylabel('震中距(km)');
hZLabel = zlabel('宕机率');
set(gca,'FontSize',22)

hold on
[X1,Y1,Z1]=griddata(X,Y,Z,linspace(min(X),max(X)),linspace(min(Y),max(Y)),'v4');
figure(2),surf(X1,Y1,Z1);
xlabel('震级');
ylabel('距西安距离');
zlabel('宕机率');
title('nihe')
%%
dd1 = [dd_raw(1:11)', dd_raw(13:25)', dd_raw(27:28)']
%%
% 假设数据为x,y,z
x = X
y = Y
z = Z
plot3(x,y,z,'.') % 绘制散点图
N=300  % 拟合网格密度，值越大计算所需计算时间与内存越大
[X,Y]=meshgrid(linspace(min(x),max(x),N),linspace(min(y),max(y),N));
Z=griddata(x,y,z,X,Y,"v4");
mesh(X,Y,Z)


%%
for ii = 1:50
    ii
end
%%
%将第一组地震动进行校正
xx1 = 0:0.01:3499.99;
dd1 = data1{1};
ddd1 = dd1 / 1252.86;
plot(xx1,ddd1)
max(ddd1)
%%
%%统一速度记录时长
velocity = zeros(360000,306);
for i = 1:length(data1)
    velocity(:,i) = [data1{i}; zeros(360000-length(data1{i}),1)];
end
%%
time = [0:0.01:3600-0.01]
velocityrecord = [time',velocity]
%%
%%使用差分方法计算加速度
X = [0:0.01:3600-0.01]
y = velocity(:,1);
f1=diff(y,1)./diff(X'); 
%f2=cos(X(1:end-1));
plot(0.01:0.01:3599.99,f1);
xlim([0,3600]);

Y = velocity;
acceleration=diff(Y,1)./diff(X');
%%
%%使用积分方法计算位移
%%
% 从文件中读入结构体 S
S = readsac('seis.SAC');
% 从结构体 S 中提取自变量和因变量
[X, Y] = getsacdata(S);
%%
sorted_PGV_N = sort(PGV_N);
sorted_PGV_Z = sort(PGV_Z);
save('sorted_PGV_NEZ','sorted_PGV_Z','sorted_PGV_N','sorted_PGV_E')