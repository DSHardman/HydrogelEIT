n = 15;

positions = zeros(n, 3);
responseups = zeros(n, 192);
responsedowns = zeros(n, 192);
fullresponse = zeros(2*n, 192);

for i = 0:n-1
    position = readNPY('responses/membrane/position_doubleheal2_' + string(i) + '.npy');
    responseup = readNPY('responses/membrane/up_doubleheal2_' + string(i) + '.npy');
    responsedown = readNPY('responses/membrane/down_doubleheal2_' + string(i) + '.npy');

    positions(i+1, :) = position;
    responseups(i+1, :) = responseup;
    responsedowns(i+1, :) = responsedown;
    fullresponse(i*2+1,:) = responseup;
    fullresponse(i*2+2,:) = responsedown;
end

%npositions = normalize(positions);
%nresponses = normalize(responses);