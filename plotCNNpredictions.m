for i = 1:1500
    index = testinds(i);
    load('CNN/InputTest/'+string(index)+'.mat');
    load('CNN/OutputTest/'+string(index)+'.mat');

    image = reshape(response, [6, 32]);
    image = [image; image; image; image; image; image(1:2,:)];
    ypred = predict(net,image);

    subplot(1,2,1);
    contourf(sensmap, 20, 'LineStyle', 'none');
    axis square
    title('Prediction');
    set(gca, 'XTick', []);
    set(gca, 'visible', 'off');

    subplot(1,2,2);
    contourf(ypred(:,:,1), 20, 'LineStyle', 'none');
    axis square
    title('Target');
    set(gca, 'XTick', [], 'YTick', []);

    sgtitle(string(index) + ": Depth = " + string(positions(index,3)) + "mm");
    pause();
    clf();
end
