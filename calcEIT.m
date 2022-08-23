function [discrepancy, eitpred] = calcEIT(signal, reference, solver, position)
    % Solver can be jac, bp, or greit 
    assert(length(signal)==192);
    assert(length(reference)==192);

    save('OpenEIT\reconstruction\pyeit\temp\response.mat',"signal");
    save('OpenEIT\reconstruction\pyeit\temp\reference.mat',"reference");
    % evalc supresses output to cmd window: careful with error handling...
%     system('python OpenEIT\reconstruction\pyeit\calcEIT.py '  + solver);
    evalc("system('python OpenEIT\reconstruction\pyeit\calcEIT.py '  + solver);");
    % imshow(imread('OpenEIT\reconstruction\pyeit\temp\outputimg.png'));
    im = imread('OpenEIT\reconstruction\pyeit\temp\outputimg.png');
    im = im(60:329,161:430,:);


%     darkval = min(min(im2gray(im)));
    % find lightest pixel that isn't the pure white border
    lightval = max(max(mod(im2gray(im),254)));
    [rowVal, colVal] = find(im2gray(im) == lightval);
    eitpred = [mean(colVal) mean(rowVal)];
    imshow(im);
    hold on
%     scatter(eitpred(1), eitpred(2), 100, 'r', 'filled');
    if nargin == 4
        assert(length(position)==3);
        xy = (position(1:2) + 0.171/2)*1000*270./171;
        scatter(xy(1), 270-xy(2), 100, 'w', 'filled');
        %title('Depth = '+string(position(3)*100)+'cm');
    end

    eitpred = [eitpred(1)*171/270 eitpred(2)*171/270] - [171/2 171/2];
    if nargin == 4
        discrepancy = norm([eitpred(1) -eitpred(2)] - position(1:2)*1000);
    else
        discrepancy = nan;
    end

    %exportgraphics(gcf, 'output.eps', 'BackgroundColor','none');
end