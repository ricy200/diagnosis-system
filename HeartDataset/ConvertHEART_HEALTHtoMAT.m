function ConvertHEART_HEALTHtoMAT ()

    all_symptoms_hh = {}; % to save the symptoms in a table
    all_symptoms_hh_index = 0;

    symptoms_hh = []; % to create the table with numbers
    symptoms_hh_index = 0;

    curr_file = fopen("heart_disease_health_indicators_BRFSS2015.csv"); % open the file


    line = fgetl(curr_file); % get first line

    curr_data=strsplit(line,',');

    for i = 1:size(curr_data,2) % create array with the symptoms
        if ~isempty(deblank(curr_data{1,i}))

            all_symptoms_hh_index = all_symptoms_hh_index + 1;

            all_symptoms_hh{all_symptoms_hh_index,1} = deblank(curr_data{1,i});
        end
    end

    fclose(curr_file); % close file 

    % open file again to reset pointer
    curr_file = fopen("heart_disease_health_indicators_BRFSS2015.csv");

    curr_line = fgetl(curr_file); % skip first line

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        symptoms_hh_index = symptoms_hh_index + 1; % for each line increase the line in table
        new_dat = str2double(curr_dat); %convert current data to double

        for i = 1:size(curr_dat,2) % insert data from csv file line per line
            symptoms_hh(symptoms_hh_index,i) = new_dat(1,i);
        end
    end

    fclose(curr_file); %close the file

%------------ Make the data balanced between sick and not sick:------------
    % As not sick people are overrepresented, we want to adjust the amount

    % get sick people
    wanted_num = find(symptoms_hh(:, 1) == 1);
    % get not sick people
    indicesToDelete = find(symptoms_hh(:, 1) == 0);
    
    % choose a sample to delete from not sick
    subsetIndices = datasample(indicesToDelete, ceil(numel(indicesToDelete)-numel(wanted_num)), 'Replace', false);
    
    % delete the sample
    symptoms_hh(subsetIndices, :) = [];

    % save the data
    save('heart-health_indicators.mat','symptoms_hh','all_symptoms_hh');
end
