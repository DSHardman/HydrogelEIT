load('Extracted/Random/rollingwindow.mat');

colors = 1/255*[27 158 119; 217 95 2; 117 112 179];

figure();
subplot(2,1,1);
plot(nan, nan, 'linewidth', 2, 'color', colors(1,:));
hold on
plot(nan, nan, 'linewidth', 2, 'color', colors(2,:));
plot(nan, nan, 'linewidth', 2, 'color', colors(3,:));

my_errorplot(0:2:10, 1000*[trainmeans5(:,1) trainmeans7(:,1) trainmeans9(:,1)...
    trainmeans11(:,1) trainmeans13(:,1) trainmeans15(:,1)], colors(1,:), colors(1,:));
my_errorplot(0:2:10, 1000*[valmeans5(:,1) valmeans7(:,1) valmeans9(:,1)...
    valmeans11(:,1) valmeans13(:,1) valmeans15(:,1)], colors(2,:), colors(2,:));
my_errorplot(0:2:10, 1000*[testmeans5(:,1) testmeans7(:,1) testmeans9(:,1)...
    testmeans11(:,1) testmeans13(:,1) testmeans15(:,1)], colors(3,:), colors(3,:));

box off
set(gca, 'LineWidth', 2, 'FontSize', 13);
%xlabel('Starting point (thousands)');
ylabel('Average xy error (mm)');
legend({'Test'; 'Validation'; 'Training'}, 'location', 'nw', 'orientation', 'horizontal');
legend boxoff
xlim([-0.5 10.5]);
ylim([0 17]);

subplot(2,1,2);

my_errorplot(0:2:10, [depthpercent5(:,1) depthpercent7(:,1) depthpercent9(:,1)...
    depthpercent11(:,1) depthpercent13(:,1) depthpercent15(:,1)],...
    colors(1,:), colors(1,:));
hold on
my_errorplot(0:2:10, [depthpercent5(:,2) depthpercent7(:,2) depthpercent9(:,2)...
    depthpercent11(:,2) depthpercent13(:,2) depthpercent15(:,2)],...
    colors(2,:), colors(2,:));
my_errorplot(0:2:10, [depthpercent5(:,3) depthpercent7(:,3) depthpercent9(:,3)...
    depthpercent11(:,3) depthpercent13(:,3) depthpercent15(:,3)],...
    colors(3,:), colors(3,:));
set(gca, 'LineWidth', 2, 'FontSize', 13);
xlim([-0.5 10.5]);
ylim([60 105]);
box off
xlabel('Starting point (thousands)');
ylabel('Correct Depth Predictions (%)');

set(gcf, 'Position', [488.0000  312.2000  570.6000  545.8000]);
