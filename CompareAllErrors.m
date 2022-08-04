load("EitRollingErrors.mat");
load("Extracted/Random/RandomSkin15k.mat");
response = responseups - responsedowns;

colors = 1/255*[0 0 0; 27 158 119; 217 95 2; 117 112 179; 231 41 138];

% Plot legend lines
for i = 1:size(colors, 1)
    plot(nan, nan, 'LineWidth', 2, 'Color', colors(i,:));
    hold on
end

my_shaded(1:15000, eiterror, 200, colors(1,:), 0.2);

load("Extracted/Random/Trained/AllTrained15k.mat");
output = netpredictions(net, response, response);
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(5,:), 0.2);

load("Extracted/Random/Trained/AllTrained10k.mat");
output = netpredictions(net, response, response(1:10000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(4,:), 0.2);

load("Extracted/Random/Trained/AllTrained5k.mat");
output = netpredictions(net, response, response(1:5000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(3,:), 0.2);

load("Extracted/Random/Trained/AllTrained2k.mat");
output = netpredictions(net, response, response(1:2000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(2,:), 0.2);


legend({'Reconstructed'; '2k'; '5k'; '10k'; '15k'},...
    'Location', 'nw', 'Orientation', 'Horizontal', 'FontSize', 13);
legend boxoff
my_defaults([349.0000  422.6000  744.0000  435.4000]);
xlabel('Press Number');
ylabel('Localization Error (mm)');
ylim([0 105]);