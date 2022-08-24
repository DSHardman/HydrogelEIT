load('DamageTests/Damage.mat');
load('Extracted/MultiTouch/superpose500.mat');

%% Initial plot of response
% nb need to export in two halves to avoid matlab's multi-object workaround
plot(0:8:8*(size(damage,1)-1), damage(:,91:end), 'LineWidth', 1);
my_defaults([773.8000  457.8000  399.2000  281.6000]);
ylabel('YUNIT');
xlabel('Time (s)');
xlim([0 6700]);

%% Plot environmental effects
% nb would only export as png: ~3M nodes
load('Extracted/Random/RandomSkin15k.mat');
plot(responseups, 'LineWidth', 1);
my_defaults(1000*[0.0826    0.5818    1.2648    0.2762]);
set(gca, 'FontSize', 17)
ylabel('YUNIT');
xlabel('Presses');