%% Combine extracted values into single array

% Initialise cell array
EITimages = zeros(10000, 363);

for i = 1:10000
    image = readNPY("C:\Users\dshar\OneDrive - University of Cambridge\Documents\PhD\EIT\responses\IMG" + string(i-1) + ".npy");
    EITimages(i, :) = image.';
end

%% Plot results

load("CircleNodes.mat"); % x/y positions for 363D data

for i = 1:100
    %subplot(1,2,1);
    scatter(x, y, 70, EITimages(i,:), 'filled');
    axis square
%     subplot(1,2,2);
%     scatter(positions(i,1), positions(i,2));
%     xlim([0 0.13]);
%     ylim([0 0.06]);
    pause()
    close();
end

