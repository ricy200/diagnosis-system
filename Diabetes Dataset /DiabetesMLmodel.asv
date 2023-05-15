
function DiabetesMLmodel()

    load('DiabetesDataset.mat', 'inputs', 'outputs') % load file
    rng("default") % for reproducibility of the partition

    SplitSize = 0.2; % split for Testdata (20%)
    
    cv = cvpartition(size(inputs,1),'HoldOut',SplitSize); 

    FeaturesTrain = inputs(cv.training,:); % Select the training data (Parameters) from the table as our features
    TargetTrain = outputs(cv.training,:); % Select the training data from the Outcome column as our target
    FeaturesTest = inputs(cv.test,:); % Select the testing data (Parameters) from the table as our features
    TargetTest = outputs(cv.test,:); % Select the testing data from the Outcome column as our target
    
    Mdl = fitcnet(FeaturesTrain,TargetTrain); % ML Model, classification network

    trainingLoss = loss(Mdl, FeaturesTrain, TargetTrain); % observe training loss
    testingLoss = loss(Mdl, FeaturesTest, TargetTest); % observe testing loss

    trainingAccuracy = 1-trainingLoss;
    testingAccuracy = 1-testingLoss;

    disp("Training accuracy: " + trainingAccuracy) % output training accuracy
    disp("Testing accuracy: " + testingAccuracy); % output testing accuracy 