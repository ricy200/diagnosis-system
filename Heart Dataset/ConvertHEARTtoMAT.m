function ConvertHEARTtoMAT ()

    all_symptoms_h = {}; % to save the symptoms in a table
    all_symptoms_h_index = 0;

    symptoms_h = []; % to create the table with numbers
    symptoms_h_index = 0;

    curr_file = fopen('heart.csv'); % open the file


    line = fgetl(curr_file); % get first line

    curr_data=strsplit(line,',');

    for i = 1:size(curr_data,2) % create array with the symptoms
        if ~isempty(deblank(curr_data{1,i}))

            all_symptoms_h_index = all_symptoms_h_index + 1;

            all_symptoms_h{all_symptoms_h_index,1} = deblank(curr_data{1,i});
        end
    end

    fclose(curr_file); % close file 

    % open file again to reset pointer
    curr_file = fopen("heart.csv");

    curr_line = fgetl(curr_file); % skip first line

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        symptoms_h_index = symptoms_h_index + 1; % for each line increase the line in table
        new_dat = str2double(curr_dat); %convert current data to double

        for i = 1:size(curr_dat,2) % insert data from csv file line per line
            symptoms_h(symptoms_h_index,i) = new_dat(1,i);
        end
    end

    fclose(curr_file); %close the file

    %size(symptoms_h)
    %size(all_symptoms_h)
    %size(curr_data)

    save('heart-dataset.mat','symptoms_h','all_symptoms_h');
end
