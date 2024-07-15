% 函数功能： 将哈希函数产生的哈希值转换成10进制数
% 输入：哈希值（长度为64的十六进制字符串）
% 输出：32个十进制数，数据类型是double
function Key=Hash_Hex_to_Decimal(HashVal)                      
  
    n=length(HashVal)/2;                                      
    HashBin=Hex2Bin(HashVal,4);  % 调用 #自定义函数 Hex2Bin() #  4代表用四位一组的二进制数来表示一个十六进制的bit  例如：hex2bin('f'，4)  return string  '1111'
    HashBin=HashBin(:)';         % HexBin(:)将转换后的二进制数分别按列取出最后排成一个列向量，转置形成一个 行向量，行向量的大小是64*4=256bit二进制数
    HashDecimal=zeros(1,n);      % 预分配内存空间
    
    for i=1:1:n
        HashDecimal(i)=bin2dec(HashBin((i-1)*8+1:i*8));   % 8个一组二进制数进行划分，共得到32个十进制数
    end
    
    Key = HashDecimal;           % 十进制数进行异或（自动转换成二进制数，逐位进行异或），得到的结果仍然是十进制数  最后的结果过是32个十进制数 
end