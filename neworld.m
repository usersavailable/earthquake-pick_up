%% 
do = 1;


while(do == 1)
    earthquakepath = input('请输入文件路径(须带引号)：');
    earthquakepathE = input('请输入E向地震数据文件名(须带引号)：');
    earthquakepathN = input('请输入N向地震数据文件名(须带引号)：');
    earthquakepathZ = input('请输入Z向地震数据文件名(须带引号)：');
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
    
    [~,record1,h1] = fget_sac(fullfile(earthquakepath,earthquakepathE));
    [~,record2,h2] = fget_sac(fullfile(earthquakepath,earthquakepathN));
    [~,record3,h3] = fget_sac(fullfile(earthquakepath,earthquakepathZ));
    

    record1 = resample(record1,Fs1,Fs);  %对数据进行重采样，采样后数据长度为原来的1/5
    record2 = resample(record2,Fs1,Fs);
    record3 = resample(record3,Fs1,Fs);


    


    subplot(3,1,1)
    set(gca,'FontSize',20)
    t = 1:length(record1);
    t = t./Fs1;
    plot(t,record1)
    % xlim([0 length(record1)])
    xlabel('时间(s)')
    ylabel(type)
    title('BHE')
    hold on

    subplot(3,1,2)
    set(gca,'FontSize',20)
    t = 1:length(record1);
    t = t./Fs1;
    plot(t,record1)
    % xlim([0 length(record1)])
    xlabel('时间(s)')
    ylabel(type)
    title('BHN')
    hold on

    subplot(3,1,3)
    set(gca,'FontSize',20)
    t = 1:length(record1);
    t = t./Fs1;
    plot(t,record1)
    % xlim([0 length(record1)])
    xlabel('时间(s)')
    ylabel(type)
    title('BHZ') 
    hold on

    do = input('是否继续？(1/0)');
end