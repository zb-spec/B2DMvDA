clear all; clc

load('..\fig\MSRC_5fold.mat') 

Bp2DMvDA_Acc_mean = mean(Bp2DMvDA_Acc) * 100;
Bp2DMvDA_Acc_std = std(Bp2DMvDA_Acc) * 100;
L2DMvDA_Acc_mean = mean(L2DMvDA_Acc) * 100; 
L2DMvDA_Acc_std = std(L2DMvDA_Acc) * 100;
MvDA_Acc_mean = mean(MvDA_Acc) * 100;
MvDA_Acc_std = std(MvDA_Acc) * 100;
D2LDA_Acc_mean_v1 = mean(D2LDA_Acc{1, 1}) * 100;
D2LDA_Acc_std_v1 = std(D2LDA_Acc{1, 1}) * 100;
D2LDA_Acc_mean_v2 = mean(D2LDA_Acc{1, 2}) * 100;
D2LDA_Acc_std_v2 = std(D2LDA_Acc{1, 2}) * 100;
D22LDA_Acc_mean_v1 = mean(D22LDA_Acc{1, 1}) * 100;
D22LDA_Acc_std_v1 = std(D22LDA_Acc{1, 1}) * 100;
D22LDA_Acc_mean_v2 = mean(D22LDA_Acc{1, 2}) * 100;
D22LDA_Acc_std_v2 = std(D22LDA_Acc{1, 2}) * 100;

space2D = 1:16;  space1D = 5:5:110;
figure(1)
plot(space2D,Bp2DMvDA_Acc_mean,'r->','LineWidth',2,'MarkerSize',2); hold on
plot(1:14,L2DMvDA_Acc_mean,'g-','Marker','square','LineWidth',2,'MarkerSize',2); hold on
plot(space1D,MvDA_Acc_mean(5:5:110),'c-v','LineWidth',2,'MarkerSize',2); hold on
plot(space2D,(D2LDA_Acc_mean_v1 + D2LDA_Acc_mean_v2) / 2,'b-<','LineWidth',2,'MarkerSize',2); hold on
plot(space2D,(D22LDA_Acc_mean_v1 + D22LDA_Acc_mean_v2) / 2,'m-^','LineWidth',2,'MarkerSize',2); hold on


ylim([60,90]);

set(gcf,'color','white'); %窗口背景白色
backColor = [0.9843, 1.0000,0.9490];
set(gca, 'color', backColor); %窗口背景白色
set(gca,'looseInset',[0 0 0 0]);
set(gca,'ticklength',[0 0]);
set(gca,'FontSize',12);
set(gcf, 'unit', 'centimeters', 'position', [15 10 8.6 7.1]);
grid on;
ax = gca;
ax.GridColor = [0.7529    0.7529    0.7529];
ax.LineWidth = 1;
legend({'B2DMvDA', '2DMvDA','MvDA','2DLDA','(2D)^2LDA'},'Location','southeast')
xlabel('dimension');
ylabel('classification accuracy (%)')

% export_fig MSRC_ACC.eps 

% save('.\fig\MSRC_5fold', 'Bp2DMvDA_Acc', 'MvDA_Acc', 'D22LDA_Acc', 'D2LDA_Acc','L2DMvDA_Acc')
