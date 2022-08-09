function discrepancies = superposeMaps(n, responsedowns, responseups, positions, plotnum, m)
% if plotnum & m are specified, plots only specific prediction
% else, calculates all 15000 without plotting, for m = 1, 3, 10
% n is number of probes data is based off
% m is how many highest predictions are averaged

    if nargin == 4
        % multiple case: all 15k
        discrepancies = zeros(15000,3);
        for k = 1:15000
            if mod(k,1000) == 0
                k
            end
            weights = responsedowns(k,:) - responseups(k,:);
            
            magnitudes = responsedowns(1:n,:) - responseups(1:n,:);
            for i = 1:size(magnitudes, 1)
                magnitudes(i,:) = normalize(magnitudes(i,:));
                magnitudes(i,:) = tanh(magnitudes(i,:));
            end
            
            values = zeros(n,1);
            for i = 1:192
                values = values + weights(i)*magnitudes(:,i);
            end
        
            [~, ind] = sort(values, 'descend');
            mvals = [1 3 10];
            for j = 1:3
                prediction = [mean(positions(ind(1:mvals(j)),1)) mean(positions(ind(1:mvals(j)),2))];
                discrepancies(k, j) = rssq(positions(k,1:2)-prediction);
            end
        end
    else
        % single case, with plot
        assert(nargin == 6);
        %weights = responsedowns(plotnum,:) - responseups(plotnum,:);
        weights = responseups(plotnum,:) - responseups(1,:);
        
        magnitudes = responsedowns(1:n,:) - responseups(1:n,:);
        for i = 1:size(magnitudes, 1)
            magnitudes(i,:) = normalize(magnitudes(i,:));
            magnitudes(i,:) = tanh(magnitudes(i,:));
        end
        
        values = zeros(n,1);
        for i = 1:192
            values = values + weights(i)*magnitudes(:,i);
        end
    
        scatter(positions(1:n,1), positions(1:n,2), 10, values, 'filled');
        hold on;
%         scatter(positions(plotnum,1), positions(plotnum,2), 50, 'r', 'filled');
        [~, ind] = sort(values, 'descend');
        prediction = [mean(positions(ind(1:m),1)) mean(positions(ind(1:m),2))];
        discrepancies = rssq(positions(plotnum,1:2)-prediction);
%         scatter(prediction(1), prediction(2), 50, 'k', 'filled');
        title(string(plotnum));
        xlim([-0.08 0.08]);
        ylim([-0.08 0.08]);
        axis square
        colorbar
    end
end

