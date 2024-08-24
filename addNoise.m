function nX = addNoise(X, Y, num)
% function£ºadd block noise to multi-view data
% X - multi-view data
% Y - the label
% num - the size of block, noise density


V = length(X);


nX = X;
for v = 1:V
    % compute the index of added images
    index = crossvalind('Kfold', Y{1,v}, 5);
    noiseIdx = find(index <= 3);
    % compute the length and width of the images
    imgL = size(nX{1,v},1);  imgW = size(nX{1,v},2);
    for i = 1: numel(noiseIdx)
        point_x = imgL - num + 1;
        point_y = imgW  - num + 1;
        % give the left-up point of block noise
        start_point(1) = randperm(point_x,1);
        start_point(2) = randperm(point_y,1);
        img = X{1,v}(:,:,noiseIdx(i));
        img(start_point(1):start_point(1)+num-1,start_point(2):start_point(2)+num-1)=zeros(num,num);
        nX{1,v}(:,:,noiseIdx(i)) = img;
    end
end

