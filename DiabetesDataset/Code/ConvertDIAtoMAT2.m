function ConvertDIAtoMAT2 ()

    inputs = zeros(2768, 8); % allocate the table with the diabetes parameters 
    inputs_index = 0;

    outputs = zeros(2768, 1); % allocate the column with the variable "Outcome" for prediction
    all_parameters = []; % to save the parameters in a table
    all_parameters_index = 0;

    curr_file = fopen('DiabetesDataset.csv'); % open the file

    line = fgetl(curr_file); % get first line

    curr_data=strsplit(line,',');

    for i = 1:(size(curr_data,2) -1) % create array with the parameters
        if ~isempty(deblank(curr_data{1,i}))

            all_parameters_index = all_parameters_index + 1;

            all_parameters{all_parameters_index,1} = deblank(curr_data{1,i});
        end
    end

    fclose(curr_file); % close file 


    curr_file = fopen("DiabetesDataset.csv"); % reopen file

    curr_line = fgetl(curr_file); % skip first line

    while ~feof(curr_file)

        curr_line=fgetl(curr_file); %get current line in the file

        curr_dat=strsplit(curr_line,','); %split the read line on all ','

        inputs_index = inputs_index + 1; % for each line increase the line in table
        new_dat = str2double(curr_dat); %convert current data to double

        lastEntry = size(curr_dat,2);

        for i = 1:(lastEntry - 1) % insert data from csv file line per line for the input parameters
            inputs(inputs_index,i) = new_dat(1,i); 

        end

        outputs(inputs_index, 1) = new_dat(1, lastEntry); % insert the Outcome parameter as predictor (output)
    end

    fclose(curr_file); %close the file

    save('DiabetesDataset/Dataset and Models/DiabetesDataset.mat','inputs', 'outputs', 'all_parameters'); % save the tables for inputs and outputs

end