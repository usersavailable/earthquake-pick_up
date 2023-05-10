function [P1,fnew] = flourier(x)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
L = length(x);
y = fft(x);
f = (0:L-1)*Fs/L;
y = y/L;
P2 = abs(fft(x)/L);
P1 = P2(1:L/2);
P1(2:end-1) = 2*P1(2:end-1);
fnew = (0:(L/2-1))*Fs/L;
end

