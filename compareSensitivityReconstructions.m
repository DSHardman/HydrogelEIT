% 6 plots: extrapolating all data from first 100, 500, 1k, 2k, 5k, & 10k
% for each: trained NN, m=1, m=3, m=10
% see superposeMaps.m

subplot = @(m,n,p)subtightplot(m,n,p,[0.15 0.05], [0.12 0.08], [0.07 0.05]);

response = responseups-responsedowns;

colors = 1/255*[27 158 119; 217 95 2; 117 112 179; 231 41 138; 0 0 0];
load('Extracted\Random\SensitivityReconstructions.mat');

subplot(2,3,1)
load("Extracted/Random/Trained/AllTrained100.mat");
output = netpredictions(net, response, response(1:100,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(1,:), 0.2);
hold on
my_shaded(1:15000, 1000*discrepancies100(:,1), 200, colors(2,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies100(:,2), 200, colors(3,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies100(:,3), 200, colors(4,:), 0.2);
title('100 Training Points');
ylim([0 70]);
ylabel('Localization Error (mm)');
my_defaults();

subplot(2,3,2)
plot(nan, 'lineWidth', 2, 'Color', colors(1,:));
hold on
plot(nan, 'lineWidth', 2, 'Color', colors(2,:));
% plot(nan, 'lineWidth', 2, 'Color', colors(3,:));
% plot(nan, 'lineWidth', 2, 'Color', colors(4,:));
load("Extracted/Random/Trained/AllTrained500.mat");
output = netpredictions(net, response, response(1:500,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(1,:), 0.2);
hold on
my_shaded(1:15000, 1000*discrepancies500(:,1), 200, colors(2,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies500(:,2), 200, colors(3,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies500(:,3), 200, colors(4,:), 0.2);
legend({'Neural Network';'Sensitivity Reconstructions'}, 'location', 'n', 'orientation', 'vertical');
% legend({'NN';'m=1';'m=3';'m=10'}, 'location', 'n', 'orientation', 'horizontal');
legend boxoff
title('500 Training Points');
ylim([0 70]);
xlabel('Press Number');
my_defaults();

subplot(2,3,3)
load("Extracted/Random/Trained/AllTrained1k.mat");
output = netpredictions(net, response, response(1:1000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(1,:), 0.2);
hold on
my_shaded(1:15000, 1000*discrepancies1000(:,1), 200, colors(2,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies1000(:,2), 200, colors(3,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies1000(:,3), 200, colors(4,:), 0.2);
title('1000 Training Points');
ylim([0 70]);
my_defaults();

subplot(2,3,4)
load("Extracted/Random/Trained/AllTrained2k.mat");
output = netpredictions(net, response, response(1:2000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(1,:), 0.2);
hold on
my_shaded(1:15000, 1000*discrepancies2000(:,1), 200, colors(2,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies2000(:,2), 200, colors(3,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies2000(:,3), 200, colors(4,:), 0.2);
title('2000 Training Points');
ylim([0 70]);
ylabel('Localization Error (mm)');
my_defaults();

subplot(2,3,5)
load("Extracted/Random/Trained/AllTrained5k.mat");
output = netpredictions(net, response, response(1:5000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(1,:), 0.2);
hold on
my_shaded(1:15000, 1000*discrepancies5000(:,1), 200, colors(2,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies5000(:,2), 200, colors(3,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies5000(:,3), 200, colors(4,:), 0.2);
title('5000 Training Points');
ylim([0 70]);
xlabel('Press Number');
my_defaults();

subplot(2,3,6)
load("Extracted/Random/Trained/AllTrained10k.mat");
output = netpredictions(net, response, response(1:10000,:));
my_shaded(1:15000, 1000*[rssq(output(:,1:2).' - positions(:,1:2).')].',...
    200, colors(1,:), 0.2);
hold on
my_shaded(1:15000, 1000*discrepancies10000(:,1), 200, colors(2,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies10000(:,2), 200, colors(3,:), 0.2);
% my_shaded(1:15000, 1000*discrepancies10000(:,3), 200, colors(4,:), 0.2);
title('10000 Training Points');
ylim([0 70]);
my_defaults();

set(gcf, 'Position', 1e3*[0.2370    0.2786    1.0696    0.5794]);