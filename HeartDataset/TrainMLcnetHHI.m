function TrainMLcnetHHI()

    load('heart-health_indicators.mat','symptoms_hh','all_symptoms_hh') % load file
    rng("default") % for reproducibility of the partition

    SplitSize = 0.2; % 80% training data and 20% testing data split
    
    cv = cvpartition(size(symptoms_hh,1),'HoldOut',SplitSize); 

    data_train = symptoms_hh(cv.training,:);
    data_test = symptoms_hh(cv.test,:);

    FeaturesTrain = data_train(:, 2:22); % (ROWS; COLUMNS)
    TargetTrain = data_train(:, 1);
    FeaturesTest = data_test(:, 2:22);
    TargetTest = data_test(:, 1);


    MLmodel = fitcnet(FeaturesTrain,TargetTrain); % ML Model, classification network

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

    save('HHIModelNeuralNW.mat','MLmodel', 'all_symptoms_hh') %save MLmodel

end