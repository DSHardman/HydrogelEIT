n = 600;
threshold = 0.8;

changes = zeros(n, 192);
quantity = zeros(n, 1);

for i = 1:n
    for j = 1:192
        change = abs(nresponsedowns(i,j) - nresponseups(i,j));
        if change > threshold
            changes(i,j) = 1;
        else
            changes(i,j) = 0;
        end
    end

    quantity(i) = length(find(changes(i,:)));
end

scatter(positions(:,1), positions(:,2), 40, quantity, 'filled');
ylim([0 0.06])
xlim([0 0.13])
set(gcf, 'Position', [300   494   811   420]);
colorbar