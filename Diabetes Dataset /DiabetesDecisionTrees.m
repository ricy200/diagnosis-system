
function DiabetesDecisionTrees()

    load('DiabetesDataset.mat', 'inputs', 'outputs') % load file
    rng("default") % for reproducibility of the partition

    SplitSize = 0.2; % 80% training data and 20% testing data split
    
    cv = cvpartition(size(inputs,1),'HoldOut',SplitSize); 

    FeaturesTrain = inputs(cv.training,:); % Select the training data (Parameters) from the table as features
    TargetTrain = outputs(cv.training,:); % Select the training data from the "Outcome2 column as target
    FeaturesTest = inputs(cv.test,:); % Select the testing data (Parameters) from the table as features
    TargetTest = outputs(cv.test,:); % Select the testing data from the "Outcome" column as target

    
    MLmodelTrees = TreeBagger(15,FeaturesTrain,TargetTrain); % ML model, bagged decicison trees

    [TargetTestPredictedCell, ~] = predict(MLmodelTrees,FeaturesTest); % use the trained model on the test set features
    TargetTestPredicted = str2double(TargetTestPredictedCell); % convert cell type to double 

    CnfusionMatrix = confusionmat(TargetTest,TargetTestPredicted); % compute the confusion matrix
    confusionchart(CnfusionMatrix,unique(TargetTest),'RowSummary','row-normalized'); % show the confusion matrix with class labels
    shg % show confusion matrix
    
    accuracy=0.0; % initialize accuracy 
    for i=1:size(TargetTest,1) % go over each element in the testing set

        if  TargetTest(i,1)==TargetTestPredicted(i,1) % test if the TargetTest and the predicted TargetTest are equal 
            accuracy=accuracy+1; % if they are equal, increase accuracy
        end                     

    end

    accuracy=accuracy/double(size(TargetTest,1)); % divide the correct outputs with the size of the Dataset for the accuracy

    accuracy % show the result in the console

    %save('DIAModelDecisionTrees.mat','MLmodelTrees') % save MLmodel

end