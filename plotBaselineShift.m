v = VideoWriter('baseshift');
v.FrameRate = 30;
open(v)
load("Extracted/Random/Trained/AllTrained2k.mat");

for i = 20:20:15000
    [discrepancy, eitpred] = calcEIT(responseups(i,:), responseups(1,:), "bp");
    for j = 1:20
        output = netpredictions(net, responseups(1,:)-responseups(i+j-20,:),...
            responsedowns(1:2000,:)-responseups(1:2000,:));
        xy = (output(1:2) + 0.171/2)*1000*270./171;
        scatter(xy(1), 270-xy(2), 100, 'k', 'filled');
    end

    writeVideo(v,getframe(gcf));
    title(string(i));
end
close(v)
