function [x10,x20] = chaotic_system_sensitivity_x20(k,M,N)

% 设置外部密钥
xi1 = 7;
xi2 = 7;
xi3 = 0.4;
xi4 = 2;
xi5 = 8;
xi6 = 0.2;

% 混沌序列预分配内存空间
iters = M*N;
x10 = zeros(1,iters);
x20 = zeros(1,iters);

% 计算初始条件
gamma10 = xi1 + bitxor(bitxor(bitxor(k(1),k(3)),k(5)),k(7))/256;
eta10 = xi2 + bitxor(bitxor(bitxor(k(2),k(4)),k(6)),k(8))/256;
x10(1) = xi3 + bitxor((k(9)+k(11)+k(13)+k(15)),(k(10)+k(12)+k(14)+k(16)))/1024/10;
gamma20 = xi4 + bitxor(bitxor(bitxor(k(17),k(19)),k(21)),k(23))/256;
eta20 = xi5 + bitxor(bitxor(bitxor(k(18),k(20)),k(22)),k(24))/256;
x20(1)  = xi6 + bitxor((k(25)+k(27)+k(29)+k(31)),(k(26)+k(28)+k(30)+k(32)))/1024/10 + 10^(-14);   % 略微改变初始值x20

% 产生第一个混沌序列
for i=1:iters-1	
    x10(i+1) = sin(gamma10/x10(i) + (pi^eta10*x10(i)*exp(gamma10*(1-x10(i)))));
end

% 产生第二个混沌序列
for i=1:iters-1	
    x20(i+1) = sin(gamma20/x20(i) + (pi^eta20*x20(i)*exp(gamma20*(1-x20(i)))));
end

end