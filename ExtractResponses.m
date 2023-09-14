n = 300;
combs=1024;

positions = zeros(n, 3);
% responseups = zeros(n, combs);
% responsedowns = zeros(n, combs);
% fullresponse = zeros(2*n, combs);
% 
% suffix = ["0", "45", "90", "180", "cent", "0", "45", "90", "180", "cent"];
% depth = ["10", "15", "10", "15", "10", "15", "10", "15", "10", "15"];

for i = 0:n-1
    position = readNPY('responses/taros/position_taros_' + string(i) + '.npy');
    responseup = readNPY('responses/new/up_ohmc_' + string(i) + '.npy');
    responsedown = readNPY('responses/new/down_ohmc_' + string(i) + '.npy');

%     responseup = readNPY('responses/multi/upmulti_C_' + suffix(i) + '_' + depth(i) + '.npy');
%     responsedown = readNPY('responses/multi/downmulti_C_' + suffix(i) + '_' + depth(i) + '.npy');

    positions(i+1, :) = position;
%     responseups(i+1, :) = responseup;
%     responsedowns(i+1, :) = responsedown;
%     fullresponse(i*2+1,:) = responseup;
%     fullresponse(i*2+2,:) = responsedown;

%     responseups(i, :) = responseup;
%     responsedowns(i, :) = responsedown;
%     fullresponse(i*2-1,:) = responseup;
%     fullresponse(i*2,:) = responsedown;
end

%npositions = normalize(positions);
%nresponses = normalize(responses);