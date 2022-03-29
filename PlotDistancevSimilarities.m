n = 500000;

C = nchoosek(1:10000, 2);

y = randsample(length(C), n);

similarities = zeros(n, 2);

for i = 1:n
    samples = C(y(i),:);
    %similarity = dot(double(btrain(samples(1),:))./norm(double(btrain(samples(1),:))),...
    %    double(btrain(samples(2),:))./norm(double(btrain(samples(2),:))));

    similarity = dot(double(btrain(samples(1),:)),...
        double(btrain(samples(2),:)));
    similarities(i,:) = [similarity rssq(positions(samples(1),1:2)-positions(samples(2),1:2))];
end
figure()
scatter(similarities(:,2), similarities(:,1));
xlabel('Distance (m)');
ylabel('Similarity');

clear C y