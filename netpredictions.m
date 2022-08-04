function output = netpredictions(net, input, trainedinput)
    % For random set of circular training
    % Uses pretrained net to make predictions, applying the normalization
    % factors and output scaling used for the original set

    input = (input - mean(trainedinput))./std(trainedinput);
    
    output = predict(net, input);

    %% Convert predictions to desired format
    output(:,1) = output(:,1).*0.07;
    output(:,2) = output(:,2).*0.07;
    output(:,3) = (output(:,3).*0.015)+0.005;

end