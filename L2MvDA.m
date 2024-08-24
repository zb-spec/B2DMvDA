function [W, Wj] = L2MvDA(X_multiview, Y_multiview, d, sig)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alg1: Multi-view discriminant analysis with view consistency based on L2-norm.
%
% Useage: [W] = Alg1(X_multiview, Y_multiview, d, sig)
% 
% Input: X_multiview - v views data
%        Y_multiview - label
%        d - the dimension of projected space
%        sig - penalty parameter
%
% Output: W - projected matrix
%
% Author: Skywalker Yang; Date: 2020/11/03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% acquire the struct information of input data
V = size(X_multiview, 2);                   % V views
N = size(X_multiview{1}, 2);                % N samples
c_name = unique(Y_multiview{1});            % the labels of c classes
c = length(unique(Y_multiview{1}));         % c classes
di = [];                                    % the dimensions of v views
for i = 1:V
    di(i) = size(X_multiview{i}, 1);        
end

% compute the mean and number of jth view, ith calss
% initialization
uij = cell(c, V);
Nij = zeros(c, V);
for j = 1:V
    for i = 1:c
        uij{i,j} = zeros(di(j),1);
        Nij(i,j) = length(find(Y_multiview{j} == c_name(i)));
    end
end
% compute the mean 
for j = 1:V
    for i = 1:c
        for k = find(Y_multiview{j} == c_name(i))
            uij{i, j} = uij{i, j} + X_multiview{j}(:,k);
        end
        uij{i,j} = uij{i,j}/Nij(i,j);
    end
end

%%%  compute S, the within-class scatter matrix
S = zeros(sum(di), sum(di));
for j = 1:V
    Sj = zeros(di(j));
    for i = 1:c
        % compute Sj, the scatter matrix of jth view, ith class
        for k = find(Y_multiview{j} == c_name(i))
            Sj = Sj + (X_multiview{j}(k) - uij{i,j}) * (X_multiview{j}(k) - uij{i,j})';
        end
    end
    % compute S
    S((sum(di(1 : (j - 1))) + 1) : sum(di(1 : j)), (sum(di(1 : (j - 1))) + 1) : sum(di(1 : j))) = Sj;
end

%%%  compute D, the between-class scatter matrix
D = zeros(sum(di), sum(di));
for j = 1:V
    for l = 1:V
        % compute Djl
        Djl = zeros(di(j), di(l));
        Djl_fir = zeros(di(j), di(l));
        Djlj_sec = zeros(di(j), 1);
        Djll_sec = zeros(di(l), 1);
        if j == l
            for i = 1:c
                Djl_fir = Djl_fir + Nij(i,j) * uij{i,j} * uij{i,j}';
            end
        end
        for i = 1:c
            Djlj_sec = Djlj_sec + Nij(i,j) * uij{i,j};
            Djll_sec = Djll_sec + Nij(i,l) * uij{i,l};
        end
        
        if j == l
            Djl = Djl_fir - (1/(N*V)) * Djlj_sec * Djll_sec';
        else
            Djl = (1/(N*V)) * Djlj_sec * Djll_sec';
        end
        
        D((sum(di(1 : (j - 1))) + 1) : sum(di(1 : j)), (sum(di(1 : (l - 1))) + 1) : sum(di(1 : l))) = Djl;
    end
end

%%%  compute M, the view consistency matrix
M = zeros(sum(di), sum(di));
for j = 1:V
    for l = 1:V
        if j == l
            M((sum(di(1 : (j - 1))) + 1) : sum(di(1 : j)), (sum(di(1 : (l - 1))) + 1) : sum(di(1 : l))) = ...
                2*(V - 1) * X_multiview{j} * myInv(X_multiview{j}' * X_multiview{j}) * myInv(X_multiview{j}' * X_multiview{j}) * X_multiview{j}';
        else
            M((sum(di(1 : (j - 1))) + 1) : sum(di(1 : j)), (sum(di(1 : (l - 1))) + 1) : sum(di(1 : l))) = ...
                2*(V - 1) * X_multiview{j} * myInv(X_multiview{j}' * X_multiview{j}) * myInv(X_multiview{l}' * X_multiview{l}) * X_multiview{l}';
        end      
    end
end

%%% genernal eigendecomposition
[W_all,~,~ ,W_val,~] = gsvd(S + sig * M, D);
sigma = gsvd(S + sig * M, D);
Ind = find(sigma < 1e-3);
W_all(:,Ind) = [];

W = W_all(:,1:d);

Wj = cell(1, V);
for v = 1:V
    Wj{1, v} = W((sum(di(1:(v - 1))) + 1):sum(di(1:v)),1:d);
end




