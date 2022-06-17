function plotProbes(lookup, i)
    viscircles([0 0], 1);
    hold on
    for j = 1:2
        scatter(sin(2*pi*lookup(i, j)/32), -cos(2*pi*lookup(i, j)/32), 50, 'r', 'filled');
    end
    for j = 3:4
        scatter(sin(2*pi*lookup(i, j)/32), -cos(2*pi*lookup(i, j)/32), 50, 'k', 'filled');
    end
    xlim([-1 1]);
    ylim([-1 1]);
    axis square;
    hold off
end