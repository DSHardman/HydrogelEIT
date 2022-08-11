%% Rectangle

X = [];
Y = [];
U = [];
V = [];

for i = 0:0.005:0.13
    for j = 0:0.005:0.06
        closest_ind = 1;
        closest = 100;
        for k = 1:10000
            if rssq([i j] - positions(k, 1:2)) < closest
                closest = rssq([i j] - positions(k, 1:2));
                closest_ind = k;
            end
        end

        ypred = predict(net, inp(closest_ind,:));
        ypred(:,1) = ypred(:,1)*0.13;
        ypred(:,2) = ypred(:,2)*0.06;

        X = [X; positions(closest_ind,1)];
        Y = [Y; positions(closest_ind,2)];
        U = [U; ypred(:,1) - positions(closest_ind,1)];
        V = [V; ypred(:,2) - positions(closest_ind,2)];
    end
end

quiver(X,Y,U,V, 'off');

% 
% ypred = predict(net, inp);
% ypred(:,1) = ypred(:,1)*0.13;
% ypred(:,2) = ypred(:,2)*0.06;
% 
% errors = 1000*rssq([positions(P(9001:end),1:2) - ypred(P(9001:end),:)].').';
% mean(errors)

%% Circle

load('Extracted/Random/DepthsQuiver5k.mat');
subplot = @(m,n,p)subtightplot(m,n,p,[0.05 0.001], [0.05 0.05], [0.01 0.01]);

figure();

subplot(2,2,1);
plotQuiver(target5, pred5);
title('5 mm');

subplot(2,2,2);
plotQuiver(target10, pred10);
title('10 mm');

subplot(2,2,3);
plotQuiver(target15, pred15);
title('15 mm');

subplot(2,2,4);
plotQuiver(target20, pred20);
title('20 mm');

%% EIT Backprojected: takes a long time to run

eitpred5 = eitpredictions(target5, positions, responseups, responsedowns);
fprintf("5 done\n");
eitpred10 = eitpredictions(target10, positions, responseups, responsedowns);
fprintf("10 done\n");
eitpred15 = eitpredictions(target15, positions, responseups, responsedowns);
fprintf("15 done\n");
eitpred20 = eitpredictions(target20, positions, responseups, responsedowns);

%% plot EIT quivers

figure();

subplot(1,4,1);
plotQuiver(target5, eitpred5);
title('5 mm');

subplot(1,4,2);
plotQuiver(target10, eitpred10);
title('10 mm');

subplot(1,4,3);
plotQuiver(target15, eitpred15);
title('15 mm');

subplot(1,4,4);
plotQuiver(target20, eitpred20);
title('20 mm');
%%
function eitpreds = eitpredictions(target, positions, responseups, responsedowns)
    eitpreds = zeros(size(target, 1), 2);

    % find index corresponding to NNs test set
    for i = 1:size(target, 1)
        for j = 1:5000
            if isequal(positions(j,:), target(i,:))
                break;
            end
        end
        
        [~, eitpred] = calcEIT(responsedowns(j,:),...
            responseups(j,:), "bp", positions(j,:));
    
        % Reflect to account for image coordinate system
        eitpreds(i,:) = [eitpred(1) -eitpred(2)]./1000;
    
    end
end

function plotQuiver(target, pred)
    viscircles([0 0], 0.07, 'color', 'k', 'LineWidth', 1);
    hold on
    quiver(target(:,1), target(:,2), pred(:,1)-target(:,1), pred(:,2)-target(:,2), 'off', 'color', 'k');
    hold on
    scatter(target(:,1), target(:,2), 30, 'k', 'filled');
    scatter(pred(:,1), pred(:,2), 30, 'r', 'filled');
    xlim([-0.085 0.085]);
    ylim([-0.085 0.085]);
    axis square
    set(gca, 'XTick', [], 'YTick', [], 'XColor', [1 1 1], 'YColor', [1 1 1], 'FontSize', 13);
    box off
    set(gcf, 'Position', 1000*[0.0730    0.3522    1.3752    0.3856]);
end