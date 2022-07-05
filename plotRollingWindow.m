load('Extracted/Random/rollingwindow.mat');

figure();
subplot(2,1,1);
plot([0:2:10], 1000*[testmeans5(1) testmeans7(1) testmeans9(1) testmeans11(1) testmeans13(1) testmeans15(1)], 'linewidth', 2);
hold on
plot([0:2:10], 1000*[valmeans5(1) valmeans7(1) valmeans9(1) valmeans11(1) valmeans13(1) valmeans15(1)], 'linewidth', 2);
plot([0:2:10], 1000*[trainmeans5(1) trainmeans7(1) trainmeans9(1) trainmeans11(1) trainmeans13(1) trainmeans15(1)], 'linewidth', 2);
box off
set(gca, 'LineWidth', 2, 'FontSize', 13);
xlabel('Starting point (thousands)');
ylabel('xy error (mm)');
title('5k rolling window');
legend({'Test'; 'Validation'; 'Training'}, 'location', 'nw');
legend boxoff

subplot(2,1,2);
plot([0:2:10], 1000*[testmeans5(2) testmeans7(2) testmeans9(2) testmeans11(2) testmeans13(2) testmeans15(2)], 'linewidth', 2);
hold on
plot([0:2:10], 1000*[valmeans5(2) valmeans7(2) valmeans9(2) valmeans11(2) valmeans13(2) valmeans15(2)], 'linewidth', 2);
plot([0:2:10], 1000*[trainmeans5(2) trainmeans7(2) trainmeans9(2) trainmeans11(2) trainmeans13(2) trainmeans15(2)], 'linewidth', 2);
box off
set(gca, 'LineWidth', 2, 'FontSize', 13);
xlabel('Starting point (thousands)');
ylabel('Depth error (mm)');
legend({'Test'; 'Validation'; 'Training'}, 'location', 'nw');
legend boxoff

set(gcf, 'position', [488.0000  341.0000  564.2000  517.0000]);