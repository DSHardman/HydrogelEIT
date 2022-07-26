% Create data to use in plotDepthTraining.m

% Create variables for position/response at each of the discrete depths
response5 = [];
response10 = [];
response15 = [];
response20 = [];
positions5 = [];
positions10 = [];
positions15 = [];
positions20 = [];

for i = 1:5000 % Calculate over first 5000 probes, before rapid propagation
    switch positions(i,3)
        case 0.005
            response5 = [response5; responseups(i,:) responsedowns(i,:)];
            positions5 = [positions5; positions(i,:)];
        case 0.01
            response10 = [response10; responseups(i,:) responsedowns(i,:)];
            positions10 = [positions10; positions(i,:)];
        case 0.015
            response15 = [response15; responseups(i,:) responsedowns(i,:)];
            positions15 = [positions15; positions(i,:)];
        case 0.02
            response20 = [response20; responseups(i,:) responsedowns(i,:)];
            positions20 = [positions20; positions(i,:)];
        otherwise
            fprintf('NO MATCHING DEPTH FOUND\n');
            continue
    end
end

% Initialise
trainmeansd05 = [];
valmeansd05 = [];
testmeansd05 = [];

trainmeansd10 = [];
valmeansd10 = [];
testmeansd10 = [];

trainmeansd15 = [];
valmeansd15 = [];
testmeansd15 = [];

trainmeansd20 = [];
valmeansd20 = [];
testmeansd20 = [];

% 10 repetitions for each.
for i = 1:10

    fprintf('Starting run %d...\n', i);

    fprintf('5mm\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~] = sensorTrain(response5, positions5, [300 50 20], [0.8 0.1 0.1], 0);
    trainmeansd05 = [trainmeansd05; trainmeans];
    valmeansd05 = [valmeansd05; valmeans];
    testmeansd05 = [testmeansd05; testmeans];
    
    fprintf('10mm\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~] = sensorTrain(response10, positions10, [300 50 20], [0.8 0.1 0.1], 0);
    trainmeansd10 = [trainmeansd10; trainmeans];
    valmeansd10 = [valmeansd10; valmeans];
    testmeansd10 = [testmeansd10; testmeans];
    
    fprintf('15mm\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~] = sensorTrain(response15, positions15, [300 50 20], [0.8 0.1 0.1], 0);
    trainmeansd15 = [trainmeansd15; trainmeans];
    valmeansd15 = [valmeansd15; valmeans];
    testmeansd15 = [testmeansd15; testmeans];
    
    fprintf('20mm\n');
    [trainmeans, valmeans, testmeans, ~, ~, ~, ~] = sensorTrain(response20, positions20, [300 50 20], [0.8 0.1 0.1], 0);
    trainmeansd20 = [trainmeansd20; trainmeans];
    valmeansd20 = [valmeansd20; valmeans];
    testmeansd20 = [testmeansd20; testmeans];

end