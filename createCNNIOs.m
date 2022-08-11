%% Create Inputs
% responses = responseups - responsedowns;
% 
% for i = 1:1500
%     n = valinds(i);
%     response = responses(n,:);
%     save("CNN/InputVal/"+string(n)+".mat", 'response');
% end

%% Create outputs
n = 500;
m = 1;

for k = 1:12000
    % copied code from superposeMaps.m: no plotting required here.
    % Outputs 128x128 image - saves
    plotnum = traininds(k);
    weights = responsedowns(plotnum,:) - responseups(plotnum,:);
    
    magnitudes = responsedowns(1:n,:) - responseups(1:n,:);
    for i = 1:size(magnitudes, 1)
        magnitudes(i,:) = normalize(magnitudes(i,:));
        magnitudes(i,:) = tanh(magnitudes(i,:));
    end
    
    values = zeros(n,1);
    for i = 1:192
        values = values + weights(i)*magnitudes(:,i);
    end
    
    interpolant = scatteredInterpolant(positions(1:n,1),...
        positions(1:n,2),values);
    [xx,yy] = meshgrid(linspace(-0.07,0.07,128));
    sensmap = interpolant(xx,yy);
    
    sensmap = sensmap - min(min(sensmap));
    sensmap = sensmap./(max(max(sensmap)));
    
    % Remove points from outside circle
    for i = 1:size(xx,1)
        for j = 1:size(xx,2)
            if xx(i,j)^2 + yy(i,j)^2 > 0.07^2
                sensmap(i,j) = 0;
            end
        end
    end
    response = sensmap;
    save("CNN/OutputTrain/"+string(plotnum)+".mat", 'sensmap');
end