function [discrepancies, prediction] = superposeInternalMaps(n, responsedowns, responseups, positions)
% version of superposeMaps written for table data - n sample with 10%
% test set
% e.g. if n = 500, 500 samples taken from first 550 presses: remaining 50
% used as test set which is output in discrepancies and predictions

% if plotnum & m are specified, plots only specific prediction
% else, calculates all 15000 without plotting, for m = 1, 3, 10
% n is number of probes data is based off

    discrepancies = zeros(n*0.1,3);

    inds = randperm(round(n*1.1),n); % 10% test set
    ranpositions = positions(inds,:);

    next = 1;
    for k = 1:n*1.1
        if mod(k,1000) == 0
            k
        end

        if ismember(k, inds)
            continue
        end

        weights = responsedowns(k,:) - responseups(k,:);
        
        magnitudes = responsedowns(inds,:) - responseups(inds,:);
        for i = 1:size(magnitudes, 1)
            magnitudes(i,:) = normalize(magnitudes(i,:));
            magnitudes(i,:) = tanh(magnitudes(i,:));
        end
        
        values = zeros(n,1);
        for i = 1:size(responseups,2)
            values = values + weights(i)*magnitudes(:,i);
        end
    
        [~, ind] = sort(values, 'descend');
        mvals = [1 3 10];
        for j = 1:3
            prediction = [mean(ranpositions(ind(1:mvals(j)),1)) mean(ranpositions(ind(1:mvals(j)),2))];
            discrepancies(next, j) = rssq(positions(k,1:2)-prediction);
        end
        next = next+1;
    end
end

