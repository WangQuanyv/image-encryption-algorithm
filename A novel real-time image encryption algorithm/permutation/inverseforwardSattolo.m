% Sattolo's inverse shuffling
% Author: Q. Y. Wang
% Date:   July 15, 2024

function shuffledArray = inverseforwardSattolo(arr,chaotic_sequence)
    n = length(arr);

    % 产生随机数种子序列
    chaotic_sequence_integer = mod(floor((chaotic_sequence+100)*10^10),10*n)+1;
    seed = zeros(1,n);
    
    for i = n:-1:2
       seed(i) = mod(chaotic_sequence_integer(i),i-1)+1;
    end
    
    for i = n:-1:2       
        temp = arr(i);
        arr(i) = arr(seed(i));
        arr(seed(i)) = temp;
    end
    
    shuffledArray = arr;  % 返回打乱后的数组
end