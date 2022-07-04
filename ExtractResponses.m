n = 2000;

positions = zeros(n, 3);
responseups = zeros(n, 192);
responsedowns = zeros(n, 192);
fullresponse = zeros(2*n, 192);

for i = 0:n-1
    position = readNPY('responses/randommembrane/position_alldepths_' + string(i) + '.npy');
    responseup = readNPY('responses/randommembrane/up_alldepths_' + string(i) + '.npy');
    responsedown = readNPY('responses/randommembrane/down_alldepths_' + string(i) + '.npy');

    positions(i+1, :) = position;
    responseups(i+1, :) = responseup;
    responsedowns(i+1, :) = responsedown;
    fullresponse(i*2+1,:) = responseup;
    fullresponse(i*2+2,:) = responsedown;
end

%npositions = normalize(positions);
%nresponses = normalize(responses);