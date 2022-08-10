% Load 5k net

for i = 15:29 %5219:5226
    pred = netpredictions(net, responseups(i,:)-responsedowns(i,:),...
    responseups(1:5000,:)-responsedowns(1:5000,:));
    calcEIT(responsedowns(i,:), responseups(i,:), "bp", positions(i,:));
    xpred = 1000*(pred(1) + 0.171/2)*270/171;
    ypred = 1000*(pred(2) + 0.171/2)*270/171;
    scatter(xpred, 270-ypred, 100, 'm', 'filled');
    exportgraphics(gcf, string(i) + ".eps", 'BackgroundColor','none');
    exportgraphics(gcf, string(i) + ".png", 'BackgroundColor','none');
    clf;
end