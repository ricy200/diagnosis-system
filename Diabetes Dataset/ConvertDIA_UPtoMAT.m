function ConvertDIA_UPtoMAT ()

    all_symptoms_qu = {}; % to save the symptoms in a table
    all_symptoms_qu_index = 0;

    symptoms_qu = []; % to create the table with numbers
    symptoms_qu_index = 0;

    curr_file = fopen('diabetes-update.csv'); % open the file


    line = fgetl(curr_file); % get first line

    curr_data=strsplit(line,',');

    for i = 1:size(curr_data,2) % create array with the symptoms
        if ~isempty(deblank(curr_data{1,i}))

            all_symptoms_qu_index = all_symptoms_qu_index + 1;

            all_symptoms_qu{all_symptoms_qu_index,1} = deblank(curr_data{1,i});
        end
    end

    fclose(curr_file); % close file 

    % open file again to reset pointer
    curr_file = fopen("diabetes-update.csv");

    curr_line = fgetl(curr_file); % skip first line

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        symptoms_qu_index = symptoms_qu_index + 1; % for each line increase the line in table
        new_dat = str2double(curr_dat); %convert current data to double

        for i = 1:size(curr_dat,2) % insert data from csv file line per line
            symptoms_qu(symptoms_qu_index,i) = new_dat(1,i);
        end
    end

    fclose(curr_file); %close the file

    size(symptoms_qu)

    size(all_symptoms_qu)
    size(curr_data)

    save('diabetes-update.mat','symptoms_qu','all_symptoms_qu');

end