function PrepareandCombineSmallHeartData()

  load('heart-disease_uci.mat')
   Data = symptoms_hu;
   % convert heart_uci properly: from strings to same numbers as
   % heart-dataset

   %convert column 3 to numbers: female = 0, male = 1, no entry = -1
   for i=1:size(Data,1)
       if strcmp('Female',Data(i,3))
           Data(i,3) = mat2cell(0,1);
       elseif strcmp('Male', Data(i,3))
           Data(i,3)= mat2cell(1,1);
       else
           Data(i,3)= mat2cell(-1,1);
       end
   end

   %convert column 5 to numbers: typical angina = 0 atypical angina = 1
   %non-anginal = 2, asymptomatic = 3, no entry = -1
   for i=1:size(Data,1)
       if strcmp('typical angina',Data(i,5))
           Data(i,5) = mat2cell(0,1);
       elseif strcmp('atypical angina', Data(i,5))
           Data(i,5)= mat2cell(1,1);
       elseif strcmp('non-anginal', Data(i,5))
           Data(i,5) = mat2cell(2,1);
       elseif strcmp('asymptomatic', Data(i,5))
           Data(i,5) = mat2cell(3,1);
       else
           Data(i,5)= mat2cell(-1,1);
       end
   end

   %convert column 8 to numbers: TRUE=1, FALSE=0, no entry= -1
   for i=1:size(Data,1)
       if strcmp('TRUE',Data(i,8))
           Data(i,8) = mat2cell(1,1);
       elseif strcmp('FALSE', Data(i,8))
           Data(i,8)= mat2cell(0,1);
       else
           Data(i,8)= mat2cell(-1,1);
       end
   end

   %convert column 9 to numbers: normal=0, st-t abnormality=1, 
   % lv hypertrophy=2, no entry= -1
   for i=1:size(Data,1)
       if strcmp('normal',Data(i,9))
           Data(i,9) = mat2cell(0,1);
       elseif strcmp('st-t abnormality', Data(i,9))
           Data(i,9)= mat2cell(1,1);
       elseif strcmp('lv hypertrophy', Data(i,9))
           Data(i,9) = mat2cell(2,1);
       else
           Data(i,9)= mat2cell(-1,1);
       end
   end

   %convert column 11 to numbers: TRUE=1, FALSE=0, no entry= -1
    for i=1:size(Data,1)
       if strcmp('TRUE',Data(i,11))
           Data(i,11) = mat2cell(1,1);
       elseif strcmp('FALSE', Data(i,11))
           Data(i,11)= mat2cell(0,1);
       else
           Data(i,11)= mat2cell(-1,1);
       end
    end

    %convert column 13 to numbers: upsloping=0, flat=1, downsloping=2
    % no entry= -1
    for i=1:size(Data,1)
        if strcmp('upsloping',Data(i,13))
            Data(i,13) = mat2cell(0,1);
        elseif strcmp('flat', Data(i,13))
            Data(i,13)= mat2cell(1,1);
        elseif strcmp('downsloping', Data(i,13))
            Data(i,13) = mat2cell(2,1);
        else
            Data(i,13)= mat2cell(-1,1);
        end
    end

    %convert column 15 to numbers: normal=0, fixed defect=1, 
    % reversable defect=2, no entry = -1
    for i=1:size(Data,1)
        if strcmp('normal',Data(i,15))
            Data(i,15) = mat2cell(0,1);
        elseif strcmp('fixed defect', Data(i,15))
            Data(i,15)= mat2cell(1,1);
        elseif strcmp('reversable defect', Data(i,15))
            Data(i,15) = mat2cell(2,1);
        else
            Data(i,15)= mat2cell(-1,1);
        end
    end

    str2double(Data(1,16))

    %convert target column 16 from 5 values to 2: no disease = 0, disease = 1
     for i=1:size(Data,1)
        if (1 == str2double(Data(i,16))) || (2 == str2double(Data(i,16))) || (3 == str2double(Data(i,16))) || (4 == str2double(Data(i,16)))
            Data(i,16) = mat2cell(1,1);
        elseif (0 == str2double(Data(i,16)))
            Data(i,16)= mat2cell(0,1);
        else
            Data(i,16) = mat2cell(-1,1);
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
    end

    % convert to table and fill missing values (NaN) with -1)
    Dat_to_table = cell2table(Data);
    Datt = fillmissing(Dat_to_table, "constant",-1);
    % convert back to doubles to combine with other dataset
    Datt = table2array(Datt);

    % combine heart-dataset and heart-uci data 
    load("heart-dataset.mat")

    final_dat = cat(1,Datt,symptoms_h);

    save('prep-and-combine-heart.mat',"all_symptoms_hu","final_dat");
end
