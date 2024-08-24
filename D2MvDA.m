function [W, Wj] = D2MvDA(X_multiview, Y_multiview, d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alg1: 2D Multi-view discriminant analysis
%
% Useage: [W] = Alg1(X_multiview, Y_multiview, d)
% 
% Input: X_multiview - the data of v views
%        Y_multiview - label
%        d - the dimension of projected space
%
% Output: W - projected matrix
%
% Author: Skywalker Yang (Email:yxf9011@163.com); Date: 2024/1/1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% acquire the struct information of input data
V = size(X_multiview, 2);                   % V views
N = size(X_multiview{1}, 3);                % N samples
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
        uij{i,j} = zeros(di(j),size(X_multiview{j}, 2));
        Nij(i,j) = length(find(Y_multiview{j} == c_name(i)));
    end
end
% compute the mean 
for j = 1:V
    for i = 1:c
        for k = find(Y_multiview{j} == c_name(i))
            uij{i,j} = uij{i,j} + X_multiview{j}(:, :, k);
        end
        uij{i,j} = uij{i,j}/Nij(i,j);
    end
end


%%% compute S, the within-class scatter matrix
S = zeros(sum(di), sum(di));
for j = 1 : V
    for r = 1 : V
        % compute Sjr
        Sjr = zeros(di(j), di(r));
        if j == r 
            for i = 1:c
                for k = find(Y_multiview{j} == c_name(i))
                    Sjr = Sjr +  X_multiview{j}(:,:,k) * X_multiview{j}(:,:,k)';
                end
                Sjr = Sjr - Nij(i,j) * Nij(i,r) / sum(Nij(i,:)) * uij{i,j} * uij{i,r}';
            end
        else 
            for i = 1:c
                Sjr = Sjr -  Nij(i,j) * Nij(i,r) / sum(Nij(i,:)) * uij{i,j} * uij{i,r}';
            end
        end
        % compute S
        S((sum(di(1 : (j - 1))) + 1) : sum(di(1 : j)), (sum(di(1 : (r - 1))) + 1) : sum(di(1 : r))) = Sjr;
    end
end


%%%  compute D, the between-class scatter matrix
D = zeros(sum(di), sum(di));
for j = 1 : V
    for r = 1 : V
        Djr = zeros(di(j), di(r)); 
        Djr_j = zeros(di(j), size(X_multiview{j}, 2)); Djr_r = zeros(di(r), size(X_multiview{r}, 2));
        % compute Djr
        for i = 1:c
            for k = find(Y_multiview{j} == c_name(i)) 
                Djr = Djr + Nij(i,j) * Nij(i,r) / sum(Nij(i,:)) * uij{i,j} * uij{i,r}';
            end
            Djr_j= Djr_j + Nij(i,j) * uij{i,j}; 
            Djr_r= Djr_r + Nij(i,r) * uij{i,r};
        end
        Djr = Djr - 1 / (N * V) * Djr_j * Djr_r';
        % compute S
        D((sum(di(1 : (j - 1))) + 1) : sum(di(1 : j)), (sum(di(1 : (r - 1))) + 1) : sum(di(1 : r))) = Djr;
    end
end


%%% genernal eigendecomposition
[W_all,~,~ ,W_val,~] = gsvd(S, D);
sigma = gsvd(S, D);
Ind = find(sigma < 1e-3);
W_all(:,Ind) = [];

W = W_all(:,1:d);

Wj = cell(1, V);
for v = 1:V
    Wj{1, v} = W((sum(di(1:(v - 1))) + 1):sum(di(1:v)),1:d);
end

end




