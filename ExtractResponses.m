n = 200;

positions = zeros(n, 3);
responses = zeros(n, 192);

for i = 0:n-1
    position = readNPY('responses/positionpoint' + string(i) + '.npy');
    response = readNPY('responses/responsepoint' + string(i) + '.npy');

    positions(i+1, :) = position;
    responses(i+1, :) = response;
end

npositions = normalize(positions);
nresponses = normalize(responses);