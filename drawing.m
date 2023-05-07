tata = DATA9(3).data.timehistory;

figure
for i =1:3
    for j =1:4
        subplot(3,4,i*4-4+j)
        plot(tata{i*4-4+j})
    end
end

%%
data = DATA_VEL(15).data(1).data.timehistory;
for k =1:nnz(data)
    figure()
