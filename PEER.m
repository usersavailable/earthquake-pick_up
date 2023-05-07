path = 'C:\Users\wty\Downloads\PEERNGARecords_Unscaled (2)';
namelist = dir([path,'*.AT2']);
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
x=cell2mat(data1);%由元胞数组转化为矩阵

%%读取数据
data = load('C:\Users\wty\Downloads\PEERNGARecords_Unscaled_mine\RSN777_LOMAP_HCH090_copy.AT2','-ascii');
data = data'
data = reshape(data,1,[])

%time = [0:0.005:0.005*7829]
%plot(time,data)

%%调幅
PGA = max(data)
%data_tiaofu = data .*0.3 ./PGA
%plot(time,data_tiaofu)

