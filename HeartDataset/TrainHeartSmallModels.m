function TrainHeartSmallModels()

    load('prep-and-combine-heart.mat')

% split the data into training and test
   SplitSize = 0.20;
   cv = cvpartition(size(final_dat,1),'HoldOut',SplitSize);

   TestSymptoms = final_dat(cv.test,:);
   TrainSymptoms = final_dat(cv.training,:);

   % in x und y einteilen; y für target x für rest
   x_train = TrainSymptoms(:, 1:13);
   y_train = TrainSymptoms(:,14);
   x_test = TestSymptoms(:,1:13);
   y_test = TestSymptoms(:,14);

    %run the model
   % Mdl = fitcknn(x_train,y_train,"NumNeighbors",5); % KNN: accuracy: 0.6401
   % Mdl = fitcnet(x_train,y_train,"LayerSizes",20); % Neural network: accuracy: 0.7481
   % y_predict = predict(Mdl,x_test);
   Mdl = TreeBagger(50, x_train,y_train); % Decision Tree: accuracy: 0.8895
   % for TreeBagger
   y_predict = str2num( cell2mat(predict(Mdl, x_test))); 
   

   %Accuracy
   ConfusionMat = confusionmat(y_test,y_predict); % y_test is the known group, y_predict the unknown group of the Confusionmatrix
   chart = confusionchart(y_test,y_predict,'RowSummary','row-normalized');

   our_accuracy=0.0;

   for i=1:size(y_test,1)

       if y_test(i,1) == y_predict(i,1) %If they are equal we increase our "What was correct" part
            our_accuracy=our_accuracy+1;
        else
            y_test(i,1);
            y_predict(i,1);
       end
   end

    our_accuracy = our_accuracy/size(y_test,1); % calculate our accuracy
    our_accuracy %shows result in console

    save("TrainHeartSmallModels.mat", "Mdl", "all_symptoms_hu");

end