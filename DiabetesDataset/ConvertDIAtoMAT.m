function ConvertDIAtoMAT ()

    all_symptoms_q = {}; % to save the symptoms in a table
    all_symptoms_q_index = 0;

    symptoms_q = []; % to create the table with numbers
    symptoms_q_index = 0;

    curr_file = fopen('diabetes-dataset.csv'); % open the file


    line = fgetl(curr_file); % get first line

    curr_data=strsplit(line,',');

    for i = 1:size(curr_data,2) % create array with the symptoms
        if ~isempty(deblank(curr_data{1,i}))

            all_symptoms_q_index = all_symptoms_q_index + 1;

            all_symptoms_q{all_symptoms_q_index,1} = deblank(curr_data{1,i});
        end
    end

    fclose(curr_file); % close file 

    % open file again to reset pointer
    curr_file = fopen("diabetes-dataset.csv");

    curr_line = fgetl(curr_file); % skip first line

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        symptoms_q_index = symptoms_q_index + 1; % for each line increase the line in table
        new_dat = str2double(curr_dat); %convert current data to double

        for i = 1:size(curr_dat,2) % insert data from csv file line per line
            symptoms_q(symptoms_q_index,i) = new_dat(1,i);
        end
    end

    fclose(curr_file); %close the file

    size(symptoms_q)

    size(all_symptoms_q)
    size(curr_data)

    save('diabetes-dataset.mat','symptoms_q','all_symptoms_q');

end