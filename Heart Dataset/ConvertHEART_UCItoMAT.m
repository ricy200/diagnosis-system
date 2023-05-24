function ConvertHEART_UCItoMAT ()

    all_symptoms_hu = {}; % to save the symptoms in a table
    all_symptoms_hu_index = 0;

    symptoms_hu = {}; % to create the table with numbers
    symptoms_hu_index = 0;

    curr_file = fopen("heart_disease_uci.csv"); % open the file


    line = fgetl(curr_file); % get first line

    curr_data=strsplit(line,',');

    for i = 1:size(curr_data,2) % create array with the symptoms
        if ~isempty(deblank(curr_data{1,i}))

            all_symptoms_hu_index = all_symptoms_hu_index + 1;

            all_symptoms_hu{all_symptoms_hu_index,1} = deblank(curr_data{1,i});
        end
    end

    fclose(curr_file); % close file 

    % open file again to reset pointer
    curr_file = fopen("heart_disease_uci.csv");

    curr_line = fgetl(curr_file); % skip first line

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file
<<<<<<< HEAD
        
        %split the read line on all ','; several ,,, are not treates as one
        curr_dat=strsplit(curr_line,',','CollapseDelimiters',false); 
        
        
        symptoms_hu_index = symptoms_hu_index + 1; % for each line increase the line in table

        for i = 1:size(curr_dat,2) % insert data from csv file line per line
            if isempty (curr_dat(1,i))
                symptoms_hu(symptoms_hu_index,i) = mat2cell(-1,1);
            else
                symptoms_hu(symptoms_hu_index,i) = curr_dat(1,i);
            end
=======

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        symptoms_hu_index = symptoms_hu_index + 1; % for each line increase the line in table

        for i = 1:size(curr_dat,2) % insert data from csv file line per line
            symptoms_hu(symptoms_hu_index,i) = curr_dat(1,i);
>>>>>>> parent of aa9fed1... Delete ConvertHEART_UCItoMAT.m since it had errors
        end
    end

    fclose(curr_file); %close the file

    %size(symptoms_hu)
    %size(all_symptoms_hu)
    %size(curr_data)

    save('heart-disease_uci.mat','symptoms_hu','all_symptoms_hu');
end
