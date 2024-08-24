function [W, V] = D22LDA(X, Y, p, q)  
% =================================================
% author: Yang Xiangfei (email: yxf9011@163.com)
% =================================================

[m, n, ~] = size(X);

W = zeros(m, p); 
[V, ~] = qr(randn(n, q), 0); 
label = unique(Y);
c = numel(label);

% compute the mean of each class
ui = zeros(m, n, c); u = zeros(m, n);
ni = zeros(1, c);
for i = 1:c
    ni(i) = numel(find(Y == label(i)));
    for j = find(Y == label(i))
        ui(:, :, i) = ui(:, :, i) + X(:, :, j);
    end
    ui(:, :, i) = ui(:, :, i) / ni(i);
end
for i = 1:c
    u = u + ni(i) * ui(:, :, i);
end
u = u / sum(ni);

% compute Swv and Dwv
Swv = zeros(m, m);
for i = 1:c
    for j = find(Y == label(i))
        Swv = Swv + (X(:, :, j) - ui(:, :, i)) * V * V' * (X(:, :, j) - ui(:, :, i))';
    end
end
Dwv = zeros(m, m);
for i = 1:c
    Dwv = Dwv +  (ui(:, :, i) - u) * V * V' * (ui(:, :, i) - u)';
end

[W_all,~,~ ,W_val,~] = gsvd(Swv, Dwv);
sigma = gsvd(Swv, Dwv);
Ind = find(sigma < 1e-3);
W_all(:,Ind) = [];
W = W_all(:,1:p); 

% compute Svw and Dvw
Svw = zeros(n, n);
for i = 1:c
    for j = find(Y == label(i))
        Svw = Svw + (X(:, :, j) - ui(:, :, i))' * W * W' * (X(:, :, j) - ui(:, :, i));
    end
end
Dvw = zeros(n, n);
for i = 1:c
    Dvw = Dvw +  (ui(:, :, i) - u)' * W * W' * (ui(:, :, i) - u);
end

[V_all,~,~ ,V_val,~] = gsvd(Svw, Dvw);
sigma = gsvd(Svw, Dvw);
Ind = find(sigma < 1e-3);
V_all(:,Ind) = [];
V = V_all(:,1:q); 

end




















