load('Extracted\Random\Trained\AllTrained500.mat');

for i = 10001
    superposeMaps(500, responsedowns, responseups, positions, i, 1);
    output = netpredictions(net, responseups(i,:)-responsedowns(i,:), responseups(1:500,:)-responsedowns(1:500,:));
    scatter(output(1), output(2), 50, 'm', 'filled');
%     exportgraphics(gcf, string(i) + "sens.eps", 'BackgroundColor','none');
%     exportgraphics(gcf, string(i) + "clearsens.png", 'BackgroundColor','w', 'Resolution',300);
%     clf;
end