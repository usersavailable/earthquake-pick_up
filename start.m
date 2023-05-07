function start_index = start(data,threshold)
start_index = 0;
for i = 1:length(data)-500
    if all(data(i:i+500) > threshold)
        start_index = i;
        break
    end
end
end
