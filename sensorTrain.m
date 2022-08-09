function [trainmeans, valmeans, testmeans, errors, pred, target, net] = sensorTrain(inp, out, fclayers, ratio, figs)
% Train feedforward neural network

    % INPUTS
    % inp: filtered/extracted sensor data
    % out: [x y depth temp] targets
    % fclayers: hidden layer sizes - all fully connected, with tanh activation
    % ratio: [train val test] ratios: must add to 1
    % figs: plot figures/training progress?

    positions = out(:,1:2);

    inp = normalize(inp);
    
    %% Standardize outputs between 0 and 1
    out(:,1) = out(:,1)./0.07;
    out(:,2) = out(:,2)./0.07;
    out(:,3) = (out(:,3)-0.005)./0.015;
    
    %% Extract training, validation, and test data
    %assert(sum(ratio)==1);

    % Training data
    P=randperm(size(inp,1)); % randomise order first to avoid temporal effects
    XTrain=inp(P(1:round(ratio(1)*size(inp,1))),:);
    YTrain=out(P(1:round(ratio(1)*size(inp,1))),:);
    TrainPositions = positions(P(1:round(ratio(1)*size(inp,1))),:);
    
    % Validation data
    XVal=inp(P(round(ratio(1)*size(inp,1))+1:round(sum(ratio(1:2))*size(inp,1))),:);
    YVal=out(P(round(ratio(1)*size(inp,1))+1:round(sum(ratio(1:2))*size(inp,1))),:);
    ValPositions = positions(P(round(ratio(1)*size(inp,1))+1:round(sum(ratio(1:2))*size(inp,1))),:);
    
    % Test data
    XTest=inp(P(round(sum(ratio(1:2))*size(inp,1)+1):end),:);
    YTest=out(P(round(sum(ratio(1:2))*size(inp,1)+1):end),:);
    TestPositions = positions(P(round(sum(ratio(1:2))*size(inp,1)+1):end),:);


    %% Build network architecture and training options
    layers = [featureInputLayer(size(XTrain,2),"Name","featureinput")];
    for i = 1:length(fclayers)
        fcname = "fc"+string(i);
        tanhname = "tanh"+string(i);
        layers = [layers fullyConnectedLayer(fclayers(i),...
            "Name", fcname) tanhLayer("Name",tanhname)];
    end
    layers = [layers fullyConnectedLayer(size(out, 2),"Name","fc_out")...
        regressionLayer("Name","regressionoutput")];
    
    if figs
        plotstring = 'training-progress';
    else
        plotstring = 'none';
    end

    opts = trainingOptions('sgdm', ...
        'MaxEpochs',5000, ...
        'MiniBatchSize', 500,...
         'ValidationData',{XVal,YVal}, ...
        'ValidationFrequency',30, ...
        'GradientThreshold',1000, ...
        'ValidationPatience',1000,...
        'InitialLearnRate',0.05*1, ...
        'LearnRateSchedule','piecewise', ...
        'LearnRateDropPeriod',500, ...
        'LearnRateDropFactor', 0.99,... %0.05, ...
        'Verbose',0, ...
        'Plots',plotstring, 'ExecutionEnvironment', 'gpu');
    
    %% Train network
    [net, ~] = trainNetwork(XTrain,YTrain,layers, opts);

    %% Calculate and return mean errors for training, validation, and test sets
%     depthpercent = zeros(1,3); % [Train Validation Test]
% If depthpercent is being added to outputs, put last

    [errors, pred, target] = calculateErrors(XTrain, YTrain, TrainPositions, net, figs);
    if figs
        sgtitle('Train');
    end
    trainmeans = mean(abs(errors));

%     % Calculate depth percentage
%     sums = 0;
%     for i = 1:length(pred)
%         preddepth = min(max((round(200*pred(i,3))/200), 0.005), 0.02);
%         if preddepth == target(i,3)
%             sums = sums + 1;
%         end
%     end
%     depthpercent(1) = sums*100/length(pred);
%     %

    [errors, pred, target] = calculateErrors(XVal, YVal, ValPositions, net, figs);
    if figs
        sgtitle('Validation');
    end
    valmeans = mean(abs(errors));

%     % Calculate depth percentage
%     sums = 0;
%     for i = 1:length(pred)
%         preddepth = min(max((round(200*pred(i,3))/200), 0.005), 0.02);
%         if preddepth == target(i,3)
%             sums = sums + 1;
%         end
%     end
%     depthpercent(2) = sums*100/length(pred);
%     %

    [errors, pred, target] = calculateErrors(XTest, YTest, TestPositions, net, figs);
    if figs
        sgtitle('Test');
    end
    testmeans = mean(abs(errors));

%     % Calculate depth percentage
%     sums = 0;
%     for i = 1:length(pred)
%         preddepth = min(max((round(200*pred(i,3))/200), 0.005), 0.02);
%         if preddepth == target(i,3)
%             sums = sums + 1;
%         end
%     end
%     depthpercent(3) = sums*100/length(pred);
%     %
end