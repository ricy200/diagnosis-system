function TrainMLmodel_LS ()
    
    load('converted Lumpy skin disease data.mat');

    rng(1); % set the random generator initialization to 1

    SplitSize = 0.2; % split to 80% training data and 20% testing data
    cv = cvpartition(size(target_ls,1),'HoldOut',SplitSize);

    FeaturesTrain = symptoms_ls(cv.training, :); % training data from symptoms table as features
    TargetTrain = target_ls(cv.training, :); % training data from from target table as target
    FeaturesTest = symptoms_ls(cv.test, :); % testing data from symptoms table as features
    TargetTest = target_ls(cv.test, :); % testing data from target table as target

   % training different models
    MLmodel_ls = TreeBagger(50, FeaturesTrain, TargetTrain); % decision trees
   %     MLmodel_ls = fitcnet(FeaturesTrain,TargetTrain,'LayerSizes',20); 
   %     neural network somehow doesn't work
   % MLmodel_ls = fitcknn(FeaturesTrain, TargetTrain, "NumNeighbors", 5);
   % k-nearest neighbors

   [TargetTestPredictedC ~ ] = predict(MLmodel_ls,FeaturesTest);
   TargetTestPredicted = str2double(TargetTestPredictedC); %str2double only needed for TreeBagger, not for knn

   CnfusionMatrix = confusionmat(TargetTest,TargetTestPredicted); % confusion matrix
   confusionchart(CnfusionMatrix,unique(TargetTest),'RowSummary','row-normalized'); % show confusion matrix

  % save("test_DataForML_ls.mat", "FeaturesTrain", "TargetTrain", "FeaturesTest", "TargetTest", 'TargetTestPredicted');

   ls_accuracy = 0.0; % set inital accurary to 0.0
   
   for i=1:size(TargetTest, 1)

       if TargetTest(i, 1) == TargetTestPredicted(i, 1) % if tested target equals predicted target increase accuracy
           ls_accuracy = ls_accuracy + 1;
       end
   end
   
   ls_accuracy = ls_accuracy/double(size(TargetTest, 1)); %calculate acutal accuracy of ML model
   ls_accuracy %show accuracy in console

   save('LS_MLmodel.mat', 'MLmodel_ls', 'all_symptoms_ls');

end