% 基于GF(257)域的除法运算函数
% 两个输入变量
function y = LookUpGF257Ex(x0,x1,TBL)
     t = x1+2;
     y = find(TBL(t,:)==(x0+1))-2;
end