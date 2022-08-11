% Basic localisation with no network training: simply looking at clusters
% of 'activation'

% theshold500.mat loaded - first ignore accept data and just use all
% Corresponding positions (random_f_d_16_10k.mat) also loaded 

% First use pure superposition into discretised grid, rather than Gaussian
% combinations:

% each sensor set is associated with a 13x6 (cm) grid
allgrids = zeros(size(btrain, 2), 13, 6);

% Build grids
for sensor = 1:size(btrain, 2)
    for probe = 1:size(btrain, 1)
        if btrain(probe, sensor)
            x = ceil(100*positions(probe,1));
            y = ceil(100*positions(probe,2));
            allgrids(sensor, x, y) = allgrids(sensor, x, y) + 1;
        end
    end
    
    % normalise based on number of 1s in binary data
    allgrids(sensor, :, :) = allgrids(sensor, :, :)./length(find(btrain(:, sensor)));
end

%% Plot superposition maps
probe = 13;

predictiongrid = zeros(13, 6);

for sensor = 1:size(btrain, 2)
    if btrain(probe, sensor)
        predictiongrid = predictiongrid + reshape(allgrids(sensor, :, :), [13 6]);
    else
        %predictiongrid = predictiongrid - reshape(allgrids(sensor, :, :), [13 6]);
    end
end

