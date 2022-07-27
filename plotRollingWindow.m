%load('Extracted/Random/rollingwindow.mat');

% MeanNegPos extractions
mnp_5 = zeros(3);
mnp_5(:,1) = [mean(trainmeans5(:,1)); mean(valmeans5(:,1)); mean(testmeans5(:,1))];
mnp_5(:,2) = [mnp_5(1,1)-min(trainmeans5(:,1)); mnp_5(2,1)-min(valmeans5(:,1)); mnp_5(3,1)-min(testmeans5(:,1))];
mnp_5(:,3) = [max(trainmeans5(:,1))-mnp_5(1,1); max(valmeans5(:,1))-mnp_5(2,1); max(testmeans5(:,1))-mnp_5(3,1)];

mnp_7 = zeros(3);
mnp_7(:,1) = [mean(trainmeans7(:,1)); mean(valmeans7(:,1)); mean(testmeans7(:,1))];
mnp_7(:,2) = [mnp_7(1,1)-min(trainmeans7(:,1)); mnp_7(2,1)-min(valmeans7(:,1)); mnp_7(3,1)-min(testmeans7(:,1))];
mnp_7(:,3) = [max(trainmeans7(:,1))-mnp_7(1,1); max(valmeans7(:,1))-mnp_7(2,1); max(testmeans7(:,1))-mnp_7(3,1)];

mnp_9 = zeros(3);
mnp_9(:,1) = [mean(trainmeans9(:,1)); mean(valmeans9(:,1)); mean(testmeans9(:,1))];
mnp_9(:,2) = [mnp_9(1,1)-min(trainmeans9(:,1)); mnp_9(2,1)-min(valmeans9(:,1)); mnp_9(3,1)-min(testmeans9(:,1))];
mnp_9(:,3) = [max(trainmeans9(:,1))-mnp_9(1,1); max(valmeans9(:,1))-mnp_9(2,1); max(testmeans9(:,1))-mnp_9(3,1)];

mnp_11 = zeros(3);
mnp_11(:,1) = [mean(trainmeans11(:,1)); mean(valmeans11(:,1)); mean(testmeans11(:,1))];
mnp_11(:,2) = [mnp_11(1,1)-min(trainmeans11(:,1)); mnp_11(2,1)-min(valmeans11(:,1)); mnp_11(3,1)-min(testmeans11(:,1))];
mnp_11(:,3) = [max(trainmeans11(:,1))-mnp_11(1,1); max(valmeans11(:,1))-mnp_11(2,1); max(testmeans11(:,1))-mnp_11(3,1)];

mnp_13 = zeros(3);
mnp_13(:,1) = [mean(trainmeans13(:,1)); mean(valmeans13(:,1)); mean(testmeans13(:,1))];
mnp_13(:,2) = [mnp_13(1,1)-min(trainmeans13(:,1)); mnp_13(2,1)-min(valmeans13(:,1)); mnp_13(3,1)-min(testmeans13(:,1))];
mnp_13(:,3) = [max(trainmeans13(:,1))-mnp_13(1,1); max(valmeans13(:,1))-mnp_13(2,1); max(testmeans13(:,1))-mnp_13(3,1)];

mnp_15 = zeros(3);
mnp_15(:,1) = [mean(trainmeans15(:,1)); mean(valmeans15(:,1)); mean(testmeans15(:,1))];
mnp_15(:,2) = [mnp_15(1,1)-min(trainmeans15(:,1)); mnp_15(2,1)-min(valmeans15(:,1)); mnp_15(3,1)-min(testmeans15(:,1))];
mnp_15(:,3) = [max(trainmeans15(:,1))-mnp_15(1,1); max(valmeans15(:,1))-mnp_15(2,1); max(testmeans15(:,1))-mnp_15(3,1)];

%%

figure();
%subplot(2,1,1);
plot([0:2:10], 1000*[mnp_5(3,1) mnp_7(3,1) mnp_9(3,1) mnp_11(3,1) mnp_13(3,1) mnp_15(3,1)], 'linewidth', 2);
hold on
plot([0:2:10], 1000*[mnp_5(2,1) mnp_7(2,1) mnp_9(2,1) mnp_11(2,1) mnp_13(2,1) mnp_15(2,1)], 'linewidth', 2);
plot([0:2:10], 1000*[mnp_5(1,1) mnp_7(1,1) mnp_9(1,1) mnp_11(1,1) mnp_13(1,1) mnp_15(1,1)], 'linewidth', 2);

% Add error bars
errorbar(0:2:10, 1000*[mnp_5(3,1) mnp_7(3,1) mnp_9(3,1) mnp_11(3,1) mnp_13(3,1) mnp_15(3,1)],...
    1000*[mnp_5(3,2) mnp_7(3,2) mnp_9(3,2) mnp_11(3,2) mnp_13(3,2) mnp_15(3,2)],...
    1000*[mnp_5(3,3) mnp_7(3,3) mnp_9(3,3) mnp_11(3,3) mnp_13(3,3) mnp_15(3,3)],...
    'color', 'k', 'lineWidth', 2, 'linestyle', 'none');
errorbar(0:2:10, 1000*[mnp_5(2,1) mnp_7(2,1) mnp_9(2,1) mnp_11(2,1) mnp_13(2,1) mnp_15(2,1)],...
    1000*[mnp_5(2,2) mnp_7(2,2) mnp_9(2,2) mnp_11(2,2) mnp_13(2,2) mnp_15(2,2)],...
    1000*[mnp_5(2,3) mnp_7(2,3) mnp_9(2,3) mnp_11(2,3) mnp_13(2,3) mnp_15(2,3)],...
    'color', 'k', 'lineWidth', 2, 'linestyle', 'none');
errorbar(0:2:10, 1000*[mnp_5(1,1) mnp_7(1,1) mnp_9(1,1) mnp_11(1,1) mnp_13(1,1) mnp_15(1,1)],...
    1000*[mnp_5(1,2) mnp_7(1,2) mnp_9(1,2) mnp_11(1,2) mnp_13(1,2) mnp_15(1,2)],...
    1000*[mnp_5(1,3) mnp_7(1,3) mnp_9(1,3) mnp_11(1,3) mnp_13(1,3) mnp_15(1,3)],...
    'color', 'k', 'lineWidth', 2, 'linestyle', 'none');

box off
set(gca, 'LineWidth', 2, 'FontSize', 13);
xlabel('Starting point (thousands)');
ylabel('xy error (mm)');
%title('5k rolling window');
legend({'Test'; 'Validation'; 'Training'}, 'location', 'nw');
legend boxoff
xlim([-0.5 10.5]);

% subplot(2,1,2);
% plot([0:2:10], 1000*[testmeans5(2) testmeans7(2) testmeans9(2) testmeans11(2) testmeans13(2) testmeans15(2)], 'linewidth', 2);
% hold on
% plot([0:2:10], 1000*[valmeans5(2) valmeans7(2) valmeans9(2) valmeans11(2) valmeans13(2) valmeans15(2)], 'linewidth', 2);
% plot([0:2:10], 1000*[trainmeans5(2) trainmeans7(2) trainmeans9(2) trainmeans11(2) trainmeans13(2) trainmeans15(2)], 'linewidth', 2);
% box off
% set(gca, 'LineWidth', 2, 'FontSize', 13);
% xlabel('Starting point (thousands)');
% ylabel('Depth error (mm)');
% legend({'Test'; 'Validation'; 'Training'}, 'location', 'nw');
% legend boxoff

set(gcf, 'position', [488.0000  341.0000  564.2000  517.0000]);