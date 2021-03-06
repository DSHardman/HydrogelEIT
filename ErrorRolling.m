% Create data to use in plotRollingWindow.m

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
    valmeans5 = [valmeans5; valmeans];
    testmeans5 = [testmeans5; testmeans];

    fprintf('7\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(2001:7000,:), positions(2001:7000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent7 = [depthpercent7; depthpercent];
    trainmeans7 = [trainmeans7; trainmeans];
    valmeans7 = [valmeans7; valmeans];
    testmeans7 = [testmeans7; testmeans];

    fprintf('9\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(4001:9000,:), positions(4001:9000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent9 = [depthpercent9; depthpercent];
    trainmeans9 = [trainmeans9; trainmeans];
    valmeans9 = [valmeans9; valmeans];
    testmeans9 = [testmeans9; testmeans];

    fprintf('11\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(6001:11000,:), positions(6001:11000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent11 = [depthpercent11; depthpercent];
    trainmeans11 = [trainmeans11; trainmeans];
    valmeans11 = [valmeans11; valmeans];
    testmeans11 = [testmeans11; testmeans];

    fprintf('13\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(8001:13000,:), positions(8001:13000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent13 = [depthpercent13; depthpercent];
    trainmeans13 = [trainmeans13; trainmeans];
    valmeans13 = [valmeans13; valmeans];
    testmeans13 = [testmeans13; testmeans];

    fprintf('15\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~, depthpercent] = sensorTrain(response(10001:15000,:), positions(10001:15000,:), [300 50 20], [0.8 0.1 0.1], 0);
    depthpercent15 = [depthpercent15; depthpercent];
    trainmeans15 = [trainmeans15; trainmeans];
    valmeans15 = [valmeans15; valmeans];
    testmeans15 = [testmeans15; testmeans];

end