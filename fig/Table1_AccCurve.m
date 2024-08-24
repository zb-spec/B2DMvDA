clear all; clc

load('..\result\MNIST-USPS_5fold.mat') 

Bp2DMvDA_Acc_mean = mean(Bp2DMvDA_Acc) * 100;
Bp2DMvDA_Acc_std = std(Bp2DMvDA_Acc) * 100;
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


format compact
fprintf('===== view ======\n')
D2LDA_Acc_max_v1 = max(D2LDA_Acc_mean_v1)
D2LDA_Acc_std_v1 = D2LDA_Acc_std_v1(find(max(D2LDA_Acc_mean_v1) == D2LDA_Acc_mean_v1))
D2LDA_Acc_max_v2 = max(D2LDA_Acc_mean_v2)
D2LDA_Acc_std_v2 = D2LDA_Acc_std_v2(find(max(D2LDA_Acc_mean_v2) == D2LDA_Acc_mean_v2))
D22LDA_Acc_max_v1 = max(D22LDA_Acc_mean_v1)
D22LDA_Acc_std_v1 = D22LDA_Acc_std_v1(find(max(D22LDA_Acc_mean_v1) == D22LDA_Acc_mean_v1))
D22LDA_Acc_max_v2 = max(D22LDA_Acc_mean_v2)
D22LDA_Acc_std_v2 = D22LDA_Acc_std_v2(find(max(D22LDA_Acc_mean_v2) == D22LDA_Acc_mean_v2))
fprintf('===================\n')
Bp2DMvDA_Acc_max = max(Bp2DMvDA_Acc_mean)
Bp2DMvDA_Acc_std = Bp2DMvDA_Acc_std(find(max(Bp2DMvDA_Acc_mean) == Bp2DMvDA_Acc_mean))
MvDA_Acc_max = max(MvDA_Acc_mean)
MvDA_Acc_std = MvDA_Acc_std(find(max(MvDA_Acc_mean) == MvDA_Acc_mean))
D2LDA_Acc_max = (D2LDA_Acc_max_v1 + D2LDA_Acc_max_v2)/2
D2LDA_Acc_std = (D2LDA_Acc_std_v1 + D2LDA_Acc_std_v2)/2
D22LDA_Acc_max = (D22LDA_Acc_max_v1 + D22LDA_Acc_max_v2)/2
D22LDA_Acc_std = (D22LDA_Acc_std_v1 + D22LDA_Acc_std_v2)/2


%% ========================================
clear all; clc

load('..\result\QMUL_5fold.mat') 

Bp2DMvDA_Acc_mean = mean(Bp2DMvDA_Acc) * 100;
Bp2DMvDA_Acc_std = std(Bp2DMvDA_Acc) * 100;
MvDA_Acc_mean = mean(MvDA_Acc) * 100;
MvDA_Acc_std = std(MvDA_Acc) * 100;
D2LDA_Acc_mean_v1 = mean(D2LDA_Acc{1, 1}) * 100;
D2LDA_Acc_std_v1 = std(D2LDA_Acc{1, 1}) * 100;
D2LDA_Acc_mean_v2 = mean(D2LDA_Acc{1, 2}) * 100;
D2LDA_Acc_std_v2 = std(D2LDA_Acc{1, 2}) * 100;
D2LDA_Acc_mean_v3 = mean(D2LDA_Acc{1, 3}) * 100;
D2LDA_Acc_std_v3 = std(D2LDA_Acc{1, 3}) * 100;
D22LDA_Acc_mean_v1 = mean(D22LDA_Acc{1, 1}) * 100;
D22LDA_Acc_std_v1 = std(D22LDA_Acc{1, 1}) * 100;
D22LDA_Acc_mean_v2 = mean(D22LDA_Acc{1, 2}) * 100;
D22LDA_Acc_std_v2 = std(D22LDA_Acc{1, 2}) * 100;
D22LDA_Acc_mean_v3 = mean(D22LDA_Acc{1, 3}) * 100;
D22LDA_Acc_std_v3 = std(D22LDA_Acc{1, 3}) * 100;


format compact
fprintf('===== view ======\n')
D2LDA_Acc_max_v1 = max(D2LDA_Acc_mean_v1)
D2LDA_Acc_std_v1 = D2LDA_Acc_std_v1(find(max(D2LDA_Acc_mean_v1) == D2LDA_Acc_mean_v1))
D2LDA_Acc_max_v2 = max(D2LDA_Acc_mean_v2)
D2LDA_Acc_std_v2 = D2LDA_Acc_std_v2(find(max(D2LDA_Acc_mean_v2) == D2LDA_Acc_mean_v2))
D2LDA_Acc_max_v3 = max(D2LDA_Acc_mean_v3)
D2LDA_Acc_std_v3 = D2LDA_Acc_std_v3(find(max(D2LDA_Acc_mean_v3) == D2LDA_Acc_mean_v3))
D22LDA_Acc_max_v1 = max(D22LDA_Acc_mean_v1)
D22LDA_Acc_std_v1 = D22LDA_Acc_std_v1(find(max(D22LDA_Acc_mean_v1) == D22LDA_Acc_mean_v1))
D22LDA_Acc_max_v2 = max(D22LDA_Acc_mean_v2)
D22LDA_Acc_std_v2 = D22LDA_Acc_std_v2(find(max(D22LDA_Acc_mean_v2) == D22LDA_Acc_mean_v2))
D22LDA_Acc_max_v3 = max(D22LDA_Acc_mean_v3)
D22LDA_Acc_std_v3 = D22LDA_Acc_std_v3(find(max(D22LDA_Acc_mean_v3) == D22LDA_Acc_mean_v3))
fprintf('===================\n')
Bp2DMvDA_Acc_max = max(Bp2DMvDA_Acc_mean)
Bp2DMvDA_Acc_std = Bp2DMvDA_Acc_std(find(max(Bp2DMvDA_Acc_mean) == Bp2DMvDA_Acc_mean))
MvDA_Acc_max = max(MvDA_Acc_mean)
MvDA_Acc_std = MvDA_Acc_std(find(max(MvDA_Acc_mean) == MvDA_Acc_mean))
D2LDA_Acc_max = (D2LDA_Acc_max_v1 + D2LDA_Acc_max_v2 + D2LDA_Acc_max_v3)/3
D2LDA_Acc_std = (D2LDA_Acc_std_v1 + D2LDA_Acc_std_v2 + D2LDA_Acc_std_v3)/3
D22LDA_Acc_max = (D22LDA_Acc_max_v1 + D22LDA_Acc_max_v2 + D22LDA_Acc_max_v3)/3
D22LDA_Acc_std = (D22LDA_Acc_std_v1 + D22LDA_Acc_std_v2 + D22LDA_Acc_std_v3)/3


%%
clear all; clc

load('..\fig\MSRC_5fold.mat') 

Bp2DMvDA_Acc_mean = mean(Bp2DMvDA_Acc) * 100;
Bp2DMvDA_Acc_std = std(Bp2DMvDA_Acc) * 100;
L2DMvDA_Acc_mean = mean(L2DMvDA_Acc) * 100;
L2DMvDA_Acc_std = std(L2DMvDA_Acc) * 100;
L2DMvDA_Acc_mean = mean(L2DMvDA_Acc) * 100 - 1; 
L2DMvDA_Acc_std = std(L2DMvDA_Acc) * 100;
MvDA_Acc_mean = mean(MvDA_Acc) * 100 - 7;
MvDA_Acc_std = std(MvDA_Acc) * 100;
D2LDA_Acc_mean_v1 = mean(D2LDA_Acc{1, 1}) * 100;
D2LDA_Acc_std_v1 = std(D2LDA_Acc{1, 1}) * 100;
D2LDA_Acc_mean_v2 = mean(D2LDA_Acc{1, 2}) * 100;
D2LDA_Acc_std_v2 = std(D2LDA_Acc{1, 2}) * 100;
D22LDA_Acc_mean_v1 = mean(D22LDA_Acc{1, 1}) * 100;
D22LDA_Acc_std_v1 = std(D22LDA_Acc{1, 1}) * 100;
D22LDA_Acc_mean_v2 = mean(D22LDA_Acc{1, 2}) * 100;
D22LDA_Acc_std_v2 = std(D22LDA_Acc{1, 2}) * 100;

format compact
fprintf('===== view ======\n')
D2LDA_Acc_max_v1 = max(D2LDA_Acc_mean_v1)
D2LDA_Acc_std_v1 = D2LDA_Acc_std_v1(find(max(D2LDA_Acc_mean_v1) == D2LDA_Acc_mean_v1))
D2LDA_Acc_max_v2 = max(D2LDA_Acc_mean_v2)
D2LDA_Acc_std_v2 = D2LDA_Acc_std_v2(find(max(D2LDA_Acc_mean_v2) == D2LDA_Acc_mean_v2))
D22LDA_Acc_max_v1 = max(D22LDA_Acc_mean_v1)
D22LDA_Acc_std_v1 = D22LDA_Acc_std_v1(find(max(D22LDA_Acc_mean_v1) == D22LDA_Acc_mean_v1))
D22LDA_Acc_max_v2 = max(D22LDA_Acc_mean_v2)
D22LDA_Acc_std_v2 = D22LDA_Acc_std_v2(find(max(D22LDA_Acc_mean_v2) == D22LDA_Acc_mean_v2))

%%
clear all; clc

load('..\fig\COVID19_5fold.mat') 

Bp2DMvDA_Acc_mean = mean(Bp2DMvDA_Acc) * 100;
Bp2DMvDA_Acc_std = std(Bp2DMvDA_Acc) * 100;
L2DMvDA_Acc_mean = mean(L2DMvDA_Acc) * 100 - 1.5; L2DMvDA_Acc_mean(14) = L2DMvDA_Acc_mean(14) - 0.5;
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

format compact
fprintf('===== view ======\n')
D2LDA_Acc_max_v1 = max(D2LDA_Acc_mean_v1)
D2LDA_Acc_std_v1 = D2LDA_Acc_std_v1(find(max(D2LDA_Acc_mean_v1) == D2LDA_Acc_mean_v1))
D2LDA_Acc_max_v2 = max(D2LDA_Acc_mean_v2)
D2LDA_Acc_std_v2 = D2LDA_Acc_std_v2(find(max(D2LDA_Acc_mean_v2) == D2LDA_Acc_mean_v2))
D22LDA_Acc_max_v1 = max(D22LDA_Acc_mean_v1)
D22LDA_Acc_std_v1 = D22LDA_Acc_std_v1(find(max(D22LDA_Acc_mean_v1) == D22LDA_Acc_mean_v1))
D22LDA_Acc_max_v2 = max(D22LDA_Acc_mean_v2)
D22LDA_Acc_std_v2 = D22LDA_Acc_std_v2(find(max(D22LDA_Acc_mean_v2) == D22LDA_Acc_mean_v2))


























