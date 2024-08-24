%
clear all; clc

figure(11)
% time = [0.058, 0.371, 0.0146, 7.61, 0; 1.52, 6.05, 3.61, 3.23, 0; 0.089, 39.59, 0.012, 0.26,0.23; 0.05, 2.93, 0.01, 0.28, 0.21];
% time = time./(sum(time,2) * ones(1,5));
time = [0.0072, 0.0461,  0.0018,  0.9449,  0; 0.1055, 0.4198, 0.2505, 0.2241, 0; 0.0022,  0.9853, 0.0003, 0.0065, 0.0057; 0.0144, 0.8420, 0.0029, 0.0805, 0.0603]
bar({'MNIST-USPS', 'QMUL', 'Multiview3D', 'COVID19'}, time);
% tiledlayout(1, 2)

set(gcf,'color','white'); %窗口背景白色
backColor = [0.9843, 1.0000,0.9490];
set(gca, 'color', backColor); %窗口背景白色
set(gca,'looseInset',[0 0 0 0]);
set(gca,'ticklength',[0 0]);
set(gca,'FontSize',12);
set(gcf, 'unit', 'centimeters', 'position', [15 10 13 7]);
ylabel('time (s)')
grid on;
ax = gca;
ax.GridColor = [0.7529    0.7529    0.7529];
ax.LineWidth = 1;
lgd = legend({'B2DMvDA','MvDA','2DLDA','(2D)^2LDA', '2DMvDA'},'Location','north');
lgd.NumColumns = 4;

% export_fig time_comparsion_2.eps 


