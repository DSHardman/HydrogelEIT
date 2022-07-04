function [errors, pred, target] = calculateErrors(X, target, positions, net, figs)
% Use given network and input/target to calculate and plot mean errors
% Called by sensorTrain.m - mirrors inputs
    
    %% Make predictions
    ypred = predict(net, X);

    %% TODO Convert predictions to desired format
    pred = zeros(size(ypred));
    pred(:,1) = ypred(:,1).*0.07;
    pred(:,2) = ypred(:,2).*0.07;
    pred(:,3) = (ypred(:,3).*0.015)+0.005;
    target(:,1) = target(:,1).*0.07;
    target(:,2) = target(:,2).*0.07;
    target(:,3) = (target(:,3).*0.015)+0.005;

    %% Calculate corresponding errors
    errors = pred - target;

    %% Scatter plots of errors, for localisation, depth, and temperature sensing
    if figs
        localization = rssq(errors(:,1:2).');
        scatter(positions(:,1), positions(:,2), 40, localization, 'filled');
        colorbar();
        title('Localisation (mm)');
    end
    %% Return absolute localisation error rather than seperate x/y
    if size(errors,2) == 2
        errors = rssq(errors(:,1:2).');
    else
        errors = [rssq(errors(:,1:2).').' errors(:,3:end)];
    end
end