%% Define CNN architecture
lgraph = layerGraph();

convLayers = [
    imageInputLayer([32 32 1],'Name','input_encoder','Normalization','none')
    convolution2dLayer(3, 64, 'Padding','same', 'Stride', 1, 'Name', 'conv1')
    reluLayer('Name','relu1')
    convolution2dLayer(2, 64, 'Padding','same', 'Stride', 1, 'Name', 'conv2')
    reluLayer('Name','relu2')
    convolution2dLayer(3, 64, 'Padding','same', 'Stride', 2, 'Name', 'conv3')
    reluLayer('Name','relu3')
    convolution2dLayer(3, 128, 'Padding','same', 'Stride', 2, 'Name', 'conv4')
    reluLayer('Name','relu4')
    convolution2dLayer(2, 256, 'Padding','same', 'Stride', 2, 'Name', 'conv5')
    reluLayer('Name','relu5')
    ];
lgraph = addLayers(lgraph,convLayers);

transLayers = [
    transposedConv2dLayer(1, 64, 'Cropping', 'same', 'Stride', 1, 'Name', 'transpose1')
    reluLayer('Name','trelu1')
    transposedConv2dLayer(3, 256, 'Cropping', 'same', 'Stride', 2, 'Name', 'transpose2')
    reluLayer('Name','trelu2')
    transposedConv2dLayer(3, 128, 'Cropping', 'same', 'Stride', 2, 'Name', 'transpose3')
    reluLayer('Name','trelu3')
    transposedConv2dLayer(3, 64, 'Cropping', 'same', 'Stride', 2, 'Name', 'transpose4')
    reluLayer('Name','trelu4')
    transposedConv2dLayer(3, 64, 'Cropping', 'same', 'Stride', 2, 'Name', 'transpose5')
    reluLayer('Name','trelu5')
    transposedConv2dLayer(3, 64, 'Cropping', 'same', 'Stride', 2, 'Name', 'transpose6')
    reluLayer('Name','trelu6')
    transposedConv2dLayer(1, 3, 'Cropping', 'same', 'Name', 'transpose7')
    regressionLayer("Name","regressionoutput")
    ];

lgraph = addLayers(lgraph,transLayers);
clear tempLayers convlayers;
lgraph = connectLayers(lgraph,"relu5","transpose1");

%% Structure target images & input data
input = fileDatastore(fullfile('CNN/InputTrain'),'ReadFcn',@load,'FileExtensions','.mat');
output = fileDatastore(fullfile('CNN/OutputTrain'),'ReadFcn',@load,'FileExtensions','.mat');
inputDatat = transform(input,@(data) rearrange_datastore_input(data));
outputDatat = transform(output,@(data) rearrange_datastore_output(data));
trainData = combine(inputDatat,outputDatat);

input = fileDatastore(fullfile('CNN/InputVal'),'ReadFcn',@load,'FileExtensions','.mat');
output = fileDatastore(fullfile('CNN/OutputVal'),'ReadFcn',@load,'FileExtensions','.mat');
inputDatat = transform(input,@(data) rearrange_datastore_input(data));
outputDatat = transform(output,@(data) rearrange_datastore_output(data));
valData = combine(inputDatat,outputDatat);

input = fileDatastore(fullfile('CNN/InputTest'),'ReadFcn',@load,'FileExtensions','.mat');
output = fileDatastore(fullfile('CNN/OutputTest'),'ReadFcn',@load,'FileExtensions','.mat');
inputDatat = transform(input,@(data) rearrange_datastore_input(data));
outputDatat = transform(output,@(data) rearrange_datastore_output(data));
testData = combine(inputDatat,outputDatat);


%% Train
options = trainingOptions('adam', ...
    'MiniBatchSize',128, ...
    'MaxEpochs',10000, ...
    'InitialLearnRate',0.5*1e-3, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.5, ...
    'LearnRateDropPeriod',50, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'ExecutionEnvironment','gpu',...
    'ValidationData', valData,...
    'Verbose',true);

[net,info]=trainNetwork(trainData, lgraph, options);

% image = asd(:,1:end);
% image=reshape(image,[3,3,4999]);
% image=repmat(image,11);
% image=image(1:32,1:32,:);
% image=reshape(image,[32,32,1,4999]);
% ypred = predict(net,image);


%% Functions
function image = rearrange_datastore_input(data)
    image = data.response;
    image = reshape(image, [6, 32]);
    image = [image; image; image; image; image; image(1:2,:)];
%     image = reshape(image,[3,1,4999]);
%     image = repmat(image,32);
%     image = image(1:32,1:32,:);
%     image = reshape(image,[32,32,1,4999]);
%     
%     image = num2cell(image, 1:3); % Wrap 1x21x1x100 data in 1x1x1x100 cell
%     image = image(:); % Reshape 1x1x1x100 cell to 1x100 cell
end

function image = rearrange_datastore_output(data)
    image = data.sensmap;
    image(:,:,2) = image(:,:,1);
    image(:,:,3) = image(:,:,1);
    image = num2cell(image, 1:3);
end
