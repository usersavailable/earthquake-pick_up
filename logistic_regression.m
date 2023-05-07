% 数据导入velocitvelocit
XX = D26(:,[1:2])
yy = Dbinary

% % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % 绘制图像
% ax=gca;
% hold(ax,'on')
% plot(XX(yy==0,1),XX(yy==0,2),'ko','MarkerFaceColor','y','MarkerSize',7)  %找到未宕机的数据并用'o'画出
% plot(XX(yy==1,1),XX(yy==1,2),'k+','LineWidth',2,'MarkerSize',7)  %找到宕机数据并用'x'画出


degree=1;  %指定多项式的两变量阶数和
X_exp=ones(size(XX(:,1)));  %添加第一列数值为1
for i=1:degree
    for j=0:i
        X_exp(:,end+1)=(XX(:,1).^(i-j)).*(XX(:,2).^j);  %分别求得阶数和从1到degree的项x1^(i-j)*x2^j
    end
end

initial_theta=zeros(size(X_exp,2),1); %X_exp列数作为initial_theta行数
lambda=1;

% 设置条件并用自带函数寻找最优参数
%options = optimoptions('MaxIterations',400,'SpecifyObjectiveGradient','on')

options=optimset('Display','iter','GradObj','on','MaxIter',400);
[theta,J,exit_flag,output]= ...
	fminunc(@(t)(costFunctionReg(t,X_exp,yy,lambda)),initial_theta,options);

% % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% % 绘制分界曲线
% degree=1;
% X_sym=sym('1');
% for i=1:degree
%     for j=0:i
%         X_sym(:,end+1)=(sym('x').^(i-j)).*(sym('y').^j);
%     end
% end
% 
% Func=matlabFunction(1./(1+exp(X_sym*theta))-.5);
% fimplicit(Func,'LineWidth',2,'Color',[169,64,71]./255)

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% 将根据梯度下降法得出的预测结果与实际情况对比，并计算正确率
p=sigmoid(X_exp*theta)>.5;
ac=mean(double(p == yy))*100;
fprintf('准确率为: %f\n', ac);
fprintf('Theta参数为: %f\n',theta)
