% 函数功能： 十六进制数 转换成对应的 二进制数   比如：hex2bin('f'，4)  return string  '1111'    4表示指定返回二进制数的位数
% 输入： h:待转换的一个十六进制数  N:每一个16进制数 转换成 N bit二进制数   
% 输出： N bit 二进制数
function s= Hex2Bin(h,N)
    %HEX2BIN Convert hexdecimal string to a binary string.
    %   HEX2BIN(h) returns the binary representation of h as a string.
    %   
    %   Tamir Suliman
    %   HEX2BIN(h,n) produces a binary representation with at least
    %   N bits.
    %
    %   Example
    %      hex2bin('f') returns '1111'
    %      hex2bin('fa') returns '1111' '1010'
    %      hex2bin(['f' 'a'],4) returns 0010 1111
    %      
    %   See also BIN2DEC, DEC2HEX, DEC2BASE.
    %   
    %   This function implemented with the help  of  hex2dec and dec2bin
    %
    % Input checking
    %
    h = h(:);  % Make sure h is a column vector.
    h = upper(h); % Work in upper case.
    [m,n]=size(h);

    sixteen = 16;
    p = fliplr(cumprod([1 sixteen(ones(1,n-1))]));
    p = p(ones(m,1),:);

    s = h <= 64; % Numbers
    h(s) = h(s) - 48;

    s =  h > 64; % Letters
    h(s) = h(s) - 55;

    s = sum(h.*p,2);
    % Decimal  to Binary 
    d = double(s);

    % Actual algorithm
    [~,e] = log2(max(d)); % How many digits do we need to represent the numbers?
    s = char(rem(floor(d*pow2(1-max(N,e):0)),2)+'0');
end