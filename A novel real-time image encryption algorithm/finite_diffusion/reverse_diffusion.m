function diffused_image = reverse_diffusion(cipher_image,chaotic_sequence_1,chaotic_sequence_2,chaotic_sequence_3,M,N,TBL,TBL_multi)
    
    % 产生混沌图像序列
    chaotic_sequence_1 = mod(floor(chaotic_sequence_1*pow2(16)),256);
    chaotic_sequence_2 = mod(floor(chaotic_sequence_2*pow2(16)),256);
    chaotic_sequence_3 = mod(floor(chaotic_sequence_3*10^(10)),8);

    % 预分配内存空间
    diffused_image_shift = zeros(1,M*N);
    diffused_image_mul = zeros(1,M*N);
    diffused_image = zeros(1,M*N);

    % 使用三个混沌序列进行扩散
    for i = 1:M*N
        diffused_image_shift(i) = BitCircShift(cipher_image(i),chaotic_sequence_3(i));                             % 圆周移位      
        diffused_image_mul(i) = LookUpGF257Ex(diffused_image_shift(i),chaotic_sequence_2(i),TBL_multi);            % 除法
        diffused_image(i) = LookUpGF2p8Ex(diffused_image_mul(i),chaotic_sequence_1(i),TBL);                        % 减法
        
    end


end