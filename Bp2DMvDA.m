function [W, V, Wj, Vj] = Bp2DMvDA(X_multiview, Y_multiview, p, q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alg1: B2DMvDA
%
% Useage: [W] = Alg1(X_multiview, Y_multiview, p, q)
% 
% Input: X_multiview - the data of v views
%        Y_multiview - label
%        p, q - the dimension of projected space
%
% Output: W, V, Wj, Vj - projected matrix
%
% Author: Skywalker Yang (Email:yxf9011@163.com); Date: 2024/1/7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% acquire the struct information of input data
v = numel(X_multiview);                        % v views
c_name = unique(Y_multiview{1});               % the labels of c classes
c = length(unique(Y_multiview{1}));            % c classes
mj = zeros(1,v); nj = zeros(1,v);              % the dimensions of v views
for j = 1:v
    [mj(j), nj(j)] = size(X_multiview{j}, [1, 2]);        
end

% compute the mean and number of jth view, ith calss
% initialization
uij = cell(c, v);
Nij = zeros(c, v);
for j = 1:v
    for i = 1:c
        uij{i, j} = zeros(mj(j), nj(j));
        Nij(i, j) = length(find(Y_multiview{j} == c_name(i)));
    end
end
% compute the mean 
for j = 1:v
    for i = 1:c
        for k = find(Y_multiview{j} == c_name(i))
            uij{i,j} = uij{i,j} + X_multiview{j}(:, :, k);
        end
        uij{i,j} = uij{i,j}/Nij(i,j);
    end
end


% initialize W and V
randn('seed', 1)     % 便于复现
W = zeros(sum(mj), p); 
[V, ~] = qr(randn(sum(nj), q), 0); 


% fix V, and compute Vj
Vj = cell(1, v);
for j = 1:v
    Vj{1, j} = V((sum(nj(1:(j - 1))) + 1):sum(nj(1:j)), :);
end

% compute Swv (the within-class scatter matrix)
Swv = zeros(sum(mj), sum(mj));
for j = 1 : v
    for r = 1 : v
        % compute Sjr
        Sjr = zeros(mj(j), mj(r));
        if j == r 
            for i = 1:c
                for k = find(Y_multiview{j} == c_name(i))
                    Sjr = Sjr +  X_multiview{j}(:,:,k) * Vj{1, j} * Vj{1, j}' * X_multiview{j}(:,:,k)';
                end
                Sjr = Sjr - Nij(i,j) * Nij(i, r) / sum(Nij(i, :)) * uij{i, j} * Vj{1, j} * Vj{1, j}' * uij{i, r}';
            end
        else 
            for i = 1:c
                Sjr = Sjr -  Nij(i, j) * Nij(i, r) / sum(Nij(i, :)) * uij{i, j} * Vj{1, j} * Vj{1, r}' * uij{i, r}';
            end
        end
        % compute S
        Swv((sum(mj(1 : (j - 1))) + 1) : sum(mj(1 : j)), (sum(mj(1 : (r - 1))) + 1) : sum(mj(1 : r))) = Sjr;
    end
end

% compute Dwv (the between-class scatter matrix)
Dwv = zeros(sum(mj), sum(mj));
for j = 1 : v
    for r = 1 : v
        Djr = zeros(mj(j), mj(r)); 
        Djr_j = zeros(mj(j), q); Djr_r = zeros(mj(r), q);
        % compute Djr
        for i = 1:c
            Djr = Djr + Nij(i, j) * Nij(i, r) / sum(Nij(i,:)) * uij{i, j} * Vj{1, j} * Vj{1, r}' * uij{i, r}';
            Djr_j= Djr_j + Nij(i, j) * uij{i, j} * Vj{1, j}; 
            Djr_r= Djr_r + Nij(i, r) * uij{i, r} * Vj{1, r};
        end
        Djr = Djr - 1 / sum(sum((Nij))) * Djr_j * Djr_r';
        % compute D
        Dwv((sum(mj(1 : (j - 1))) + 1) : sum(mj(1 : j)), (sum(mj(1 : (r - 1))) + 1) : sum(mj(1 : r))) = Djr;
    end
end

% genernal eigendecomposition of W
[W_all,~,~ ,W_val,~] = gsvd(Swv, Dwv);
sigma = gsvd(Swv, Dwv);
Ind = find(sigma < 1e-3);
W_all(:,Ind) = [];
W = W_all(:,1:p);



% fix W, and compute Wj
Wj = cell(1, v);
for j = 1:v
    Wj{1, j} = W((sum(mj(1:(j - 1))) + 1):sum(mj(1:j)), 1 : p);
end

% compute Svw (the within-class scatter matrix)
Svw = zeros(sum(nj), sum(nj));
for j = 1 : v
    for r = 1 : v
        % compute Sjr
        Sjr = zeros(nj(j), nj(r));
        if j == r 
            for i = 1:c
                for k = find(Y_multiview{j} == c_name(i))
                    Sjr = Sjr +  X_multiview{j}(:, :, k)' * Wj{1, j} * Wj{1, j}' * X_multiview{j}(:, :, k);
                end
                Sjr = Sjr - Nij(i,j ) * Nij(i, r) / sum(Nij(i, :)) * uij{i, j}' * Wj{1, j} * Wj{1, j}' * uij{i, r};
            end
        else 
            for i = 1:c
                Sjr = Sjr -  Nij(i, j) * Nij(i, r) / sum(Nij(i, :)) * uij{i, j}' * Wj{1, j} * Wj{1, r}' * uij{i, r};
            end
        end
        % compute S
        Svw((sum(nj(1 : (j - 1))) + 1) : sum(nj(1 : j)), (sum(nj(1 : (r - 1))) + 1) : sum(nj(1 : r))) = Sjr;
    end
end

% compute Dvw (the between-class scatter matrix)
Dvw = zeros(sum(nj), sum(nj));
for j = 1 : v
    for r = 1 : v
        Djr = zeros(nj(j), nj(r)); 
        Djr_j = zeros(nj(j), p); Djr_r = zeros(nj(r), p);
        % compute Djr
        for i = 1:c
            Djr = Djr + Nij(i, j) * Nij(i, r) / sum(Nij(i,:)) * uij{i, j}' * Wj{1, j} * Wj{1, r}' * uij{i, r};
            Djr_j = Djr_j + Nij(i, j) * uij{i, j}' * Wj{1, j}; 
            Djr_r = Djr_r + Nij(i, r) * uij{i, r}' * Wj{1, r};
        end
        Djr = Djr - 1 / sum(sum((Nij))) * Djr_j * Djr_r';
        % compute D
        Dvw((sum(nj(1 : (j - 1))) + 1) : sum(nj(1 : j)), (sum(nj(1 : (r - 1))) + 1) : sum(nj(1 : r))) = Djr;
    end
end

% genernal eigendecomposition of V
[V_all,~,~ ,V_val,~] = gsvd(Svw, Dvw);
sigma = gsvd(Svw, Dvw);
Ind = find(sigma < 1e-3);
V_all(:,Ind) = [];
V = V_all(:,1:q);

Vj = cell(1, v);
for j = 1:v
    Vj{1, j} = V((sum(nj(1:(j - 1))) + 1):sum(nj(1:j)), :);
end

end



