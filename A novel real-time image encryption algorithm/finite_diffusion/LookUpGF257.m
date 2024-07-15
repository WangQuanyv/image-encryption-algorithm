% 基于GF(257)域的乘法运算函数
% 两个输入变量
function y = LookUpGF257(x0,x1,TBL)
     y = TBL(x0+2,x1+2)-1;
end