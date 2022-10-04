n = 1000; % How many points should be used in constructing sensitivity maps?

magnitudes = responsedowns(1:n,:) - responseups(1:n,:);
for i = 1:size(magnitudes, 1)
    [theta, rho] = cart2pol(positions(i,1), positions(i,2));
    % magnitudes(i,:) = magnitudes(i,:)*(1 - 1/(74 - rho*1000));
    magnitudes(i,:) = abs(magnitudes(i,:)*(1.1 - (rho*1000)/60));
    magnitudes(i,:) = normalize(magnitudes(i,:).');
    magnitudes(i,:) = tanh(magnitudes(i,:));
end

for i = 1:150
%     subplot(1,2,1);
%     %plotProbes(lookup,i);
%     title(string(i));
% 
%     subplot(1,2,2);
    scatter(positions(1:n,1), positions(1:n,2), 10, magnitudes(:,i), 'filled');
%     interpolant = scatteredInterpolant(positions(1:n,1),...
%         positions(1:n,2),magnitudes(:,i));
%     [xx,yy] = meshgrid(linspace(-0.06,0.06,1000));
%     mag_interp = interpolant(xx,yy);
%     % Remove points from outside circle
%     for k = 1:size(xx,1)
%         for j = 1:size(xx,2)
%             if xx(k,j)^2 + yy(k,j)^2 > 0.06^2
%                 mag_interp(k,j) = nan;
%             end
%         end
%     end
%     contourf(xx,yy,mag_interp, 20, 'LineStyle', 'none');

    xlim([-0.08 0.08]);
    ylim([-0.08 0.08]);
    axis square
    colorbar
    %caxis([0 max(magnitudes(:,i))/5]);
%     set(gca, 'visible', 'off');
    title(string(i));
%     set(gcf, 'Position', [636 268 839 510]);
    set(gcf, 'Position', [1092 570 383 208]);
    pause();
    clf
end