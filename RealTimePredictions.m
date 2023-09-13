clear;
clc;

n = 32; % Number of electrodes

% Connect to board's serial port
% device = serialport("COM9", 115200);
device = serialport("COM12", 9600);

% Set board's mode
if n == 8
    load("Extracted/ohmc8.mat");
    write(device, "c", "string");
elseif n == 16
    load("Extracted/ohmc16.mat");
    write(device, "d", "string");
elseif n==32
    load("Extracted/taros32.mat");
else
    error("Invalid number of electrodes\n");
end

% Set baseline when script is first run
for i = 1:3
    baselineresponse = getresponse(device, n);
end

% Continue script until manually halted
while (1)
    % Measure current state
    measuredresponse = getresponse(device, n);

    % Calculate weights
    weights = measuredresponse - baselineresponse;
    weights = normalize(weights);
    weights = tanh(weights);
    
    % Construct WAMs
    magnitudes = responsedowns(1:500,:) - responseups(1:500,:);
    for i = 1:size(magnitudes, 1)
        magnitudes(i,:) = normalize(magnitudes(i,:));
        magnitudes(i,:) = tanh(magnitudes(i,:));
    end
    values = zeros(500,1);
    for i = 1:size(magnitudes, 2)
        values = values + weights(i)*magnitudes(:,i);
    end

%     scatter(positions(1:500,1), positions(1:500,2), 50, values, 'filled');

    interpolant = scatteredInterpolant(positions(1:500,1),...
        positions(1:500,2),values);
    [xx,yy] = meshgrid(linspace(-0.065,0.065,60));
    value_interp = interpolant(xx,yy);

    % Remove points from outside circle
    for i = 1:size(xx,1)
        for j = 1:size(xx,2)
            if xx(i,j)^2 + yy(i,j)^2 > 0.07^2
                value_interp(i,j) = nan;
            end
        end
    end

    % Update plot
    clf
    contourf(xx,yy,value_interp, 20, 'LineStyle', 'none');
    % Find and plot maximum value
    [vals, id1] = max(value_interp);
    [maxval, id2] = max(vals);
    if maxval > 11
        hold on
        scatter(xx(id1(id2), id2), yy(id1(id2), id2), 50, 'k', 'filled');
    end

    xlim([-0.08 0.08]);
    ylim([-0.08 0.08]);
    axis square
    set(gca, 'Visible', 'off');
    set(gcf, 'Color', 'k', 'ToolBar', 'none', 'MenuBar', 'none'); 
    % if n==8
    %     text(-0.045, 0.08, 'Low Resolution - Faster', 'Color', 'w', 'FontSize', 30);
    %     caxis([-10 10]);
    % else
    %     text(-0.045, 0.08, 'High Resolution - Slower', 'Color', 'w', 'FontSize', 30);
    %     caxis([-60 60]);
    % end

    clim([-50 50]);
    drawnow
end

function response = getresponse(device, n)
if n == 8
    m = 461;
elseif n == 16
    m = 2701;
else
    averagenumber = 1;
    zresponse = zeros([1024, 1]);
    for i = 1:averagenumber
        line = readline(device);
        line = split(line, ",");
        zresponse = [zresponse double(line(1:end-1))];
    end

    response = zeros([928, 1]);
    n = 1;
    for i = 1:1024
        if any(zresponse(i, :))
            response(n) = mean(zresponse(i,:));
            n = n + 1;
        end
    end
    return
end
    charresponse = read(device, m*2, "char");
    charresponse = charresponse(find(charresponse=='m',1,'first'):find(charresponse=='m',1,'first')+m);
    charresponse = charresponse(12:end-1);
    indices = [1 find(charresponse==',')];
    assert(length(indices) == (n-4)*n + 1);
    response = zeros(1, length(indices)-1);
    for i = 1:length(indices)-1
        response(i) = str2double(charresponse(indices(i)+4:indices(i+1)-1));
    end
end