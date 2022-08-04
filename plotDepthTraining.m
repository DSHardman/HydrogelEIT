% Choose 5k or 10k training dataset
% load('Extracted/Random/Trained/DepthsTrained5k.mat');
load('Extracted/Random/Trained/DepthsTrained10k.mat');

figure();
colors = 1/255*[27 158 119; 217 95 2; 117 112 179];

%% MeanNegPos for error bar
mnp_5 = zeros(3);
mnp_5(:,1) = [mean(trainmeansd05(:,1)); mean(valmeansd05(:,1)); mean(testmeansd05(:,1))];
mnp_5(:,2) = [mnp_5(1,1)-min(trainmeansd05(:,1)); mnp_5(2,1)-min(valmeansd05(:,1)); mnp_5(3,1)-min(testmeansd05(:,1))];
mnp_5(:,3) = [max(trainmeansd05(:,1))-mnp_5(1,1); max(valmeansd05(:,1))-mnp_5(2,1); max(testmeansd05(:,1))-mnp_5(3,1)];
mnp_5 = 1000*mnp_5;

mnp_10 = zeros(3);
mnp_10(:,1) = [mean(trainmeansd10(:,1)); mean(valmeansd10(:,1)); mean(testmeansd10(:,1))];
mnp_10(:,2) = [mnp_10(1,1)-min(trainmeansd10(:,1)); mnp_10(2,1)-min(valmeansd10(:,1)); mnp_10(3,1)-min(testmeansd10(:,1))];
mnp_10(:,3) = [max(trainmeansd10(:,1))-mnp_10(1,1); max(valmeansd10(:,1))-mnp_10(2,1); max(testmeansd10(:,1))-mnp_10(3,1)];
mnp_10 = 1000*mnp_10;

mnp_15 = zeros(3);
mnp_15(:,1) = [mean(trainmeansd15(:,1)); mean(valmeansd15(:,1)); mean(testmeansd15(:,1))];
mnp_15(:,2) = [mnp_15(1,1)-min(trainmeansd15(:,1)); mnp_15(2,1)-min(valmeansd15(:,1)); mnp_15(3,1)-min(testmeansd15(:,1))];
mnp_15(:,3) = [max(trainmeansd15(:,1))-mnp_15(1,1); max(valmeansd15(:,1))-mnp_15(2,1); max(testmeansd15(:,1))-mnp_15(3,1)];
mnp_15 = 1000*mnp_15;

mnp_20 = zeros(3);
mnp_20(:,1) = [mean(trainmeansd20(:,1)); mean(valmeansd20(:,1)); mean(testmeansd20(:,1))];
mnp_20(:,2) = [mnp_20(1,1)-min(trainmeansd20(:,1)); mnp_20(2,1)-min(valmeansd20(:,1)); mnp_20(3,1)-min(testmeansd20(:,1))];
mnp_20(:,3) = [max(trainmeansd20(:,1))-mnp_20(1,1); max(valmeansd20(:,1))-mnp_20(2,1); max(testmeansd20(:,1))-mnp_20(3,1)];
mnp_20 = 1000*mnp_20;

%% plot

b = bar([mnp_5(:,1) mnp_10(:,1) mnp_15(:,1) mnp_20(:,1)].');
b(1).FaceColor = colors(1,:);
b(2).FaceColor = colors(2,:);
b(3).FaceColor = colors(3,:);

hold on
errorbar([0.78; 1; 1.22], mnp_5(:,1),...
    mnp_5(:,2), mnp_5(:,3), 'linestyle', 'none', 'linewidth', 2,...
    'color', 'k');
errorbar([1.78; 2; 2.22], mnp_10(:,1),...
    mnp_10(:,2), mnp_10(:,3), 'linestyle', 'none', 'linewidth', 2,...
    'color', 'k');
errorbar([2.78; 3; 3.22], mnp_15(:,1),...
    mnp_15(:,2), mnp_15(:,3), 'linestyle', 'none', 'linewidth', 2,...
    'color', 'k');
errorbar([3.78; 4; 4.22], mnp_20(:,1),...
    mnp_20(:,2), mnp_20(:,3), 'linestyle', 'none', 'linewidth', 2,...
    'color', 'k');

ylabel('xy error (mm)');
set(gca,'XTickLabel',{'5mm';'10mm';'15mm';'20mm'}, 'LineWidth', 2, 'FontSize', 13);
box off;
legend({'Training'; 'Validation'; 'Test'}, 'orientation', 'horizontal');
legend boxoff;
set(gcf, 'Position', [447.4000  614.6000  769.6000  243.4000]);
ylim([0 30]);