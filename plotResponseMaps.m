n = 2000; % How many points should be used in constructing sensitivity maps?

magnitudes = responsedowns(1:n,:) - responseups(1:n,:);
for i = 1:size(magnitudes, 1)
    [theta, rho] = cart2pol(positions(i,1), positions(i,2));
    % magnitudes(i,:) = magnitudes(i,:)*(1 - 1/(74 - rho*1000));
    magnitudes(i,:) = abs(magnitudes(i,:)*(1.1 - (rho*1000)/70));
    magnitudes(i,:) = normalize(magnitudes(i,:));
    magnitudes(i,:) = tanh(magnitudes(i,:));
end

for i = 115:150
    subplot(1,2,1);
    plotProbes(lookup,i);

    subplot(1,2,2);
    scatter(positions(1:n,1), positions(1:n,2), 10, magnitudes(:,i), 'filled');
    xlim([-0.08 0.08]);
    ylim([-0.08 0.08]);
    axis square
    colorbar
    %caxis([0 max(magnitudes(:,i))/5]);
    %caxis([-1 1]);
    title(string(i));
    set(gcf, 'Position', [636 268 839 510]);
    pause();
    clf
end