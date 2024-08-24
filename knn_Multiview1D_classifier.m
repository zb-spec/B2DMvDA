function AC = knn_Multiview1D_classifier(W, x_train, y_train, x_test, y_test)

V = numel(x_train);

% combine the data of v views
x_train_joint = [];  x_test_joint = []; 
for j = 1:V 
    x_train_joint = cat(1, x_train_joint, x_train{1, j});
    x_test_joint = cat(1, x_test_joint, x_test{1, j});
end


% combine the projected data of v views
x_train_prj = W' * x_train_joint;
x_test_prj = W' * x_test_joint;

train_num = size(x_train_prj, 2);
test_num = size(x_test_prj, 2);

label = zeros(test_num,1);
for i = 1:test_num
    temp = zeros(1, train_num);
    for j = 1:train_num
        temp(j) = norm(x_train_prj(:,j) - x_test_prj(:,i));
    end
    optindexes = find(min(temp) == temp); optindex = optindexes(1);
    label(i) = y_train{1, 1}(optindex);
end

AC = sum(label' == y_test{1, 1})/numel(y_test{1,1});
