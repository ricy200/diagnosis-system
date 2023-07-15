function TrainHHI_MLModel
    % load file
    load('heart-health_indicators.mat','symptoms_hh','all_symptoms_hh') 
    % for reproducibility of the partition
    rng("default") 


    % Split into 80% training data and 20% testing data split
    SplitSize = 0.2;
    cv = cvpartition(size(symptoms_hh,1),'HoldOut',SplitSize);
    
    data_train = symptoms_hh(cv.training,:);
    data_test = symptoms_hh(cv.test,:);
    

    % Divide into Target and Features
    FeaturesTrain = data_train(:, 2:22); % (ROWS; COLUMNS)
    TargetTrain = data_train(:, 1);
    FeaturesTest = data_test(:, 2:22);
    TargetTest = data_test(:, 1);

    
    %----------------------------Models------------------------------------
    
    %ML Model, classification network, Accuracy: 0.7764
    MLmodel = fitcnet(FeaturesTrain,TargetTrain); 
    [TargetTestPredicted, ~] = predict(MLmodel,FeaturesTest)
    

    % Alternatives:
    % ML Model,  k-nearest neighbor classifier, Accuracy: 0.7230
    % MLmodel = fitcknn(FeaturesTrain,TargetTrain,"NumNeighbors",5)
    % [TargetTestPredicted, ~] = predict(MLmodel,FeaturesTest)

    % ML Model, Decision trees, Accuracy: 0.7542
    %MLmodel = TreeBagger(20, FeaturesTrain, TargetTrain);
    % Use our trained model on the test set features
    %[TargetTestPredictedfrst TargetTestScore] = predict(MLmodel,FeaturesTest);  
    %TargetTestPredicted = str2double(TargetTestPredictedfrst);
    
    %-------------------------Accuracy-------------------------------------

    % Compute the confusion matrix
    CnfusionMatrix = confusionmat(TargetTest,TargetTestPredicted); 
    % Show the confusion matrix with class labels
    confusionchart(CnfusionMatrix,unique(TargetTest),'RowSummary','row-normalized');
    
    % Accuracy: (True Positive+True Negative) / (True Positive+True Negative + False Positive + False Negative)
    % -> (What was correct) / (Dataset size)
    
    our_accuracy=0.0; % initialize accuracy
    for i=1:size(TargetTest,1) % go over each element in the testing set
        % test if the TargetTest and the predicted TargetTest are equal
        if  TargetTest(i,1)==TargetTestPredicted(i,1) 
            % if they are equal, increase accuracy
            our_accuracy=our_accuracy+1; 
        end
    
    end
    % divide the correct outputs with the size of the Dataset for the accuracy
    our_accuracy=our_accuracy/double(size(TargetTest,1));
    
    % Show the result in the console
    our_accuracy 
    
    save('HHI_MLModel.mat','MLmodel', 'all_symptoms_hh') %save MLmodel
    end
