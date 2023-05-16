
function GeneralDatasetML()

load('dataset.mat'); % load file
rng("default") % random number generator, use default value

K = 10; % 10 splits

cv = cvpartition(size(diseases,1),'KFold',K);

avgLoss = 0.0; % initialize loss

for k = 1:K

    disp("Training on split no. " + k)
    
    FeaturesTrain = symptoms(training(cv, k),:); % Select the training data from the symptoms table as our features
    TargetTrain = diseases(training(cv,k),:); % Select the training data from the diseases table as our target
    FeaturesTest = symptoms(test(cv, k),:); % Select the testing data from the symptoms table as our features
    TargetTest = diseases(test(cv, k),:); % Select the testing data from the diseases table as our target

    MLmodel = fitcnet(FeaturesTrain,TargetTrain,'LayerSizes',20);
    [TargetTestPredicted, ~] = predict(MLmodel,FeaturesTest); % use the trained model on the test set features
                                                                           
    CnfusionMatrix = confusionmat(TargetTest,TargetTestPredicted); % compute the confusion matrix
    confusionchart(CnfusionMatrix,unique(TargetTest),'RowSummary','row-normalized'); % show the confusion matrix with class labels
    shg % show confusion matrix

    l = loss(MLmodel, FeaturesTest, TargetTest);

    disp("Loss on split no. " + k + ": " + l)

    avgLoss = (1/K) * l + avgLoss;
end

disp("Average K-validated loss: " + avgLoss);