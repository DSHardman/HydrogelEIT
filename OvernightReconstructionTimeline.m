eiterror = zeros(15000,1);

for i = 1:15000
    if mod(i,100)==0
        i
        save('eiterrors.mat', 'eiterror')
    end
    eiterror(i) = calcEIT(responseups(i,:), responsedowns(i,:), "bp", positions(i,:));
end