inp = btrain;
out = positions(:,1:2);

P=randperm(length(inp));
XTrain=inp(P(1:9000),:); % 10 percent used for validation
YTrain=out(P(1:9000),:);
YTrain(:,1) = YTrain(:,1)./0.13;
YTrain(:,2) = YTrain(:,2)./0.06;

XVal=inp(P(9001:end),:);
YVal=out(P(9001:end),:);
YVal(:,1) = YVal(:,1)./0.13;
YVal(:,2) = YVal(:,2)./0.06;

len=size(XTrain,2);

% define network and training options
layers = [
    featureInputLayer(len,"Name","featureinput")
    fullyConnectedLayer(200,"Name","fc_1")
    tanhLayer("Name","tanh")
    fullyConnectedLayer(100,"Name","fc_2")
    tanhLayer("Name","tanh2")
    fullyConnectedLayer(50,"Name","fc_3")
    reluLayer("Name","relu")
    fullyConnectedLayer(2,"Name","fc_4")
    regressionLayer("Name","regressionoutput")];

opts = trainingOptions('sgdm', ...
    'MaxEpochs',1000, ...
    'MiniBatchSize', 500,...
     'ValidationData',{XVal,YVal}, ...
    'ValidationFrequency',30, ...
    'GradientThreshold',1000, ...
    'ValidationPatience',100,...
    'InitialLearnRate',0.05*2, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',500, ...
    'LearnRateDropFactor', 0.1, ...
    'Verbose',0, ...
    'Plots','training-progress', 'ExecutionEnvironment', 'gpu');

% Training
[net, info] = trainNetwork(XTrain,YTrain,layers, opts);

ypred = predict(net, inp);
ypred(:,1) = ypred(:,1)*0.13;
ypred(:,2) = ypred(:,2)*0.06;

errors = 1000*rssq([positions(P(9001:end),1:2) - ypred(P(9001:end),:)].').';
mean(errors)

