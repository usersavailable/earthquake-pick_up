path ='C:\Users\wty\Downloads\百度网盘下载\SAMSUNG28地震_SAC\SAMSUNG-vel\201411221655 _SAC';
Files= dir(strcat(path,'\*.SAC'));%这是要改的文件名的目录，我的是xlsx文件

for i=1:9    
    x1=Files(i).name;%取出第一个文件的名称         
    parts = strsplit(x1, '.');
    station = parts{8};
    channel = parts{10}(3); % 第9个部分的第2个字符

    a = sprintf('data%s_%s',channel,station);%类似h0001a为前缀的命名方式，数字依次递增     
       
    
    copyfile(fullfile(path,x1),['C:\Users\wty\Documents\MATLAB\cier\宕机1\' a]);%复制到a处理好的数据"文件夹中
end  
