% 基于GF(2^8)域的减法运算函数
function y = LookUpGF2p8Ex(x0,x1,TBL)
      t = x1+1;
      y = find(TBL(t,:)==x0)-1;
end