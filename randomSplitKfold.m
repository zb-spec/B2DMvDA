function [Xtrain, Ytrain, Xtest, Ytest] = randomSplitKfold(X, Y, Ind, kth)
% function: split train set and test set by k-fold
 
V = length(X);
test = find(Ind == kth);
train = find(Ind ~= kth);

%%% train set and test set
Xtrain = cell(1, V);  Ytrain = cell(1, V); 
Xtest = cell(1, V);   Ytest = cell(1, V);
for v = 1:V
    Xtrain{1,v} = X{1,v}(:,:,train); Ytrain{1,v} = Y{1,v}(train);
    Xtest{1,v} = X{1,v}(:,:,test);   Ytest{1,v} = Y{1,v}(test);
end

end


