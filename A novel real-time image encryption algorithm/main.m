% A novel real-time image encryption algorithm based on newly designed 1D cascaded hcaotic map
% Author: Q. Y. Wang
% Date:   July 15, 2024

clc;
clear;
close all;

% call functions
addpath(genpath('./figures')); 
addpath(genpath('./chaotic_system')); 
addpath(genpath('./permutation')); 
addpath(genpath('./finite_diffusion'));
addpath(genpath('./performance_metrics/'));

% load plain image
% plain_image = imread('Aerial.tiff');
plain_image = imread('bird.tif');
% plain_image = imread('camera.tif');
% plain_image = imread('chemical_plant.tiff');
% plain_image = imread('goldhill.tif');
% plain_image = imread('lena.tif');
% plain_image = imread('moon_surface.tiff');
% plain_image = imread('text.tif');

[M,N] = size(plain_image);
plain_image = double(plain_image);

% figure();
% imshow(uint8(plain_image));
% f = gcf;  
% exportgraphics(f,'aerial_plain.eps');

%% 生成GF(2^8)域的加法运算表和GF(257)域的乘法运算表
TBL = GF2p8Table();
TBL_multi = GF257Table();

%% 加密
t_total = tic;
% 产生混沌序列
t_chaotic_sequence = tic;
Hash_value_Hex = Hash_Function(plain_image);
Hash_value_Decimal = Hash_Hex_to_Decimal(Hash_value_Hex);
[X1,X2] = chaotic_system(Hash_value_Decimal,M,N);
tChaoticSequence = toc(t_chaotic_sequence);
% 矩阵转换成向量
t_matrix2vector = tic;
plain_image_vector = plain_image(:);
tMatrix2vector = toc(t_matrix2vector);
% 置乱
t_permutation = tic;
permuted_image_vector = forwardSattolo(plain_image_vector,X1);
tPermutation = toc(t_permutation);
% 扩散
t_diffusion = tic;
diffused_image_vector = diffusion(permuted_image_vector,X1,X2,X2,M,N,TBL,TBL_multi);
tDiffusion = toc(t_diffusion);
% 向量转换成矩阵
t_vector2matrix = tic;
encrypted_image = reshape(diffused_image_vector,M,N);
tVector2matrix = toc(t_vector2matrix);
tTotal = toc(t_total);

% figure();
% imshow(uint8(encrypted_image));
% f = gcf;  
% exportgraphics(f,'aerial_cipher.eps');

%% 解密
% 矩阵转换向量
encrypted_image_vector = encrypted_image(:);
% 逆扩散
reversely_diffused_image = reverse_diffusion(encrypted_image_vector,X1,X2,X2,M,N,TBL,TBL_multi);
% 逆置乱
reversely_permuted_image = inverseforwardSattolo(reversely_diffused_image,X1);
% 向量转换成矩阵
decrypted_image = reshape(reversely_permuted_image,M,N);

% figure();
% imshow(uint8(decrypted_image));
% f = gcf;  
% exportgraphics(f,'aerial_decryption.eps');

%% 安全性分析
% performance_metrics(plain_image,encrypted_image,decrypted_image,M,N,X1,X2,TBL,TBL_multi);

%% 运行时间分析
% fprintf('Time_chaotic_sequence = %f\n',tChaoticSequence);
% fprintf('Time_matrix2vector = %f\n',tMatrix2vector);
% fprintf('Time_permutation = %f\n',tPermutation);
% fprintf('Time_diffusion = %f\n',tDiffusion);
% fprintf('Time_vector2matrix = %f\n',tVector2matrix);
fprintf('Time_total = %f\n',tChaoticSequence+tMatrix2vector+tPermutation+tDiffusion+tVector2matrix);
% fprintf('Time_total = %f\n',tTotal);
