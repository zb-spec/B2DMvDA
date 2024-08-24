function [res] = GetEachClass(X_singleview, Label_singleview, mode)

switch mode
    case 'x'
        res = X_singleview;
        
    case 'm'
        c = length(unique(Label_singleview));
        c_name = unique(Label_singleview);
        res = zeros(size(X_singleview, 1),c);
        for i = 1:c
            for k = find(Label_singleview == c_name(i))
                res(:,i) = res(:,i) + X_singleview(:,k);
            end
            res(:,i) = res(:,i)/length(find(Label_singleview == c_name(i)));
        end
    
    case 'num'
        c = length(unique(Label_singleview));
        c_name = unique(Label_singleview);
        res = zeros(1, c);
        for i = 1:c
            res(i) = length(find(Label_singleview == c_name(i)));
        end
end













