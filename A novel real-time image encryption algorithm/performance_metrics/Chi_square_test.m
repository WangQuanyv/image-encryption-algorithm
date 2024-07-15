% 函数功能：Chi-square test
% 输入： 明文图像 和 密文图像
% 输出： 明文图像 和 密文图像 的 Chi-square test结果
% 作者： 王全余
% 日期： 2021年12月10日

function [Chi_square_plain,Chi_square_cipher] = Chi_square_test(Original_image,Cipher_image)

[M,N] = size(Original_image);
g = M*N/256;

fp1 = hist(Original_image(:),256); 
Chi_square_plain = sum((fp1-g).^2)/g;

fc1 = hist(Cipher_image(:),256); 
Chi_square_cipher = sum((fc1-g).^2)/g;

end