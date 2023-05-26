function PrepareHeartUCI_Data()

   load('heart-disease_uci.mat')
   Data = symptoms_hu;

   %convert column 3 to numbers: female = 2, male = 1, no entry = -1
   for i=1:size(Data,1)
       if strcmp('Female',Data(i,3))
           Data(i,3) = mat2cell(2,1);
       elseif strcmp('Male', Data(i,3))
           Data(i,3)= mat2cell(1,1);
       else
           Data(i,3)= mat2cell(-1,1);
       end
   end

   %convert column 5 to numbers: typical angina = 1 atypical angina = 2
   %non-anginal = 3, asymptomatic = 4, no entry = -1
   for i=1:size(Data,1)
       if strcmp('typical angina',Data(i,5))
           Data(i,5) = mat2cell(1,1);
       elseif strcmp('atypical angina', Data(i,5))
           Data(i,5)= mat2cell(2,1);
       elseif strcmp('non-anginal', Data(i,5))
           Data(i,5) = mat2cell(3,1);
       elseif strcmp('asymptomatic', Data(i,5))
           Data(i,5) = mat2cell(4,1);
       else
           Data(i,5)= mat2cell(-1,1);
       end
   end

   %convert column 8 to numbers: TRUE=1, FALSE=2, no entry= -1
   for i=1:size(Data,1)
       if strcmp('TRUE',Data(i,8))
           Data(i,8) = mat2cell(1,1);
       elseif strcmp('FALSE', Data(i,8))
           Data(i,8)= mat2cell(2,1);
       else
           Data(i,8)= mat2cell(-1,1);
       end
   end

   %convert column 9 to numbers: normal=1, st-t abnormality=2, 
   % lv hypertrophy=3, no entry= -1
   for i=1:size(Data,1)
       if strcmp('normal',Data(i,9))
           Data(i,9) = mat2cell(1,1);
       elseif strcmp('st-t abnormality', Data(i,9))
           Data(i,9)= mat2cell(2,1);
       elseif strcmp('lv hypertrophy', Data(i,9))
           Data(i,9) = mat2cell(3,1);
       else
           Data(i,9)= mat2cell(-1,1);
       end
   end

   %convert column 11 to numbers: TRUE=1, FALSE=2, no entry= -1
    for i=1:size(Data,1)
       if strcmp('TRUE',Data(i,11))
           Data(i,11) = mat2cell(1,1);
       elseif strcmp('FALSE', Data(i,11))
           Data(i,11)= mat2cell(2,1);
       else
           Data(i,11)= mat2cell(-1,1);
       end
    end

    %convert column 13 to numbers: flat=1, upsloping=2, downsloping=3,
    % no entry= -1
    for i=1:size(Data,1)
        if strcmp('flat',Data(i,13))
            Data(i,13) = mat2cell(1,1);
        elseif strcmp('upsloping', Data(i,13))
            Data(i,13)= mat2cell(2,1);
        elseif strcmp('downsloping', Data(i,13))
            Data(i,13) = mat2cell(3,1);
        else
            Data(i,13)= mat2cell(-1,1);
        end
    end

    %convert column 15 to numbers: normal=1, fixed defect=2, 
    % reversable defect=3, no entry = -1
    for i=1:size(Data,1)
        if strcmp('normal',Data(i,15))
            Data(i,15) = mat2cell(1,1);
        elseif strcmp('fixed defect', Data(i,15))
            Data(i,15)= mat2cell(2,1);
        elseif strcmp('reversable defect', Data(i,15))
            Data(i,15) = mat2cell(3,1);
        else
            Data(i,15)= mat2cell(-1,1);
        end
    end

    % delete columns 1 and 4
    Data(:,[1 4]) = []; 
    all_symptoms_hu([1 4],:) = [];

    %convert everything to double
    for i=1:size(Data,1)
        Data(i,1) = mat2cell(str2double(Data(i,1)),1);
        Data(i,4) = mat2cell(str2double(Data(i,4)),1);
        Data(i,5) = mat2cell(str2double(Data(i,5)),1);
        Data(i,8) = mat2cell(str2double(Data(i,8)),1);
        Data(i,10) = mat2cell(str2double(Data(i,10)),1);
        Data(i,12) = mat2cell(str2double(Data(i,12)),1);
        Data(i,14) = mat2cell(str2double(Data(i,14)),1);
    end

    % convert to table and fill missing values (NaN) with -1)
    Dat_to_table = cell2table(Data);
    Dat = fillmissing(Dat_to_table, "constant",-1);
    % convert back to doubles (so in training predicted and tested values
    % have same type)
    Dat = table2array(Dat);
    
    save('prep-heart-diseasese_uci.mat',"all_symptoms_hu","Dat");
end