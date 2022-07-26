plot(responseups(32,:), 'LineWidth', 2, 'Color', 'k');
hold on
plot(responsedowns(32,:), 'LineWidth', 2, 'Color', 'b');
box off
set(gca, 'LineWidth', 2, 'FontSize', 13);
xlabel('Probe Configuration');
ylabel('Signal');
legend({'Before Press'; 'During Press'}, 'location', 'ne');
legend boxoff
set(gcf, 'Position', [488.0000  473.8000  590.6000  384.2000]);