function diffused_image = diffusion(permuted_image,chaotic_sequence_1,chaotic_sequence_2,chaotic_sequence_3,M,N,TBL,TBL_multi)
    
    % 产生混沌图像序列
    chaotic_sequence_1 = mod(floor(chaotic_sequence_1*pow2(16)),256);
    chaotic_sequence_2 = mod(floor(chaotic_sequence_2*pow2(16)),256);
    chaotic_sequence_3 = mod(floor(chaotic_sequence_3*10^(10)),8);

    % 预分配内存空间
    diffused_image_add = zeros(1,M*N);
    diffused_image_mul = zeros(1,M*N);
    diffused_image = zeros(1,M*N);

    % 使用三个混沌序列进行扩散
    for i = 1:M*N
        diffused_image_add(i) = LookUpGF2p8(permuted_image(i),chaotic_sequence_1(i),TBL);                        % 加法
        diffused_image_mul(i) = LookUpGF257(diffused_image_add(i),chaotic_sequence_2(i),TBL_multi);              % 乘法
        diffused_image(i) = BitCircShift(diffused_image_mul(i),-chaotic_sequence_3(i));                          % 圆周移位        
    end

end