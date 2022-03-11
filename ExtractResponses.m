n = 3452;

positions = zeros(n, 3);
responses = zeros(n, 192);

for i = 0:n-1
    position = readNPY('responses/position' + string(i) + '.npy');
    response = readNPY('responses/response' + string(i) + '.npy');

    positions(i+1, :) = position;
    responses(i+1, :) = response;
end

npositions = normalize(positions);
nresponses = normalize(responses);