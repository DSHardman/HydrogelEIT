sensors = [5 30 83 120 190 192];

responseups = responses(1:2:end, :);
responsedowns = responses(2:2:end, :);

ntrain = [responseups; responsedowns];
ntrain = normalize(ntrain);
ttrain = zeros(10000,192);
for i = 1:10000
    for j = 1:192
        ttrain(i,j) = ntrain(i+10000,j) - ntrain(i,j);
    end
end

thresholds = zeros(192,1);
accept = zeros(192,1);

for sensor = 1:192
    for threshold = 0.1:0.1:3.0
        btrain = ttrain > threshold;
        %imshow(btrain);
        %responses = btrain; % so that PlotErrors.m can be run immediately
    
        if length(find(btrain(:,sensor))) < 100
            thresholds(sensor) = threshold;
            figure();
            scatter(positions(btrain(:,sensor),1), positions(btrain(:,sensor),2));
            xlim([0 0.13]);
            ylim([0 0.06]);
            title(string(sensor));
            x = ginput(1);
            close();
            accept(sensor) =  x(1) > 0.13/2;
            break
        end
    end
end