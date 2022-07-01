function calcEIT(signal, reference, position)
    assert(length(signal)==192);
    assert(length(reference)==192);
    if nargin == 3
        assert(length(position)==3);
        subplot(1,2,2);
        xy = position(1:2);
        % Rotate to match pyEIT plot
%         xy = xy*[cos(pi/4) sin(pi/4); -sin(pi/4) cos(pi/4)];
        xy = xy*[0 1; 1 0];
        viscircles([0, 0], 70);
        hold on
        scatter(xy(1)*1000, xy(2)*1000);
        title('Depth = '+string(position(3)*100)+'cm')
        axis square
        subplot(1,2,1);
    end

    save('OpenEIT\reconstruction\pyeit\temp\response.mat',"signal");
    save('OpenEIT\reconstruction\pyeit\temp\reference.mat',"reference");
    system('python OpenEIT\reconstruction\pyeit\calcEIT.py');
    imshow(imread('OpenEIT\reconstruction\pyeit\temp\outputimg.png'));

    if nargin == 3
        set(gcf, 'Position', [105 399 1581 520]);
    else
        set(gcf, 'Position', [585 495 750 477]);
    end
end