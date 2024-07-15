function [] = performance_metrics(I_gray,cipher_image,decrypted_image,M,N,X1,X2,TBL,TBL_multi)
%% Histogram
% figure()  
% imhist(uint8(I_gray));
% f = gcf;  
% exportgraphics(f,'histogram_aerial_plain.eps');
% figure() 
% imhist(uint8(cipher_image));
% f = gcf;  
% exportgraphics(f,'histogram_aerial_cipher.eps');

%% Chi-square test
% fprintf('\nThe results of Chi_square_test...\n');
% [Chi_square_plain,Chi_square_cipher] = Chi_square_test(I_gray,cipher_image);
% fprintf('Chi_square_plain = %f\n',Chi_square_plain);
% fprintf('Chi_square_cipher = %f\n',Chi_square_cipher);

%% Information entropy
% fprintf('\nEntropy of the PlainImage and EncryptedImage...');
% PlainImg_Entropy = entropy(uint8(I_gray)); 
% fprintf('\nPlainImage Entropy = %f',PlainImg_Entropy);          % 明文图像的信息熵
% EncImg_Entropy = entropy(uint8(cipher_image));
% fprintf('\nCipherImage Entropy = %f\n',EncImg_Entropy);         % 加密图像的信息熵
  
%% Correlation analysis
% fprintf('\nCorrelation Coefficient...\n');
% [r_h_plain,r_v_plain,r_d_plain] = correlation_coefficient(I_gray);
% fprintf('Plain image...\nHorizontal = %f; Vertical = %f; Diagonal = %f\n',r_h_plain,r_v_plain,r_d_plain);
% [r_h_cipher,r_v_cipher,r_d_cipher] = correlation_coefficient(cipher_image);
% fprintf('Cipher image...\nHorizontal = %f; Vertical = %f; Diagonal = %f\n',r_h_cipher,r_v_cipher,r_d_cipher);

%% Differential attacks
fprintf('\nDifferential attacks...')
PlainImg1bit = I_gray;  
PlainImg1bit = double(PlainImg1bit);
pos1 = 1+floor(rand(1)*M);  
pos2 = 1+floor(rand(1)*M);

fprintf('\nBefore change 1 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,PlainImg1bit(pos1,pos2));
PlainImg1bit(pos1,pos2) = mod(PlainImg1bit(pos1,pos2)+1,255);   
fprintf('\nAfter change 1 bit of PlainImage at location (%d,%d) = %d',pos1,pos2,PlainImg1bit(pos1,pos2));

Hash_value_Hex = Hash_Function(PlainImg1bit);                                    % hexadecimal hash value
Hash_value_Decimal = Hash_Hex_to_Decimal(Hash_value_Hex);                        % hexadecimal to decimal
[X1,X2] = chaotic_system(Hash_value_Decimal,M,N);
% 矩阵转换成向量
plain_image_vector = PlainImg1bit(:);
% 置乱
permuted_image_vector = forwardSattolo(plain_image_vector,X1);
% 扩散
diffused_image_vector = diffusion(permuted_image_vector,X1,X2,X2,M,N,TBL,TBL_multi);
% 向量转换成矩阵
encrypted_image_1bit = reshape(diffused_image_vector,M,N);

[npcr,uaci]= NPCR_UACI(uint8(cipher_image),uint8(encrypted_image_1bit));    % 计算 NPCR 和 UACI
fprintf('\nNPCR = %f   UACI=%f \n',npcr,uaci);
  
%% Key sensitivity
% fprintf('\nKey sensitivity analysis...\n')
% % 1) 控制参数发生微小变化
% % --加密--
% Hash_value_Hex = Hash_Function(I_gray);                                          
% Hash_value_Decimal = Hash_Hex_to_Decimal(Hash_value_Hex);                        
% [X1,X2] = chaotic_system_sensitivity_gamma1(Hash_value_Decimal,M,N);
% plain_image_vector = I_gray(:);
% permuted_image_vector = forwardSattolo(plain_image_vector,X1);
% diffused_image_vector = diffusion(permuted_image_vector,X1,X2,X2,M,N,TBL,TBL_multi);
% encrypted_image_mu1 = reshape(diffused_image_vector,M,N); 
% 
% % --解密--                                      
% [X1,X2] = chaotic_system_sensitivity_gamma2(Hash_value_Decimal,M,N);
% encrypted_image_vector = cipher_image(:);
% reversely_diffused_image = reverse_diffusion(encrypted_image_vector,X1,X2,X2,M,N,TBL,TBL_multi);
% reversely_permuted_image = inverseforwardSattolo(reversely_diffused_image,X1);
% decrypted_image_mu2 = reshape(reversely_permuted_image,M,N);
% 
% % 2) 初始值发生微小变化
% %--加密--
% [X1_x10,X2_x10] = chaotic_system_sensitivity_x10(Hash_value_Decimal,M,N);
% plain_image_vector_x10 = I_gray(:);
% permuted_image_vector_x10 = forwardSattolo(plain_image_vector_x10,X1_x10);
% diffused_image_vector_x10 = diffusion(permuted_image_vector_x10,X1_x10,X2_x10,X2_x10,M,N,TBL,TBL_multi);
% encrypted_image_x10 = reshape(diffused_image_vector_x10,M,N);
% 
% %--解密-- 
% [X1_x20,X2_x20] = chaotic_system_sensitivity_x20(Hash_value_Decimal,M,N);
% encrypted_image_vector_x20 = cipher_image(:);
% reversely_diffused_image_x20 = reverse_diffusion(encrypted_image_vector_x20,X1_x20,X2_x20,X2_x20,M,N,TBL,TBL_multi);
% reversely_permuted_image_x20 = inverseforwardSattolo(reversely_diffused_image_x20,X1_x20);
% decrypted_image_x20 = reshape(reversely_permuted_image_x20,M,N);
% 
% figure() 
% imshow(uint8(cipher_image));
% % f = gcf;  
% % exportgraphics(f,'cipher_sk0.eps');
% figure() 
% imshow(uint8(encrypted_image_mu1));
% % f = gcf;  
% % exportgraphics(f,'cipher_sk1.eps');
% figure() 
% imshow(uint8(encrypted_image_x10));
% % f = gcf;  
% % exportgraphics(f,'cipher_sk2.eps');
% 
% fprintf('Fig. b - Cipher = %f\n', sum(encrypted_image_mu1(:) ~= cipher_image(:))/(M*N));
% fprintf('Fig. c - Cipher = %f\n', sum(encrypted_image_x10(:) ~= cipher_image(:))/(M*N));
% 
% figure() 
% imshow(uint8(decrypted_image_mu2));
% % f = gcf;  
% % exportgraphics(f,'decryption_sk_3.eps');
% fprintf('Fig. g - Decrypted = %f\n', sum(decrypted_image_mu2(:) ~= decrypted_image(:))/(M*N));
% figure() 
% imshow(uint8(decrypted_image_x20));
% % f = gcf;  
% % exportgraphics(f,'decryption_sk_4.eps');
% fprintf('Fig. h - Decrypted = %f\n', sum(decrypted_image_x20(:) ~= decrypted_image(:))/(M*N));

%% Robustness
% Cropping attacks
% Crop=4;       
% EncImgCrop=cipher_image;
% if Crop==32
%     EncImgCrop(1:M/32,1:M)=0;
% elseif Crop==16
%     EncImgCrop(3*M/8:5*M/8,3*M/8:5*M/8)=0;
% elseif Crop==8
%     EncImgCrop(1:M/8,1:M/8)=0;
%     EncImgCrop(1:M/8,7*M/8:end)=0;
%     EncImgCrop(7*M/8:end,1:M/8)=0;
%     EncImgCrop(7*M/8:end,7*M/8:end)=0;
%     EncImgCrop(3*M/8:5*M/8,3*M/8:5*M/8)=0;
% elseif Crop==4
%     EncImgCrop(1:M,1:M/8)=0;
%     EncImgCrop(1:M,7*M/8:end)=0;
% elseif Crop==2
%     EncImgCrop(1:128,1:256)=0;
% end
% 
% encrypted_image_vector_crop = EncImgCrop(:);
% reversely_diffused_image_crop = reverse_diffusion(encrypted_image_vector_crop,X1,X2,X2,M,N,TBL,TBL_multi);
% reversely_permuted_image_crop = inverseforwardSattolo(reversely_diffused_image_crop,X1);
% decrypted_image_crop = reshape(reversely_permuted_image_crop,M,N);
% 
% figure()
% imshow(uint8(EncImgCrop));
% % f = gcf;  
% % exportgraphics(f,'cipher_crop_1_4.eps');
% figure()
% imshow(uint8(decrypted_image_crop));
% % f = gcf;  
% % exportgraphics(f,'decrypted_crop_1_4.eps');
% 
%  Noise attacks 
% NoiseLevel = 0.15; % 0.01  0.05  0.10  0.15
% EncImgNoise = double(imnoise(uint8(cipher_image),'salt & pepper',NoiseLevel));  % 加入椒盐噪声，其中 NoiseLevel 是噪声方差
% encrypted_image_vector_noise = EncImgNoise(:);
% reversely_diffused_image_noise = reverse_diffusion(encrypted_image_vector_noise,X1,X2,X2,M,N,TBL,TBL_multi);
% reversely_permuted_image_noise = inverseforwardSattolo(reversely_diffused_image_noise,X1);
% decrypted_image_noise = reshape(reversely_permuted_image_noise,M,N);
% 
% figure()
% imshow(uint8(EncImgNoise));
% % f = gcf;  
% % exportgraphics(f,'cipher_noise_015.eps');
% figure()
% imshow(uint8(decrypted_image_noise));
% % f = gcf;  
% % exportgraphics(f,'decrypted_noise_015.eps');

end