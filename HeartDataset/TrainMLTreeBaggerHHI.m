function TrainMLTreeBaggerHHI
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

        MLmodel = TreeBagger(20, FeaturesTrain, TargetTrain);

        [TargetTestPredictedfrst TargetTestScore] = predict(MLmodel,FeaturesTest); % Use our trained model on the test set features
    %     TargetTestScore; %This is the probability of the class based on the model
        TargetTestPredicted = str2double(TargetTestPredictedfrst);
    
        CnfusionMatrix = confusionmat(TargetTest,TargetTestPredicted);%Compute the confusion matrix (What have we done right and what have we done wrong)
        confusionchart(CnfusionMatrix,unique(TargetTest),'RowSummary','row-normalized'); %Show the confusion matrix with class labels
    %     confusionchart(CnfusionMatrix,'RowSummary','row-normalized'); %Show the confusion matrix without class labels
        
        %Accuracy example
        %Is defined as (True Positive+True Negative) / (True Positive+True Negative + False Positive + False Negative)
        % In other words this means, (What was correct) / (Dataset size)
    
        our_accuracy=0.0; % initialize accuracy 
        for i=1:size(TargetTest,1) % go over each element in the testing set
    
            if  TargetTest(i,1)==TargetTestPredicted(i,1) % test if the TargetTest and the predicted TargetTest are equal 
                our_accuracy=our_accuracy+1; % if they are equal, increase accuracy
            end                     
    
        end
    
        our_accuracy=our_accuracy/double(size(TargetTest,1)); % divide the correct outputs with the size of the Dataset for the accuracy

    
        our_accuracy % Show the result in the console
    
        save('HHIModelTreeBagger.mat','MLmodel', 'all_symptoms_hh') %save MLmodel
end 
