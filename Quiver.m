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