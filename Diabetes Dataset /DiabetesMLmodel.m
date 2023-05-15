
function DiabetesMLmodel()

    load('DiabetesDataset.mat', 'inputs', 'outputs') % load file
    rng("default") % for reproducibility of the partition

    SplitSize = 0.2; % 80% training data and 20% testing data split
    
    cv = cvpartition(size(inputs,1),'HoldOut',SplitSize); 

    FeaturesTrain = inputs(cv.training,:); % Select the training data (Parameters) from the table as features
    TargetTrain = outputs(cv.training,:); % Select the training data from the Outcome column as target
    FeaturesTest = inputs(cv.test,:); % Select the testing data (Parameters) from the table as features
    TargetTest = outputs(cv.test,:); % Select the testing data from the Outcome column as target
    
    MLmodel = fitcnet(FeaturesTrain,TargetTrain,'LayerSizes',[15 27]); % ML Model, classification network

    [TargetTestPredicted, ~] = predict(MLmodel,FeaturesTest); % use the trained model on the test set features
                                                                           
    CnfusionMatrix = confusionmat(TargetTest,TargetTestPredicted); % compute the confusion matrix
    confusionchart(CnfusionMatrix,unique(TargetTest),'RowSummary','row-normalized'); % show the confusion matrix with class labels
    shg % show confusion matrix
    trainingLoss = loss(MLmodel, FeaturesTrain, TargetTrain); % observe training loss
    testingLoss = loss(MLmodel, FeaturesTest, TargetTest); % observe testing loss

    trainingAccuracy = 1-trainingLoss; % compute training accuracy 
    testingAccuracy = 1-testingLoss; % compute testing accuracy 

    disp("Training accuracy: " + trainingAccuracy) % output training accuracy
    disp("Testing accuracy: " + testingAccuracy); % output testing accuracy 

    save('DIAModelNeuralNW.mat','MLmodel') %save MLmodel

end