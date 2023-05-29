
function DiabetesMLmodel()

    load('DiabetesDataset.mat', 'inputs', 'outputs')
    rng("default")  % reproducibility of the partition

    SplitSize = 0.2;

    disp(size(outputs, 1));
    
    cv = cvpartition(size(inputs,1),'HoldOut',SplitSize); % This computes random indexes for the train and test set based on our amount of entries

    FeaturesTrain = inputs(cv.training,:); % Select the training data from the symptoms table as our features
    TargetTrain = outputs(cv.training,:); % Select the training data from the diseases table as our target
    FeaturesTest = inputs(cv.test,:); % Select the testing data from the symptoms table as our features
    TargetTest = outputs(cv.test,:); % Select the testing data from the diseases table as our target
    
    Mdl = fitcnet(FeaturesTrain,TargetTrain);

    trainingLoss = loss(Mdl, FeaturesTrain, TargetTrain);
    testingLoss = loss(Mdl, FeaturesTest, TargetTest);

    trainingAccuracy = 1-trainingLoss;
    testingAccuracy = 1-testingLoss;

    disp("Training accuracy: " + trainingAccuracy)
    disp("Testing accuracy: " + testingAccuracy);