load('DamageTests/Damage.mat');
load('Extracted/MultiTouch/superpose500.mat');

%% Initial plot of response
% nb need to export in two halves to avoid matlab's multi-object workaround
plot(0:8:8*(size(damage,1)-1), damage, 'LineWidth', 1);
my_defaults([267.4000  417.0000  694.4000  420.0000]);
ylabel('YUNIT');
xlabel('Time (s)');
xlim([0 6700]);