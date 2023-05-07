%% 震级经验CDF图/分布图
nbins = 6
edges = [5 5:0.5:8.5 8.5];
h = histogram(D26(:,1),nbins);
xlabel('震级')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
% cdfplot(D(:,1))
% hf = histfit(D(:,1))
%% 震中距分布图
nbins = 6
edges = [0 0:500:3000 3000];
h = histogram(D26(:,2),nbins);
xlabel('震中距(km)')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% 宕机率分布图
nbins = 10
edges = [5 5:0.5:9 9];
h = histogram(D26(:,3),nbins);
xlabel('宕机率')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% 宕机与否分布图
!二分宕机率
Dbinary = D26(:,3)
for i = 1:26
    if Dbinary(i) > 0
        Dbinary(i) = 1
    end 
end
h = histogram(Dbinary,2);
xticks([0.25,0.75]);
xticklabels({'未宕机','宕机'})
!xlabel('宕机')
ylabel('频数')
set(gca,'FontSize',20); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',20);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',20);
%% 震源深度分布图
nbins = 10
edges = [5 5:0.5:9 9];
h = histogram(D4,nbins);
xlabel('震源深度(km)')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% PGVE分布图
nbins = 10;
edges = [0 0:500:6500 6500];
% edges2 = [-7000 -7000:500:5000 5000]
h = histogram(PGV_E,edges);
xlabel('PGV_E(um/s)')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% PGVN分布图
nbins = 15;
edges = [0 0:500:7000 7000];
edges2 = [-7000 -7000:500:5000 5000];
h = histogram(PGV_N,edges);
xlabel('PGV_N(um/s)')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% PGVZ分布图
nbins = 15
edges = [0 0:500:7000 7000];
edges2 = [-7000 -7000:500:5000 5000];
h = histogram(PGV_Z,edges)
xlabel('PGV_Z(um/s)')
ylabel('频数')
set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% PGVN频数频率双y轴分布，不成熟
nbins = 15
edges = [-7000 -2000:500:2000 5000];
edges2 = [-7000 -7000:500:5000 5000];
yyaxis left
h = histogram(PGV_N,edges2)
xlabel('PGV_N')
ylabel('频数')
yyaxis right
h = histogram(PGV_N./sum(PGV_N),edges2)
ylabel('频率')

% [AX,H] = plotyy(0,0,PGV_N,PGV_N./sum(PGV_N))
% set(AX(1),'ytick',0:2:10);%设置左边纵轴的刻度
% set(AX(2),'ytick',0:0.2:1);%设置右边纵轴的刻度
% set(AX(1),'ylim',[0,10]);%设置左边纵轴的取值范围
% set(AX(2),'ylim',[0,1]);%设置右边纵轴的取值范围

!h2 = histogram(PGV_N/sum(PGV_N),edges2)
% xlabel('PGV_N')
% ylabel('频数')

% set(get(AX(1),'ylabel'),'String','频数','FontSize',28);%设置左纵轴标签
% set(get(AX(2),'ylabel'),'String','频率','FontSize',28);%设置右纵轴标签

set(gca,'FontSize',28); % 设置文字大小，同时影响坐标轴标注、图例、标题等。
set(get(gca,'XLabel'),'FontSize',28);%图上文字为8 point或小5号
set(get(gca,'YLabel'),'FontSize',28);
%% 震级震中距二位分布
histogram2(D(:,1),D(:,2))
xlabel('震级')
ylabel('震中距(km)')
zlabel('频数')
set(gca,'FontSize',22)
%% PGVE与宕机，无规律
!绘制PGV与宕机情况的关系
D102 = vertcat(Dbinary(1:10),Dbinary(12:26),Dbinary(2:26),Dbinary,Dbinary)
scatter(PGV_E,D102,100,'b','o')
set(gca,'XScale','log','FontSize',20)
xlabel('PGV_E(um/s)')
ylabel('宕机（1/0）')
%% PGVN与宕机，无规律
D102 = vertcat(Dbinary(1:10),Dbinary(12:26),Dbinary(2:26),Dbinary,Dbinary)
scatter(PGV_N,D102,100,'b','o')
set(gca,'XScale','log','FontSize',20)
xlabel('PGV_N(um/s)')
ylabel('宕机（1/0）')
%% PGVZ与宕机，无规律
D102 = vertcat(Dbinary(1:10),Dbinary(12:26),Dbinary(2:26),Dbinary,Dbinary)
scatter(PGV_N,D102,100,'b','o')
set(gca,'XScale','log','FontSize',20)
xlabel('PGV_Z(um/s)')
ylabel('宕机（1/0）')
%% 频谱图的尝试？
fs = 100
t = 0:1/fs:length(data1{1})/100; % 时间向量
N = length(data1{1}); % 信号长度
XX = fft(data1{1})/N; % 对信号进行傅里叶变换并除以信号长度得到归一化的频域信号
f = (0:N-1)*(fs/N); % 计算频率向量
figure;
plot(f, 2*abs(XX)); % 绘制幅度谱图
xlabel('Frequency (Hz)'); % 设置 x 轴标签
ylabel('Amplitude'); % 设置 y 轴标签
title('Frequency Domain Signal'); % 设置图标题

N = length(XX);
fshift = (-N/2:N/2-1)*(fs/N);
yshift = fftshift(XX);
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
%% 频谱图的尝试
% 生成时域信号
fs = 1000; % 采样频率
t = 0:1/fs:1-1/fs; % 时间向量
f1 = 50; % 信号频率1
f2 = 120; % 信号频率2
xx = 2*sin(2*pi*f1*t) + 0.5*sin(2*pi*f2*t); % 时域信号

% 进行傅里叶变换
N = length(xx); % 信号长度
XX = fft(xx)/N; % 对信号进行傅里叶变换并除以信号长度得到归一化的频域信号
f = (0:N-1)*(fs/N); % 计算频率向量

% 绘制频域信号幅度谱图
figure;
plot(f, 2*abs(XX)); % 绘制幅度谱图
xlabel('Frequency (Hz)'); % 设置 x 轴标签
ylabel('Amplitude'); % 设置 y 轴标签
title('Frequency Domain Signal'); % 设置图标题

N = length(XX);
fshift = (-N/2:N/2-1)*(fs/N);
yshift = fftshift(XX);
plot(fshift,abs(yshift))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
%% 好啊1
Dequ0 = find(D(:,3)==0)
Dnotequ0 = find(D(:,3)~=0)
scatter(D(Dequ0,1),D(Dequ0,2),130,'b','o')
hold on
scatter(D(Dnotequ0,1),D(Dnotequ0,2),130,'r','x')
xlabel('震级')
ylabel('震中距')

set(gca,'FontSize',20)
title('')
hold on
XXX = linspace(5,8.5)
BJ = XXX .* 2.1563 ./ 0.0016 - 10.9353 ./ 0.0016
plot(XXX,BJ)
legend('未宕机','宕机','决策边界','FontSize',20)

% ylim([0,inf])
% txt = '-10.9353 + 2.1563x - 0.0016y = 0 \rightarrow';
% text(7.7 , 3572.58,txt,'HorizontalAlignment','right','FontSize',20)
%% 半成品
Dequ0 = find(D26(:,3)==0)
Dnotequ0 = find(D26(:,3)~=0)
scatter(D26(Dequ0,1),D26(Dequ0,2),150,'b','o','LineWidth',2)
hold on
scatter(D26(Dnotequ0,1),D26(Dnotequ0,2),150,'r','x','LineWidth',2)
xlabel('震级')
ylabel('震中距')
legend('未宕机','宕机','FontSize',20)
set(gca,'FontSize',20)
set(findall(gca, 'Type', 'Line'), 'LineWidth', 100); % 设置线条宽度为 2
title('')

%% 好啊2
Dequ0 = find(D26(:,3)==0)
Dnotequ0 = find(D26(:,3)~=0)
scatter(D26(Dequ0,1),D26(Dequ0,2),150,'b','o','LineWidth',2)
hold on
scatter(D26(Dnotequ0,1),D26(Dnotequ0,2),150,'r','x','LineWidth',2)
xlabel('震级')
ylabel('震中距')
hold on
XXX = linspace(5,8.5)
BJ = XXX .* 2.1563 ./ 0.0016 - 10.9353 ./ 0.0016
plot(XXX,BJ)
legend('未宕机','宕机','决策边界','FontSize',20)
set(gca,'FontSize',20)
set(findall(gca, 'Type', 'Line'), 'LineWidth', 3); % 设置线条宽度为 3
title('')
ylim([0,inf])
txt = '-10.9353 + 2.1563x - 0.0016y = 0 \rightarrow';
text(7.7 , 3572.58,txt,'HorizontalAlignment','right','FontSize',20)
%%
%% 好啊3
Dequ0 = find(D26(:,3)==0)
Dnotequ0 = find(D26(:,3)~=0)
scatter(D26(Dequ0,1),D26(Dequ0,2),150,'b','o','LineWidth',2)
hold on
scatter(D26(Dnotequ0,1),D26(Dnotequ0,2),150,'r','x','LineWidth',2)
xlabel('震级')
ylabel('震中距')
hold on
XXX = linspace(5,8.5)
BJ = XXX .* 2.1563 ./ 0.0016 - 10.9353 ./ 0.0016
plot(XXX,BJ)
legend('未宕机','宕机','决策边界','FontSize',20)
set(gca,'FontSize',20)
set(findall(gca, 'Type', 'Line'), 'LineWidth', 3); % 设置线条宽度为 3
title('')
ylim([0,inf])
txt = '-10.9353 + 2.1563x - 0.0016y = 0 \rightarrow';
%% 无规律
Dequ0 = find(D26(:,3)==0)
Dnotequ0 = find(D26(:,3)~=0)
scatter(D26(Dequ0,1),D26_4(Dequ0,3),150,'b','o')
set(gca,'YScale','log','FontSize',20)
hold on
scatter(D26(Dnotequ0,1),D26_4(Dnotequ0,3),150,'r','x')
set(gca,'YScale','log','FontSize',20)
xlabel('震级')
ylabel('震源深度')
legend('未宕机','宕机','FontSize',20)
set(gca,'FontSize',20)
set(findall(gca, 'Type', 'Line'), 'LineWidth', 100); % 设置线条宽度为 2
title('')
%% 无规律
Dequ0 = find(D26(:,3)==0)
Dnotequ0 = find(D26(:,3)~=0)
scatter(D26(Dequ0,2),D26_4(Dequ0,3),150,'b','o','LineWidth',2)
set(gca,'YScale','log','FontSize',20)
hold on
scatter(D26(Dnotequ0,2),D26_4(Dnotequ0,3),150,'r','x','LineWidth',2)
set(gca,'YScale','log','FontSize',20)
xlabel('震中距')
ylabel('震源深度')
legend('未宕机','宕机','FontSize',20)
set(gca,'FontSize',20)
!set(gca,'LineWidth',10); % 设置线条宽度为 2
title('')
%% 不好看
!绘制三维散点图展示宕机情况
Dequ00 = find(D26_4(:,4)==0)
Dnotequ00 = find(D26_4(:,4)~=0)
scatter3(D26_4(Dequ00,1),D26_4(Dequ00,2),D26_4(Dequ00,3),130,'b','o')
set(gca,'ZScale','log','FontSize',20)
hold on
scatter3(D26_4(Dnotequ00,1),D26_4(Dnotequ00,2),D26_4(Dnotequ00,3),130,'r','x')
set(gca,'ZScale','log','FontSize',20)
%% 比较
addpath('C:\Users\wty\Documents\MATLAB\IntensityMeasure\sac_reader');
load('IM.mat', 'sorted_PGVE','sorted_PGVN','sorted_PGVZ')
sorted_PGV_E = sort(PGV_E);
sorted_PGV_N = sort(PGV_N);
sorted_PGV_Z = sort(PGV_Z);
save('matlab_CIER.mat','sorted_PGVZ',"sorted_PGVN","sorted_PGVE")
c = corrcoef(sorted_PGVE, sorted_PGV_E);
disp(['The correlation coefficient of PGV in EW is ', num2str(c(1,2))]);
c = corrcoef(sorted_PGVN, sorted_PGV_N);
disp(['The correlation coefficient of PGV in NS is ', num2str(c(1,2))]);
c = corrcoef(sorted_PGVZ, sorted_PGV_Z);
disp(['The correlation coefficient of PGV in Z is ', num2str(c(1,2))]);

