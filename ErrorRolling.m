% Create data to use in plotRollingWindow.m
% TODO: UPDATE NUMBERS IN FOR LOOP

% Initialise
depthpercent5 = [];
trainmeans5 = [];
valmeans5 = [];
testmeans5 = [];

depthpercent7 = [];
trainmeans7 = [];
valmeans7 = [];
testmeans7 = [];

depthpercent9 = [];
trainmeans9 = [];
valmeans9 = [];
testmeans9 = [];

depthpercent11 = [];
trainmeans11 = [];
valmeans11 = [];
testmeans11 = [];

depthpercent13 = [];
trainmeans13 = [];
valmeans13 = [];
testmeans13 = [];

depthpercent15 = [];
trainmeans15 = [];
valmeans15 = [];
testmeans15 = [];

% 10 repetitions for each.
for i = 1:10
    fprintf('Starting run %d...\n', i);

    fprintf('5\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(1:5000,:), positions(1:5000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent5 = [depthpercent5; depthpercent];
    trainmeans5 = [trainmeans5; trainmeans];
    valmeans5 = [valmeans5; valmeans valdepth];
    testmeans5 = [testmeans5; testmeans];

    fprintf('5\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(1:5000,:), positions(1:5000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent5 = [depthpercent5; depthpercent];
    trainmeans5 = [trainmeans5; trainmeans];
    valmeans5 = [valmeans5; valmeans valdepth];
    testmeans5 = [testmeans5; testmeans];

    fprintf('5\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(1:5000,:), positions(1:5000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent5 = [depthpercent5; depthpercent];
    trainmeans5 = [trainmeans5; trainmeans];
    valmeans5 = [valmeans5; valmeans valdepth];
    testmeans5 = [testmeans5; testmeans];

    fprintf('5\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(1:5000,:), positions(1:5000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent5 = [depthpercent5; depthpercent];
    trainmeans5 = [trainmeans5; trainmeans];
    valmeans5 = [valmeans5; valmeans valdepth];
    testmeans5 = [testmeans5; testmeans];

    fprintf('5\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(1:5000,:), positions(1:5000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent5 = [depthpercent5; depthpercent];
    trainmeans5 = [trainmeans5; trainmeans];
    valmeans5 = [valmeans5; valmeans valdepth];
    testmeans5 = [testmeans5; testmeans];

    fprintf('5\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(1:5000,:), positions(1:5000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent5 = [depthpercent5; depthpercent];
    trainmeans5 = [trainmeans5; trainmeans];
    valmeans5 = [valmeans5; valmeans valdepth];
    testmeans5 = [testmeans5; testmeans];

end