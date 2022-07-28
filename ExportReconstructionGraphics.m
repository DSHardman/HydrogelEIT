for i = 15:29
    calcEIT(responseups(i,:), responsedowns(i,:), "bp", positions(i,:));
    xpred = 1000*(pred(i-14,1) + 0.171/2)*270/171;
    ypred = 1000*(pred(i-14,2) + 0.171/2)*270/171;
    scatter(xpred, 270-ypred, 100, 'm', 'filled');
    exportgraphics(gcf, string(i) + ".eps", 'BackgroundColor','none');
    clf;
end