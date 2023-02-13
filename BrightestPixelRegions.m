S = sum(I,3);

for i = 1:625
    for j = 1:624
        if sqrt((i-313)^2 + (j-312.5)^2) > 309
            for k = 1:3
                S(i,j,k) = 0; 
            end
        end
    end
end

% [~,idx] = max(S(:));
idx = find(S == max(S(:)));

imshow(I)
hold on



[row,col] = ind2sub(size(S),idx);
scatter(col, row);

% a_row = mean(row);
% a_col = mean(col);
% scatter(a_col, a_row);