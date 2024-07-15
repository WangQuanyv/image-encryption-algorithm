% 循环移位
% 输入：x:需要移位的数 k:需要移多少位  k>0表示左移，k<0表示右移
% 输出：y:移位后的数
% Author: Q. Y. Wang
% Date:   June 2, 2023

function y = BitCircShift(x,k)
  
    if abs(k)>7 || k==0
        y = x;
        return;
    end

    if k>0 
        t1 = mod(x*pow2(k),256);
        t2 = floor(x/pow2(8-k));
    else
        t1 = floor(x*pow2(k));
        t2 = mod(x,pow2(-k))*pow2(8+k);
    end

    y = t1 + t2;

end