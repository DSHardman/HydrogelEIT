n = 500;

positions = zeros(n, 3);
responseups = zeros(n, 192);
responsedowns = zeros(n, 192);
fullresponse = zeros(2*n, 192);
% 
% suffix = ["0", "45", "90", "180", "cent", "0", "45", "90", "180", "cent"];
% depth = ["10", "15", "10", "15", "10", "15", "10", "15", "10", "15"];

for i = 0:n-1
    position = readNPY('responses/ohmc8/position_ohmc_' + string(i) + '.npy');
    responseup = readNPY('responses/ohmc8/up_ohmc_' + string(i) + '.npy');
    responsedown = readNPY('responses/ohmc8/down_ohmc_' + string(i) + '.npy');

%     responseup = readNPY('responses/multi/upmulti_C_' + suffix(i) + '_' + depth(i) + '.npy');
%     responsedown = readNPY('responses/multi/downmulti_C_' + suffix(i) + '_' + depth(i) + '.npy');

    positions(i+1, :) = position;
    responseups(i+1, :) = responseup;
    responsedowns(i+1, :) = responsedown;
    fullresponse(i*2+1,:) = responseup;
    fullresponse(i*2+2,:) = responsedown;

%     responseups(i, :) = responseup;
%     responsedowns(i, :) = responsedown;
%     fullresponse(i*2-1,:) = responseup;
%     fullresponse(i*2,:) = responsedown;
end

%npositions = normalize(positions);
%nresponses = normalize(responses);