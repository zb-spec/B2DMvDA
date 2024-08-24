function [W_LDA, W_lda] = MvDA(X_multiview,Label_multiview, d)
num_class = length(unique(Label_multiview{1}));
num_view = size(X_multiview,2);
% dim = size(X_multiview{1},1);
%% ************** Sjr ********************************************
A = cell(num_view,3);
for vi = 1:num_view
    Xi = GetEachClass(X_multiview{vi},Label_multiview{vi},'x');
    Mi = GetEachClass(X_multiview{vi},Label_multiview{vi},'m');
    Numi = GetEachClass(X_multiview{vi},Label_multiview{vi},'num');
    A{vi,1} = Xi; % For the vi-th view, Xi is a cell of size 1*m which contains all the i-th vector, where m is the number of samples, and each cell is a n*1 sample vector. 
    A{vi,2} = Mi; % For the vi-th view, Mi is a matrix of size n*c which contains mean of the i-th class, where n is vector dimension, c is the number of classes.
    A{vi,3} = Numi; % For the vi-th view, Numi contains the number of samples in each class, is of length c.
end
Ni = zeros(1,num_class);
dim = zeros(1,num_view);
for i=1:num_view
%     Ni = Ni + A{vi,3}; Mistake???
    Ni = Ni + A{i,3}; % For all the view, Ni contains the number of samples in each class, is of length c.
    dim(i) = size(X_multiview{i},1); % dim(i) is the sample dimension in the i-th view. dim is of length num_view
end
%% *********** LDA SW *******************************************
Sw = zeros(sum(dim),sum(dim));
for i=1:num_view
    Numi = A{i,3};
    Mi  = A{i,2};
    for j=i:num_view
        Numj = A{j,3};
        Mj = A{j,2};
        Xj = A{j,1};
        sij = zeros(dim(i),dim(j));
        vij = zeros(dim(j),dim(j));
        for ci = 1:num_class
            sij = sij - (Numi(ci)*Numj(ci)/Ni(ci))*(Mi(:,ci)*Mj(:,ci)');
            vij = vij + Xj(:,ci) * (Xj(:,ci)');
        end
        if j==i
            sij = vij + sij;
        end
        
        Sw(sum(dim(1:i-1))+1:sum(dim(1:i)), sum(dim(1:j-1))+1:sum(dim(1:j))) = sij;
        Sw(sum(dim(1:j-1))+1:sum(dim(1:j)), sum(dim(1:i-1))+1:sum(dim(1:i))) = sij';
    end
end
    
%% *********** LDA SB *******************************************
Sb = zeros(sum(dim),sum(dim));
n = sum(Ni); % number of all the samples.

for i=1:num_view
    mi = sum(X_multiview{i},2);
    Mi  = A{i,2};
    Numi = A{i,3};
    for j=i:num_view
        Numj = A{j,3};
        Mj = A{j,2};
        sij = zeros(dim(i),dim(j));
        
        mj = sum(X_multiview{j},2);
        for ci = 1:num_class
            sij = sij + (Numi(ci)*Numj(ci)/Ni(ci))*(Mi(:,ci)*Mj(:,ci)');
        end
        sij = sij - mi*mj'/n; % mi*mj' should be (Numi(ci)*mi)*(Numj(ci)*mj)'? 
        Sb(sum(dim(1:i-1))+1:sum(dim(1:i)), sum(dim(1:j-1))+1:sum(dim(1:j))) = sij;
        Sb(sum(dim(1:j-1))+1:sum(dim(1:j)), sum(dim(1:i-1))+1:sum(dim(1:i))) = sij';
    end
end

%% LDA
Sb = Sb.*num_view; % Why?
W_LDA = LDAX_SwSb(Sw,Sb); % 
W_lda = cell(1,num_view);
for i=1:num_view
    W_lda{i} = (W_LDA(sum(dim(1:i-1))+1:sum(dim(1:i)), :));
end

%%
W_LDA = W_LDA(:,1:d);
for i = 1:num_view
    W_lda{1,i} = W_lda{1,i}(:,1:d);
end

% fprintf('MvDA finished\n');