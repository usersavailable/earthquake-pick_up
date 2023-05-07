% 梯度及代价值计算函数
function [J,grad]=costFunctionReg(theta,X,y,lambda)
m=length(y);

h_theta=sigmoid(X*theta);

J=sum(-y.*log(h_theta)-(1-y).*log(1-h_theta))/m+sum(theta(2:end).^2)*lambda/2/m;

grad=(sum((h_theta-y).*X,1)./m)'+[0;theta(2:end).*lambda./m];
end

