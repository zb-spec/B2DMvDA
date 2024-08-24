%% ===== MNIST-USPS =====
clear all; clc
load('..\Data\MNIST-USPS.mat'); 

figure(1)
total_snample_num = 20;
plot_fig = tight_subplot(2, total_snample_num/2, [0,0],[0.01, 0.01], [0.13, 0.01]);
k = 1; ind = 10:110:1000;
for i = 1:(total_snample_num/2)
    axes(plot_fig(i));
    imshow(X{1, 1}(:,:,ind(i)));
end
for i = 11:total_snample_num
    axes(plot_fig(i));
    imshow(X{1, 2}(:,:,ind(i-10)));
end

set(gcf,'color','white'); %窗口背景白色
set(gca, 'color', 'white'); %窗口背景白色
set(gcf, 'unit', 'centimeters', 'position', [15 10 10.1 1.79]);
text(-167, -10, 'view1','Color','k','Fontsize', 14)
text(-167, 10, 'view2','Color','k','Fontsize', 14)

% export_fig Sample_MNISTUSPS.eps 

%% ===== QMUL =====
clear all; clc
load('..\Data\QMUL.mat'); 

figure(2)
total_snample_num = 30;
plot_fig = tight_subplot(3, total_snample_num/3, [0,0],[0.01, 0.01], [0.13, 0.01]);
k = 1; 
for i = 1:10
    axes(plot_fig(i));
    imshow(X{1, 1}(:,:,i));
end
for i = 11:20
    axes(plot_fig(i));
    imshow(X{1, 2}(:,:,i-10));
end
for i = 21:30
    axes(plot_fig(i));
    imshow(X{1, 3}(:,:,i-20));
end


set(gcf,'color','white'); %窗口背景白色
set(gca, 'color', 'white'); %窗口背景白色
set(gcf, 'unit', 'centimeters', 'position', [15 10 9.6 2.7]);
text(-175, -25, 'view1','Color','k','Fontsize', 14)
text(-175, -8, 'view2','Color','k','Fontsize', 14)
text(-175, 9, 'view3','Color','k','Fontsize', 14)

% export_fig Sample_QMUL.eps 


%% ===== MSRC =====
clear all; clc
load('..\Data\MSRC.mat'); 

figure(3)
total_snample_num = 20;
plot_fig = tight_subplot(2, total_snample_num/2, [0,0],[0.01, 0.01], [0.13, 0.01]);
k = 1; ind = 10:110:1000;
for i = 1:10
    axes(plot_fig(i));
    imshow(X{1, 1}(:,:,i));
end
for i = 11:20
    axes(plot_fig(i));
    imshow(X{1, 2}(:,:,i-10));
end

set(gcf,'color','white'); %窗口背景白色
set(gca, 'color', 'white'); %窗口背景白色
set(gcf, 'unit', 'centimeters', 'position', [15 10 10.1 1.79]);
text(-500, -25, 'view1','Color','k','Fontsize', 14);
text(-500, 20, 'view2','Color','k','Fontsize', 14);

export_fig Sample_Multiview3D.eps 

%% ===== COVID19 =====
clear all; clc
load('..\Data\COVID19.mat'); 

figure(4)
total_snample_num = 20;
plot_fig = tight_subplot(2, total_snample_num/2, [0,0],[0.01, 0.01], [0.13, 0.01]);
k = 1; ind = 10:110:1000;
for i = 1:10
    axes(plot_fig(i));
    imshow(X{1, 1}(:,:,i));
end
for i = 11:20
    axes(plot_fig(i));
    imshow(X{1, 2}(:,:,i-10));
end

set(gcf,'color','white'); %窗口背景白色
set(gca, 'color', 'white'); %窗口背景白色
set(gcf, 'unit', 'centimeters', 'position', [15 10 10.1 1.79]);
text(-335, -15, 'view1','Color','k','Fontsize', 14);
text(-335, 15, 'view2','Color','k','Fontsize', 14);

export_fig Sample_COVID19.eps 






















