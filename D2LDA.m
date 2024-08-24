function [W] = D2LDA(X,Y,dim)  
% =================================================
% % % % % % % % 2DLDA % % % % % %
% =================================================
[m, n, ~] = size(X);

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
        Swv = Swv + (X(:, :, j) - ui(:, :, i)) * (X(:, :, j) - ui(:, :, i))';
    end
end
Dwv = zeros(m, m);
for i = 1:c
    Dwv = Dwv +  (ui(:, :, i) - u) * (ui(:, :, i) - u)';
end

[W_all,~,~ ,W_val,~] = gsvd(Swv, Dwv);
sigma = gsvd(Swv, Dwv);
Ind = find(sigma < 1e-3);
W_all(:,Ind) = [];
W = W_all(:,1:dim); 


      
      
      