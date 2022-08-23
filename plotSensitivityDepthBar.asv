load("Extracted\Random\SensitivityQuivers.mat");
load("Extracted\Random\RandomSkin15k.mat");

data5 = 1000*builddata(positions, predictions, 0.005);
data10 = 1000*builddata(positions, predictions, 0.010);
data15 = 1000*builddata(positions, predictions, 0.015);
data20 = 1000*builddata(positions, predictions, 0.020);

my_colors;
my_errorbar({data5; data10; data15; data20}, colors(1:4, :), ['none'; 'none'; 'none'; 'none']);
ylim([0 50]);
my_defaults(1000*[0.2514    0.3986    1.1400    0.3312]);
set(gca, 'XTickLabels', []);
legend({'5 mm'; '10 mm'; '15 mm'; '20 mm'}, 'location', 'nw', 'orientation', 'vertical');
legend boxoff
ylabel('Mean Localization Error (mm)');

function dataout = adddata(data, positions, predictions, n, depth)
    inds = find(positions(1+n:500+n,3) == depth);
    dim = min(length(inds), size(data, 1));
    dataout = [data(1:dim, :) rssq(positions(inds(1:dim)+n, 1:2).' - predictions(inds(1:dim), :).').'];
end

function dataout = builddata(positions, predictions, depth)
    inds = find(positions(1:500,3) == depth);
    data = rssq(positions(inds, 1:2).' - predictions(inds, 1:2).').';
    data = adddata(data, positions, predictions(:, 3:4), 2500, depth);
    data = adddata(data, positions, predictions(:, 5:6), 5000, depth);
    data = adddata(data, positions, predictions(:, 7:8), 7500, depth);
    data = adddata(data, positions, predictions(:, 9:10), 10000, depth);
    data = adddata(data, positions, predictions(:, 11:12), 12500, depth);
    dataout = adddata(data, positions, predictions(:, 13:14), 14500, depth);
end
