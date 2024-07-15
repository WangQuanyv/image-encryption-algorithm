% 基于GF(2^8)域的加法运算函数
function y = LookUpGF2p8(x0,x1,TBL)
      y = TBL(x0+1,x1+1);
end