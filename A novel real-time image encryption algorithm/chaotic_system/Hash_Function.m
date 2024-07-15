% 函数功能：产生哈希值
% SHA256算法:对于任意长度的消息，SHA256都会产生一个256bit长的哈希值，称作消息摘要。这个摘要相当于是个长度为32个字节的数组，通常用一个长度为64的十六进制字符串来表示。
% 输入：原始灰度图像像素矩阵
% 输出：对应的哈希值(长度为64的十六进制字符串)
function h = Hash_Function(source)                        

    source=source(:);                                      % 这个操作是把矩阵转换成一个列向量 （按照矩阵中元素的存储顺序排列）
    hashType = 'SHA-256';                                  % 选择哈希算法 SHA-256
    x=java.security.MessageDigest.getInstance(hashType);   % 调用Java中的哈希表
    x.update(source);                                      % 通过使用 update 方法处理数据,使指定的 byte数组更新摘要
    h=typecast(x.digest,'uint8');                          % 获得密文完成哈希计算,产生128 位的长整数  将 x.digest 转换成 unit8 数据类型
    h=dec2hex(h)';                                         % 10进制转16进制 注意这个是先转换成十六进制，后进行转置
    if(size(h,1))==1                                       % size(A,1)：获取矩阵A的行数；size（A，2）：获取矩阵A的列数。
        h=[repmat('0',[1 size(h,2)]);h];                   % 如果h的行数只有1行，那么根据其列数，在h的前一行补充全0 
    end                                                    % repmat('0',[1 6]) 创建1行6列全0的向量
    h=lower(h(:)');                                        % 大写转换成小写  h(:) 表示按照列取 排成一列
    clear x
    return                                                 % 跳出函数，返回调用函数 处

end