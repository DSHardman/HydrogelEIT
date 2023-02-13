rad = 70;
num = 1000;

sun_coords = sunflower(num, 2);
sun_coords = rad*sun_coords;
distances = zeros(num, 1);

for i = 1:num
    [~,inds] = sort(sqrt(sum(bsxfun(@minus, sun_coords, sun_coords(i,:)).^2,2)), 'ascend');
    distances(i) = norm(sun_coords(i,:) - sun_coords(inds(2),:));
end

mean(distances)/2

% searchspace = -rad:2*rad/searchres:rad;

% distances = [];
% for i = 1:length(searchspace)
%     for j = 1:length(searchspace)
%         if norm([searchspace(i) searchspace(j)]) <= rad
%             inds = dsearchn([searchspace(i) searchspace(j)], sun_coords);
%             distances = [distances; norm([searchspace(i) searchspace(j)] - sun_coords(inds(1), :))];
%         end
%     end
% end

function coords = sunflower(n, alpha)   %  example: n=500, alpha=2
    coords = zeros(n, 2);
    clf
    hold on
    b = round(alpha*sqrt(n));      % number of boundary points
    phi = (sqrt(5)+1)/2;           % golden ratio
    for k=1:n
        r = radius(k,n,b);
        theta = 2*pi*k/phi^2;
        coords(k,:) = [r*cos(theta) r*sin(theta)];
        plot(r*cos(theta), r*sin(theta), 'r*');
    end
    axis square
    xlim([-1 1]);
    ylim([-1 1]);
end

function r = radius(k,n,b)
    if k>n-b
        r = 1;            % put on the boundary
    else
        r = sqrt(k-1/2)/sqrt(n-(b+1)/2);     % apply square root
    end
end