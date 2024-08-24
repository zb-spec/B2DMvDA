function AC = knn_MultiviewBp2D_classifier(Wj, Vj, x_train, y_train, x_test, y_test, dp, dq)

v = numel(x_train);
train_label = unique(y_train{1});           
train_c = numel(train_label); 
test_label = unique(y_test{1});           
test_c = numel(test_label); 



% combine the projected data of v views 
% trian set
x_train_prj = cell(1, v);  
for j = 1:v
    for i = 1:train_c
        for k = find(y_train{j} == train_label(i))
            x_train_prj{1, j}(:, :, k) = Wj{1, j}(:,1:dp)' * x_train{1, j}(:,:,k) * Vj{1, j}(:,1:dq);
        end
    end
end
% test set  
x_test_prj = cell(1, v);  
for i = 1:test_c
    for j = 1:v
        for k = find(y_test{j} == test_label(i))
            x_test_prj{1, j}(:, :, k) = Wj{1, j}(:,1:dp)' * x_test{1, j}(:,:,k) * Vj{1, j}(:,1:dq);
        end
    end
end


% combine the data of v views
x_train_joint = [];  x_test_joint = []; 
for j = 1 : v
    x_train_joint = cat(1, x_train_joint, x_train_prj{1, j});
    x_test_joint = cat(1, x_test_joint, x_test_prj{1, j});
end


test_num = numel(y_test{1, 1});
train_num = numel(y_train{1, 1});
label = zeros(test_num, 1);
for i = 1 : test_num
    temp = zeros(1, train_num);
    for j = 1:train_num
        temp(j) = norm(x_train_joint(:,:,j) - x_test_joint(:,:,i),'fro');
    end
    optindexes = find(min(temp) == temp); optindex = optindexes(1);
    label(i) = y_train{1, 1}(optindex);
end

AC = sum(label' == y_test{1, 1})/numel(y_test{1,1});
