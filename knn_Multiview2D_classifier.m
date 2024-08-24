function AC = knn_Multiview2D_classifier(W, x_train, y_train, x_test, y_test)

V = length(x_train);

train_num = size(x_train{1,1},3);
test_num = size(x_test{1,1},3);

% combine the data of v views
x_train_joint = [];  x_test_joint = []; 
for j = 1:V 
    x_train_joint = cat(1, x_train_joint, x_train{1, j});
    x_test_joint = cat(1, x_test_joint, x_test{1, j});
end


% combine the projected data of v views
x_train_prj = [];  
for i = 1:train_num
    x_train_prj(:, :, i) = W' * x_train_joint(:, :, i);
end
x_test_prj = [];
for i = 1:test_num
    x_test_prj(:, :, i) = W' * x_test_joint(:, :, i);
end

label = zeros(test_num,1);
for i = 1:test_num
    temp = zeros(1, train_num);
    for j = 1:train_num
        temp(j) = norm(x_train_prj(:,:,j) - x_test_prj(:,:,i),'fro');
    end
    optindexes = find(min(temp) == temp); optindex = optindexes(1);
    label(i) = y_train{1, 1}(optindex);
end

AC = sum(label' == y_test{1, 1})/numel(y_test{1,1});
