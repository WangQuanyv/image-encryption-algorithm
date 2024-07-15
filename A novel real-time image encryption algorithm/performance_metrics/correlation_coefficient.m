% 函数功能：计算图像相邻像素之间的相关系数
% 输入:  image:图像
% 输出:  r_h:水平方向上相邻像素之间的相关系数
%        r_v:水平方向上相邻像素之间的相关系数
%        r_d:水平方向上相邻像素之间的相关系数
% Author： Q. Y. Wang
% Date：   May 13, 2024

function [r_h,r_v,r_d] = correlation_coefficient(image)
%% 计算相关系数

N = 20000; % N是指从图像中随机选取的相邻的像素点对的个数
image = double(image);
[m,n] = size(image);

x1 = mod(floor(rand(1,N)*10^10),m-1)+1;
x2 = mod(floor(rand(1,N)*10^10),m)+1;
y1 = mod(floor(rand(1,N)*10^10),n-1)+1;
y2 = mod(floor(rand(1,N)*10^10),n)+1;

u1 = zeros(1,N);
u2 = zeros(1,N);
u3 = zeros(1,N);
v1 = zeros(1,N);
v2 = zeros(1,N);
v3 = zeros(1,N);

for i = 1:N
    u1(i) = image(x1(i),y2(i));
    v1(i) = image(x1(i)+1,y2(i));
    u2(i) = image(x2(i),y1(i));
    v2(i) = image(x2(i),y1(i)+1);
    u3(i) = image(x1(i),y1(i));
    v3(i) = image(x1(i)+1,y1(i)+1);
end

r_h = mean((u1-mean(u1)).*(v1-mean(v1)))/(std(u1,1)*std(v1,1));
r_v = mean((u2-mean(u2)).*(v2-mean(v2)))/(std(u2,1)*std(v2,1));
r_d = mean((u3-mean(u3)).*(v3-mean(v3)))/(std(u3,1)*std(v3,1));

%% 相关性分布图

axis1 = zeros(1,N);
axis2 = ones(1,N)*0.5;
axis3 = ones(1,N);

figure()
scatter3(axis1,u1(:),v1(:),10,'b.');
hold on;
scatter3(axis2,u2(:),v2(:),10,'b.');
hold on;
scatter3(axis3,u3(:),v3(:),10,'b.');
axis([0 1 0 255 0 255]) 
box on;  
ylabel('Pixel value','Rotation',-24,'fontsize', 10); 
zlabel('Adjacent pixel value','fontsize', 10); 

end