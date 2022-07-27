function calcEIT(signal, reference, solver, position)
    % Solver can be jac, bp, or greit 
    assert(length(signal)==192);
    assert(length(reference)==192);
    if nargin == 4
        assert(length(position)==3);
        subplot(1,2,2);
        xy = position(1:2);
        viscircles([0, 0], 70);
        hold on
        scatter(xy(1)*1000, xy(2)*1000);
        title('Depth = '+string(position(3)*100)+'cm')
        axis square
        subplot(1,2,1);
    end

    save('OpenEIT\reconstruction\pyeit\temp\response.mat',"signal");
    save('OpenEIT\reconstruction\pyeit\temp\reference.mat',"reference");
    system("python OpenEIT\reconstruction\pyeit\calcEIT.py "  + solver);
    imshow(imread('OpenEIT\reconstruction\pyeit\temp\outputimg.png'));

    if nargin == 4
        set(gcf, 'Position', 1000*[0.0730    0.3954    1.4048    0.4328]);
    else
        set(gcf, 'Position', [585 295 750 477]);
    end
end